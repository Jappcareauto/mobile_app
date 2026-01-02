import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/functions.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/chat/application/command/get_chatroom_by_appointment_id.command.dart';
import 'package:jappcare/features/chat/application/usecases/get_chatroom_by_appointment_id.usecase.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room.entity.dart';
import 'package:jappcare/features/chat/application/command/get_all_chatroom_messages.command.dart';
import 'package:jappcare/features/chat/application/usecases/get_all_chatroom_messages.usecase.dart';
import 'package:jappcare/features/chat/application/usecases/get_real_time_message.usecase.dart';
import 'package:jappcare/features/chat/application/usecases/send_message.usecase.dart';
import 'package:jappcare/features/chat/domain/core/utils/chat_constants.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room_messages.entity.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:jappcare/features/workshop/application/usecases/get_vehicul_by_id_usecase.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirm_appointment_controller.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:jappcare/features/chat/domain/entities/chat_list_item.dart';
import 'package:jappcare/features/chat/domain/entities/waveform_data.dart';
import 'package:jappcare/core/services/networkServices/network_service.dart';

enum WebSocketStatus { connecting, connected, disconnected, error }

class ChatDetailsController extends GetxController {
  StompClient? _stompClient;
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  final LocalStorageService _localStorage = Get.find<LocalStorageService>();
  final NetworkService _networkService = Get.find<NetworkService>();

  // Expose stompClient null check for UI debugging
  bool get isStompClientNull => _stompClient == null;

  // Use cases
  final GetVehiculByIdUseCase getVehiculByIdUseCase =
      GetVehiculByIdUseCase(Get.find());
  final SendMessageUseCase sendMessageUseCase = SendMessageUseCase(Get.find());
  final GetRealTimeMessageUseCase getRealTimeMessageUseCase =
      GetRealTimeMessageUseCase(Get.find());
  final GetAllChatRoomMessagesUseCase _getAllMessagesUseCase =
      GetAllChatRoomMessagesUseCase(Get.find());
  final GetChatRoomByAppointmentIdUseCase _getChatRoomByAppointmentIdUseCase =
      GetChatRoomByAppointmentIdUseCase(Get.find());

  // Observable variables
  final Rx<WebSocketStatus> connectionStatus = WebSocketStatus.disconnected.obs;
  final RxBool isReconnecting = false.obs;
  final RxInt reconnectAttempts = 0.obs;
  final loading = false.obs;
  final appointmentLoading = false.obs;
  final selectedMethod = 'Orange Money'.obs;
  final RxList<File> selectedImages = <File>[].obs;
  final RxList<ChatMessageEntity> messages = <ChatMessageEntity>[].obs;
  final RxList<ChatListItem> flattenedItems = <ChatListItem>[].obs;

  late AppointmentEntity appointment;
  late ChatRoomEntity chatRoom;
  final currentUser = Get.find<ProfileController>().userInfos;

  // Configuration
  final int maxReconnectAttempts = 5;
  final Duration reconnectDelay = const Duration(seconds: 10);
  final Duration heartbeatInterval = const Duration(seconds: 30);
  final int messagesPerPage = 20;
  final RxBool isLoadingMore = false.obs;

  // Stream controllers
  final StreamController<Map<String, dynamic>> _messageController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _typingController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _presenceController =
      StreamController<Map<String, dynamic>>.broadcast();

  // Public streams
  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;
  Stream<Map<String, dynamic>> get typingStream => _typingController.stream;
  Stream<Map<String, dynamic>> get presenceStream => _presenceController.stream;

  // Voice recording
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final RxBool isRecording = false.obs;
  final RxBool isPlaying = false.obs;
  final RxString recordingDuration = '00:00'.obs;
  final RxDouble playbackProgress = 0.0.obs;
  final Rx<Duration> currentPosition = Duration.zero.obs;
  final Rx<Duration> totalDuration = Duration.zero.obs;
  final RxString currentlyPlayingId = ''.obs;

  // Waveform visualization
  final RxBool isRecordingLocked = false.obs; // For slide-to-cancel
  final RxDouble recordingCancelProgress = 0.0.obs;
  final RxBool showVoiceRecordingUI = false.obs;
  final Rx<WaveformData?> currentWaveformData = Rx<WaveformData?>(null);

  // Recording options
  final int waveformSampleRate = 44100;
  final int maxRecordingDuration = 300; // 5 minutes in seconds
  Timer? _recordingTimer;
  Timer? _amplitudeTimer;

  // Lifecycle and Stream Subscriptions
  late StreamSubscription<PlayerState> _stateSubscription;
  late StreamSubscription<Duration?> _durationSubscription;
  late StreamSubscription<Duration> _positionSubscription;

  final ConfirmAppointmentController confirmAppointmentController =
      ConfirmAppointmentController(Get.find());
  final AppNavigation _appNavigation;

  ChatDetailsController(this._appNavigation);

  @override
  void onInit() {
    super.onInit();
    loading.value = true;
    appointment = Get.arguments;
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await getChatRoomByAppointmentId();
      _initializeAudio();
      _setupScrollListener();
    } catch (e) {
      // Debug log removed
    }
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels <=
              scrollController.position.minScrollExtent &&
          !isLoadingMore.value) {
        _loadMoreMessages();
      }
    });
  }

  Future<void> _loadMoreMessages() async {
    if (isLoadingMore.value) return;

    isLoadingMore.value = true;
    // Implement pagination logic here using offset/limit
    // For now, we'll just wait and set false
    await Future.delayed(const Duration(seconds: 1));
    isLoadingMore.value = false;
  }

  @override
  void onClose() {
    // Disconnect WebSocket
    if (_stompClient != null) {
      try {
        _stompClient?.deactivate();
      } catch (_) {}
      _stompClient = null;
      connectionStatus.value = WebSocketStatus.disconnected;
      Future.delayed(Duration.zero, () {
        isReconnecting.value = false;
        reconnectAttempts.value = 0;
      });
    }

    // Cancel audio subscriptions
    try {
      _stateSubscription.cancel();
      _durationSubscription.cancel();
      _positionSubscription.cancel();
    } catch (_) {}

    // Dispose audio resources
    try {
      _audioRecorder.dispose();
      _audioPlayer.dispose();
    } catch (_) {}

    // Dispose controllers
    try {
      messageController.dispose();
      scrollController.dispose();
    } catch (_) {}

    // Close stream controllers
    try {
      _messageController.close();
      _typingController.close();
      _presenceController.close();
    } catch (_) {}

    super.onClose();
  }

  void scrollToBottom({bool animated = true}) {
    if (!scrollController.hasClients) return;

    try {
      final position = scrollController.position.maxScrollExtent;

      // If we're already very close to the bottom, snap exactly to bottom
      if (scrollController.offset > position - 50) {
        scrollController.jumpTo(position);
        return;
      }

      if (animated) {
        scrollController
            .animateTo(
          position,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        )
            .catchError((e) {
          // If animation fails, try immediate jump
          if (scrollController.hasClients) {
            scrollController.jumpTo(position);
          }
        });
      } else {
        scrollController.jumpTo(position);
      }
    } catch (_) {}
  }

  void _connectToWebSocket() {
    if (connectionStatus.value == WebSocketStatus.connecting) return;

    try {
      connectionStatus.value = WebSocketStatus.connecting;

      final token = _localStorage.read(AppConstants.tokenKey);
      if (token == null) throw Exception("Token not found");

      // Use HTTPS URL with explicit port :443 to fix stomp_dart_client's port:0 bug
      // The library's SockJsUtils.generateTransportUrl() returns port 0 for URLs without explicit port
      const wsUrl = 'https://bpi.jappcare.com:443/ws';

      _stompClient = StompClient(
        config: StompConfig.sockJS(
          url: wsUrl,
          onConnect: onConnected,
          onWebSocketError: (dynamic error) {
            // Debug log removed
            connectionStatus.value = WebSocketStatus.error;
            _scheduleReconnect();
          },
          onStompError: (StompFrame frame) {
            // Debug log removed
            connectionStatus.value = WebSocketStatus.error;
            _scheduleReconnect();
          },
          onDisconnect: (StompFrame frame) {
            connectionStatus.value = WebSocketStatus.disconnected;
            _scheduleReconnect();
          },
          stompConnectHeaders: {'Authorization': 'Bearer $token'},
          webSocketConnectHeaders: {'Authorization': 'Bearer $token'},
        ),
      );

      _stompClient!.activate();
    } catch (e) {
      // Debug log removed
      connectionStatus.value = WebSocketStatus.error;
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    if (reconnectAttempts.value >= maxReconnectAttempts ||
        isReconnecting.value) {
      return;
    }

    isReconnecting.value = true;
    reconnectAttempts.value++;

    Future.delayed(
      Duration(seconds: reconnectDelay.inSeconds * reconnectAttempts.value),
      () {
        isReconnecting.value = false;
        _connectToWebSocket();
      },
    );
  }

  /// Manual reconnect triggered by user
  void reconnect() {
    // Reset attempts and reconnect immediately
    reconnectAttempts.value = 0;
    isReconnecting.value = false;
    _connectToWebSocket();
  }

  void disconnect() {
    if (_stompClient != null) {
      _stompClient!.deactivate();
      _stompClient = null;
    }
    connectionStatus.value = WebSocketStatus.disconnected;
    isReconnecting.value = false;
    reconnectAttempts.value = 0;
  }

  void onConnected(StompFrame frame) {
    connectionStatus.value = WebSocketStatus.connected;
    reconnectAttempts.value = 0;
    subscribeToTopic();
  }

  void subscribeToTopic() {
    final topicDestination = '${ChatConstants.chatRoomTopic}/${chatRoom.id}';

    _stompClient?.subscribe(
      destination: topicDestination,
      callback: (StompFrame frame) {
        if (frame.body == null) return;

        try {
          final messageData = json.decode(frame.body!);
          final chatMessage = ChatMessageEntity.fromJson(messageData);

          // Check if message already exists by ID (avoid duplicates)
          final existingIndex =
              messages.indexWhere((m) => m.id == chatMessage.id);
          if (existingIndex != -1) {
            messages[existingIndex] = chatMessage;
            _updateFlattenedItems();
            return;
          }

          // Check if this is our own message that we sent optimistically
          // Remove optimistic message if this is the server confirmation
          if (chatMessage.senderId == currentUser?.id) {
            final optimisticIndex = messages.indexWhere((m) =>
                m.id.startsWith('temp_') &&
                m.senderId == currentUser?.id &&
                m.content == chatMessage.content &&
                m.type == chatMessage.type);

            if (optimisticIndex != -1) {
              final optimisticMessage = messages[optimisticIndex];

              // If the server message has no valid media URL but the optimistic one does,
              // preserve the optimistic media URL (since we know it works from the upload)
              ChatMessageEntity finalMessage = chatMessage;
              if (!chatMessage.hasMedia && optimisticMessage.hasMedia) {
                finalMessage = ChatMessageEntity.create(
                  id: chatMessage.id,
                  senderId: chatMessage.senderId,
                  content: chatMessage.content,
                  chatRoomId: chatMessage.chatRoomId,
                  type: chatMessage.type,
                  timestamp: chatMessage.timestamp,
                  createdBy: chatMessage.createdBy,
                  updatedBy: chatMessage.updatedBy,
                  createdAt: chatMessage.createdAt,
                  updatedAt: chatMessage.updatedAt,
                  appointmentId: chatMessage.appointmentId,
                  sender: chatMessage.sender,
                  duration: chatMessage.duration,
                  mediaUrl:
                      optimisticMessage.mediaUrl, // Preserve the working URL
                  mediaUrls: optimisticMessage.mediaUrls,
                );
              }

              messages[optimisticIndex] = finalMessage;
              _updateFlattenedItems();
              return;
            }
          }

          // Check if we're already near bottom before adding message
          final isNearBottom = scrollController.hasClients &&
              scrollController.offset >=
                  scrollController.position.maxScrollExtent - 100;

          messages.add(chatMessage);
          _updateFlattenedItems();

          // Only auto-scroll if we were already near bottom
          if (isNearBottom) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollToBottom(animated: true);
            });
          }
        } catch (e) {
          // Debug log removed
        }
      },
    );
  }

  void _updateFlattenedItems() {
    final groupedMessages = groupMessages(messages);
    final items = <ChatListItem>[];

    for (final entry in groupedMessages.entries) {
      items.add(DateHeaderItem(entry.key));
      items.addAll(entry.value.map((m) => MessageItem(m)));
    }

    flattenedItems.value = items;
  }

  Map<String, List<ChatMessageEntity>> groupMessages(
      List<ChatMessageEntity> messages) {
    final sorted = List<ChatMessageEntity>.from(messages)
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    final grouped = <String, List<ChatMessageEntity>>{};
    for (final message in sorted) {
      final date =
          DateTime.parse(message.createdAt).toLocal().toString().split(' ')[0];
      grouped.putIfAbsent(date, () => []).add(message);
    }
    return grouped;
  }

  Future<void> getAllMessages(String chatRoomId) async {
    loading.value = true;
    try {
      final result = await _getAllMessagesUseCase.call(
        GetAllChatroomMessagesCommand(chatroom: chatRoomId),
      );

      result.fold(
        (error) {
          loading.value = false;
          if (Get.context != null) {
            Get.showCustomSnackBar(error.message);
          }
        },
        (response) {
          // Update data
          messages.value = response.data;
          _updateFlattenedItems();
          loading.value = false;

          // Wait for next frame to ensure list is built
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Wait a short moment for images to start loading
            Future.delayed(const Duration(milliseconds: 100), () {
              scrollToBottom(animated: false);
            });
          });
        },
      );
    } catch (e) {
      loading.value = false;
      // Debug log removed
    }
  }

  void sendMessage(String content) {
    if (_stompClient == null ||
        connectionStatus.value != WebSocketStatus.connected ||
        content.isEmpty) {
      return;
    }

    final messageData = {
      'senderId': currentUser?.id,
      'content': content,
      'type': 'TEXT',
      'fileIds': [],
    };

    try {
      final destination =
          '${ChatConstants.chatMessageDestination}/${chatRoom.id}/sendMessage';

      _stompClient!.send(
        destination: destination,
        body: json.encode(messageData),
      );

      messageController.clear();
      scrollToBottom();
    } catch (e) {
      // Debug log removed
      Get.snackbar('Error', 'Failed to send message');
    }
  }

  // Voice message handling
  void _initializeAudio() {
    _audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
      if (_audioPlayer.duration != null) {
        playbackProgress.value =
            position.inMilliseconds / _audioPlayer.duration!.inMilliseconds;
      }
    });

    _stateSubscription = _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
      if (state.processingState == ProcessingState.completed) {
        currentlyPlayingId.value = '';
        playbackProgress.value = 0.0;
        currentPosition.value = Duration.zero;
        _audioPlayer.stop();
      }
    });

    _durationSubscription = _audioPlayer.durationStream.listen((duration) {
      totalDuration.value = duration ?? Duration.zero;
    });

    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
    });
  }

  Future<bool> _requestMicPermissions() async {
    final status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }

  Future<void> startRecording() async {
    try {
      if (!await _requestMicPermissions()) {
        Get.snackbar('Permission Denied', 'Microphone permission is required');
        return;
      }

      // Reset recording state
      isRecordingLocked.value = false;
      recordingCancelProgress.value = 0.0;
      showVoiceRecordingUI.value = true;
      currentWaveformData.value = null;

      // Initialize waveform with silent data
      final initialSamples = Float32List.fromList(
        List.generate(50, (i) => 0.0),
      );
      currentWaveformData.value = WaveformData.fromPcmSamples(
        samples: initialSamples,
        sampleRate: waveformSampleRate,
        duration: const Duration(milliseconds: 100),
      );

      final tempDir = await getTemporaryDirectory();
      final filePath =
          '${tempDir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: filePath,
      );

      isRecording.value = true;
      _startRecordingTimer();
      _startAmplitudeMonitoring();

      // Haptic feedback for recording start
      HapticFeedback.mediumImpact();
    } catch (e) {
      // Debug log removed
      Get.snackbar('Error', 'Failed to start recording');
      _resetRecordingState();
    }
  }

  Future<void> stopRecording({bool cancelled = false}) async {
    try {
      final path = await _audioRecorder.stop();

      if (path != null && !cancelled) {
        try {
          // Generate waveform data for the recording
          final waveform = await WaveformProcessor.processAudio(
            path: path,
            samplingRate: 44100,
            samplingFrameLength: 256,
          );

          if (waveform != null) {
            currentWaveformData.value = waveform;
          }

          // Haptic feedback for successful recording
          HapticFeedback.lightImpact();
          _sendVoiceNote(path, null);
        } catch (_) {
          _sendVoiceNote(path, null);
        }
      }

      _resetRecordingState();
    } catch (e) {
      // Debug log removed
      Get.snackbar('Error', 'Failed to stop recording');
    }
  }

  void _startRecordingTimer() {
    _recordingTimer?.cancel();
    int seconds = 0;

    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isRecording.value) {
        timer.cancel();
        return;
      }

      seconds++;
      if (seconds >= maxRecordingDuration) {
        stopRecording();
        return;
      }

      final minutes = seconds ~/ 60;
      final remainingSeconds = seconds % 60;
      recordingDuration.value =
          '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    });
  }

  void _startAmplitudeMonitoring() {
    _amplitudeTimer?.cancel();
    final samples = <double>[];

    _amplitudeTimer =
        Timer.periodic(const Duration(milliseconds: 50), (timer) async {
      if (!isRecording.value) {
        timer.cancel();
        return;
      }

      try {
        final amplitude = await _audioRecorder.getAmplitude();
        final normalized =
            (amplitude.current + 160) / 160; // Normalize around -160dB
        samples.add(normalized);

        // Keep last 50 samples
        if (samples.length > 50) {
          samples.removeAt(0);
        }

        // Update waveform data
        currentWaveformData.value = WaveformData.fromPcmSamples(
          samples: Float32List.fromList(samples),
          sampleRate: waveformSampleRate,
          duration: Duration(milliseconds: samples.length * 50),
        );
      } catch (_) {}
    });
  }

  void _resetRecordingState() {
    isRecording.value = false;
    recordingDuration.value = '00:00';
    showVoiceRecordingUI.value = false;
    isRecordingLocked.value = false;
    recordingCancelProgress.value = 0.0;
    currentWaveformData.value = null;
    _recordingTimer?.cancel();
    _amplitudeTimer?.cancel();
  }

  void updateRecordingLockState(double dragProgress) {
    if (!isRecording.value) return;

    if (dragProgress > 0.5 && !isRecordingLocked.value) {
      isRecordingLocked.value = true;
      HapticFeedback.heavyImpact();
    }

    recordingCancelProgress.value = dragProgress;
    if (dragProgress > 0.7 && !isRecordingLocked.value) {
      stopRecording(cancelled: true);
    }
  }

  Future<void> cancelRecording() async {
    final path = await _audioRecorder.stop();
    isRecording.value = false;
    recordingDuration.value = '00:00';

    if (path != null) {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }

  Future<void> _sendVoiceNote(String filePath, String? caption) async {
    try {
      final message = ChatMessageEntity.create(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: currentUser?.id ?? '',
        content: caption ?? '',
        chatRoomId: chatRoom.id,
        type: 'VOICE',
        mediaUrl: filePath,
        timestamp: DateTime.now().toIso8601String(),
        createdBy: currentUser?.id ?? '',
        updatedBy: currentUser?.id ?? '',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      );

      messages.add(message);
      _updateFlattenedItems();
      scrollToBottom();

      // Clean up older temp files
      _cleanupTempVoiceFiles();
    } catch (e) {
      // Debug log removed
      Get.snackbar('Error', 'Failed to send voice note');
    }
  }

  Future<void> _cleanupTempVoiceFiles() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final files = tempDir.listSync();
      final now = DateTime.now();

      for (final file in files) {
        if (file is File && file.path.contains('voice_')) {
          final stat = await file.stat();
          final age = now.difference(stat.modified);

          // Delete voice files older than 1 hour
          if (age > const Duration(hours: 1)) {
            await file.delete();
          }
        }
      }
    } catch (_) {}
  }

  Future<void> togglePlayPause(String messageId, String audioUrl) async {
    try {
      // Handle pause
      if (messageId == currentlyPlayingId.value && isPlaying.value) {
        await _audioPlayer.pause();
        HapticFeedback.selectionClick();
        return;
      }

      // Stop current playback if switching to new message
      if (currentlyPlayingId.value.isNotEmpty &&
          messageId != currentlyPlayingId.value) {
        await _audioPlayer.stop();
        currentlyPlayingId.value = '';
        currentPosition.value = Duration.zero;
        playbackProgress.value = 0.0;
      }

      // Start new playback
      currentlyPlayingId.value = messageId;
      HapticFeedback.selectionClick();

      // Load and play audio
      try {
        if (audioUrl.startsWith('http')) {
          await _audioPlayer.setUrl(audioUrl);
        } else {
          final file = File(audioUrl);
          if (await file.exists()) {
            await _audioPlayer.setFilePath(audioUrl);
          } else {
            throw Exception('Audio file not found');
          }
        }

        // Set playback speed (optional feature)
        await _audioPlayer.setSpeed(1.0);

        // Enable gapless playback for smoother experience
        await _audioPlayer.setLoopMode(LoopMode.off);
        await _audioPlayer.play();
      } catch (e) {
        // Debug log removed
        _resetPlayback();
        rethrow;
      }
    } catch (e) {
      // Debug log removed
      Get.snackbar(
        'Error',
        'Failed to play audio message',
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    }
  }

  void seekToPosition(double milliseconds) async {
    try {
      if (!isPlaying.value) return;

      final newPosition = Duration(milliseconds: milliseconds.toInt());
      await _audioPlayer.seek(newPosition);

      // Optional: Provide haptic feedback for seeking
      HapticFeedback.lightImpact();
    } catch (_) {}
  }

  void _resetPlayback() {
    currentlyPlayingId.value = '';
    currentPosition.value = Duration.zero;
    playbackProgress.value = 0.0;
    isPlaying.value = false;
  }

  double getPlaybackSpeed() {
    return _audioPlayer.speed;
  }

  Future<void> setPlaybackSpeed(double speed) async {
    try {
      await _audioPlayer.setSpeed(speed);
      HapticFeedback.selectionClick();
    } catch (_) {}
  }

  bool isMessageActive(String messageId) =>
      currentlyPlayingId.value == messageId;

  String formatVoiceMessageDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  // Image handling
  Future<void> pickImage() async {
    final images = await getImage(many: false, withPreview: true);
    if (images != null) {
      selectedImages.addAll(images);
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  /// Convert a file to base64 attachment format
  Future<Map<String, String>> _fileToBase64Attachment(File file) async {
    final bytes = await file.readAsBytes();
    final base64Content = base64Encode(bytes);
    final fileName = file.path.split('/').last;
    final contentType = _getMimeType(fileName);

    return {
      'base64Content': base64Content,
      'fileName': fileName,
      'contentType': contentType,
    };
  }

  /// Get MIME type from file name
  String _getMimeType(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'mp4':
        return 'video/mp4';
      case 'mov':
        return 'video/quicktime';
      case 'mp3':
        return 'audio/mpeg';
      case 'wav':
        return 'audio/wav';
      case 'm4a':
        return 'audio/m4a';
      case 'pdf':
        return 'application/pdf';
      default:
        return 'application/octet-stream';
    }
  }

  /// Upload files to server and get file data (URLs and IDs)
  Future<List<Map<String, String>>?> _uploadFiles(List<File> files) async {
    try {
      final response = await _networkService.post(
        '/file/chat-upload-multiple',
        files: {for (var file in files) 'files': file},
      );

      if (response != null && response['data'] != null) {
        final List<dynamic> dataList = response['data'];
        final List<Map<String, String>> fileData = dataList.map((item) {
          final url = item['url'] as String;
          final fileId = url.split('/').last;
          return {
            'url': url,
            'id': fileId,
            'type': item['type'] as String? ?? '',
            'name': item['name'] as String? ?? '',
          };
        }).toList();
        return fileData;
      }
      return null;
    } catch (e) {
      // Debug log removed
      return null;
    }
  }

  Future<void> sendImageMessage(String imagePath, String caption) async {
    if (_stompClient == null ||
        connectionStatus.value != WebSocketStatus.connected) {
      throw Exception('Not connected to chat server');
    }

    try {
      final file = File(imagePath);

      // Upload file to server via REST API
      final fileData = await _uploadFiles([file]);

      if (fileData == null || fileData.isEmpty) {
        throw Exception('Failed to upload file to server');
      }

      final uploadedUrl = fileData.first['url']!;
      final fileId = fileData.first['id']!;

      // Build message data with file IDs
      final messageData = {
        'senderId': currentUser?.id,
        'content': caption,
        'type': caption.isNotEmpty ? 'TEXT_AND_OTHERS' : 'IMAGE',
        'fileIds': [fileId],
      };

      // Send to WebSocket
      final destination =
          '${ChatConstants.chatMessageDestination}/${chatRoom.id}/sendMessage';

      _stompClient!.send(
        destination: destination,
        body: json.encode(messageData),
      );

      // Add optimistic message with the actual URL so it displays immediately
      final tempId = 'temp_${DateTime.now().millisecondsSinceEpoch}';
      final optimisticMessage = ChatMessageEntity.create(
        id: tempId,
        senderId: currentUser?.id ?? '',
        content: caption,
        chatRoomId: chatRoom.id,
        type: caption.isNotEmpty ? 'TEXT_AND_OTHERS' : 'IMAGE',
        mediaUrl: uploadedUrl,
        timestamp: DateTime.now().toIso8601String(),
        createdBy: currentUser?.id ?? '',
        updatedBy: currentUser?.id ?? '',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      );

      messages.add(optimisticMessage);
      _updateFlattenedItems();
      scrollToBottom();
    } catch (e) {
      // Debug log removed
      rethrow;
    }
  }

  /// Send message with multiple file attachments
  Future<void> sendMessageWithFiles({
    String? content,
    required List<File> files,
  }) async {
    if (_stompClient == null ||
        connectionStatus.value != WebSocketStatus.connected) {
      throw Exception('Not connected to chat server');
    }

    try {
      // Convert files to base64 attachments
      final attachments = <Map<String, String>>[];
      for (final file in files) {
        final attachment = await _fileToBase64Attachment(file);
        attachments.add(attachment);
      }

      // Determine message type
      String messageType = 'TEXT';
      if (attachments.isNotEmpty) {
        if (content != null && content.isNotEmpty) {
          messageType = 'TEXT_AND_OTHERS';
        } else {
          // Determine type based on first file
          final firstType = attachments.first['contentType'] ?? '';
          if (firstType.startsWith('image/')) {
            messageType = 'IMAGE';
          } else if (firstType.startsWith('video/')) {
            messageType = 'VIDEO';
          } else if (firstType.startsWith('audio/')) {
            messageType = 'AUDIO';
          } else {
            messageType = 'FILE';
          }
        }
      }

      final messageData = {
        'senderId': currentUser?.id,
        'content': content ?? '',
        'type': messageType,
        'attachments': attachments,
      };

      // Send to WebSocket
      final destination =
          '${ChatConstants.chatMessageDestination}/${chatRoom.id}/sendMessage';

      _stompClient!.send(
        destination: destination,
        body: json.encode(messageData),
      );

      // Add optimistic local message for first file
      if (files.isNotEmpty) {
        final message = ChatMessageEntity.create(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: currentUser?.id ?? '',
          content: content ?? '',
          chatRoomId: chatRoom.id,
          type: messageType,
          mediaUrl: files.first.path,
          timestamp: DateTime.now().toIso8601String(),
          createdBy: currentUser?.id ?? '',
          updatedBy: currentUser?.id ?? '',
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );

        messages.add(message);
        _updateFlattenedItems();
        scrollToBottom();
      }

      // Clear selected images
      selectedImages.clear();
    } catch (e) {
      // Debug log removed
      rethrow;
    }
  }

  Future<void> getChatRoomByAppointmentId() async {
    appointmentLoading.value = true;
    try {
      final result = await _getChatRoomByAppointmentIdUseCase.call(
          GetChatroomByAppointmentIdCommand(appointmentId: appointment.id));

      result.fold(
        (error) {
          appointmentLoading.value = false;
          if (Get.context != null) {
            Get.showCustomSnackBar(error.message);
          }
        },
        (response) {
          chatRoom = response;
          getAllMessages(chatRoom.id);
          _connectToWebSocket();
          appointmentLoading.value = false;
        },
      );
    } catch (e) {
      // Debug log removed
      appointmentLoading.value = false;
    }
  }

  // Navigation
  void goBack() => _appNavigation.goBack();

  void goToAppointmentDetail() {
    _appNavigation.toNamed(AppRoutes.appointmentDetails,
        arguments: appointment);
  }

  void goToAddPaymentMethodForm(String? method) {
    Get.back();
    if (method == 'Card') {
      _appNavigation.toNamed(WorkshopPrivateRoutes.payWithCard);
    } else if (method == 'MTN Momo' || method == 'Orange Money') {
      _appNavigation.toNamed(WorkshopPrivateRoutes.payWithPhone);
    }
  }

  void selectMethode(String method) {
    selectedMethod.value = method;
  }
}
