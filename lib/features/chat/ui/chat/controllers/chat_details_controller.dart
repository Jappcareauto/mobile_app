import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:jappcare/core/navigation/app_navigation.dart';
import 'package:jappcare/core/navigation/routes/app_routes.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import 'package:jappcare/core/utils/app_images.dart';
import 'package:jappcare/core/utils/functions.dart';
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:jappcare/features/chat/domain/entities/send_message.entity.dart';
import 'package:jappcare/features/chat/application/command/send_message.command.dart';
import 'package:jappcare/features/chat/application/command/get_all_chatroom_messages.command.dart';
import 'package:jappcare/features/chat/application/usecases/get_all_chatroom_messages.usecase.dart';
import 'package:jappcare/features/chat/application/usecases/get_real_time_message.usecase.dart';
import 'package:jappcare/features/chat/application/usecases/send_message.usecase.dart';
import 'package:jappcare/features/chat/domain/core/utils/chat_constants.dart';
import 'package:jappcare/features/chat/domain/entities/get_all_chat_room_messages.entity.dart';
import 'package:jappcare/features/profile/ui/profile/controllers/profile_controller.dart';
import 'package:jappcare/features/garage/application/usecases/get_appointment_by_chatroom_id.usecase.dart';
// import 'package:jappcare/features/workshop/application/command/get_service_center_command.dart';
// import 'package:jappcare/features/workshop/application/command/get_vehicul_by_id_command.dart';
import 'package:jappcare/features/workshop/application/usecases/get_vehicul_by_id_usecase.dart';
import 'package:jappcare/features/workshop/domain/entities/get_all_appointments.dart';
import 'package:jappcare/features/workshop/globalcontroller/globalcontroller.dart';
import 'package:jappcare/features/workshop/navigation/private/workshop_private_routes.dart';
import 'package:jappcare/features/workshop/ui/confirme_appoinment/controllers/confirme_appointment_controller.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

// import 'package:web_socket_channel/io.dart';

enum WebSocketStatus { connecting, connected, disconnected, error }

class ChatDetailsController extends GetxController {
  late StompClient? _stompClient;

  // late WebSocketChannel? _channel;
  // Timer? _heartbeatTimer;
  // Timer? _reconnectTimer;

  // Controllers
  final ScrollController scrollController = ScrollController();
  final globalControllerWorkshop = Get.find<GlobalcontrollerWorkshop>();
  final TextEditingController messageController = TextEditingController();
  final LocalStorageService _localStorage = Get.find<LocalStorageService>();

  // Use cases
  GetVehiculByIdUseCase getVehiculByIdUseCase =
      GetVehiculByIdUseCase(Get.find());
  SendMessageUseCase sendMessageUseCase = SendMessageUseCase(Get.find());
  GetRealTimeMessageUseCase getRealTimeMessageUseCase =
      GetRealTimeMessageUseCase(Get.find());
  final GetAllChatRoomMessagesUseCase _getAllMessagesUseCase =
      GetAllChatRoomMessagesUseCase(Get.find());
  final GetAppointmentByChatRoomIdUseCase
      _getAppointmentByAppointmentIdUseCase =
      GetAppointmentByChatRoomIdUseCase(Get.find());

  // Observable variables
  final Rx<WebSocketStatus> connectionStatus = WebSocketStatus.disconnected.obs;
  final RxBool isReconnecting = false.obs;
  final RxInt reconnectAttempts = 0.obs;
  final chatRoomId = ''.obs;
  final appointmentId = ''.obs;
  final loading = false.obs;
  final appointmentLoading = false.obs;
  final selectedMethod = 'Orange Money'.obs;
  var selectedImages = <File>[].obs;
  final RxList<ChatMessageEntity> messages = <ChatMessageEntity>[].obs;
  late AppointmentEntity appointment;
  final currentUser = Get.find<ProfileController>().userInfos;

  // Configuration
  final int maxReconnectAttempts = 5;
  final Duration reconnectDelay = const Duration(seconds: 10);
  final Duration heartbeatInterval = const Duration(seconds: 30);

  // Stream controllers for different message types
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

  final ConfirmeAppointmentController confirmeAppointmentController =
      ConfirmeAppointmentController(Get.find());

  final AppNavigation _appNavigation;

  ChatDetailsController(this._appNavigation);

  // Voice recording
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final RxBool isRecording = false.obs;
  final RxBool isPlaying = false.obs;
  final RxString recordingDuration = '00:00'.obs;
  final RxDouble playbackProgress = 0.0.obs;
  final RxString currentlyPlayingId = ''.obs;

  var paymentDetails = [
    {"name": "MTN Momo", "icon": AppImages.mtnLogo, "numero": "+237691121881"},
    {
      "name": "Orange Money",
      "icon": AppImages.orangeLogo,
      "numero": "+237691121881"
    },
    {"name": "Card", "icon": AppImages.card, "numero": "**** **** **** 7890"},
    {"name": "Cash", "icon": AppImages.money, "numero": ""}
  ];

  @override
  void onInit() {
    super.onInit();
    chatRoomId.value = Get.arguments;
    // appointmentId.value = Get.arguments;
    print('chatroom ${chatRoomId.value}');

    _initializeAudio();
    connectToWebSocket();
    getAppoitmentByChatRoomId();
    getAllMessages();
  }

  @override
  void onClose() {
    // Fermer proprement la connexion WebSocket
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    _messageController.close();
    _typingController.close();
    _presenceController.close();
    // scrollController.dispose();
    disconnect();
    super.onClose();
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> getAllMessages() async {
    loading.value = true;
    final result = await _getAllMessagesUseCase
        .call(GetAllChatroomMessagesCommand(chatroom: chatRoomId.value));
    result.fold(
      (e) {
        loading.value = false;
        if (Get.context != null) {
          Get.showCustomSnackBar(e.message);
        }
      },
      (response) {
        loading.value = false;
        messages.value = response.data;
      },
    );
  }

  // Websocket methods

  void connectToWebSocket() {
    try {
      connectionStatus.value = WebSocketStatus.connecting;

      final token = _localStorage.read(AppConstants.tokenKey);

      _stompClient = StompClient(
        config: StompConfig.sockJS(
          url: ChatConstants.chatWebsocketUri,
          onConnect: onConnected,
          onWebSocketError: (dynamic error) {
            print('WebSocket Error: $error');
            connectionStatus.value = WebSocketStatus.error;
          },
          onStompError: (StompFrame frame) {
            print('Stomp Error: ${frame.body}');
            connectionStatus.value = WebSocketStatus.error;
          },
          onDisconnect: (StompFrame frame) {
            print('Disconnected: ${frame.body}');
            connectionStatus.value = WebSocketStatus.disconnected;
          },
          beforeConnect: () async {
            print('Preparing to connect...');
          },
          stompConnectHeaders: {'Authorization': 'Bearer $token'},
          webSocketConnectHeaders: {'Authorization': 'Bearer $token'},
        ),
      );

      _stompClient!.activate();
    } catch (e) {
      print('Connection error: $e');
      connectionStatus.value = WebSocketStatus.error;
    }
  }

  void disconnect() {
    if (_stompClient != null) {
      _stompClient!.deactivate();
      _stompClient = null;
    }
  }

  void onConnected(StompFrame frame) {
    print('Connected to STOMP server');
    connectionStatus.value = WebSocketStatus.connected;
    // Subscribe to the chat room topic
    subscribeToTopic();
  }

  void subscribeToTopic() {
    final topicDestination =
        '${ChatConstants.chatRoomTopic}/${chatRoomId.value}';

    _stompClient!.subscribe(
      destination: topicDestination,
      callback: (StompFrame frame) {
        if (frame.body != null) {
          try {
            final messageData = json.decode(frame.body!);

            final chatMessage = ChatMessageEntity.fromJson(messageData);
            if (chatMessage.createdBy != currentUser?.id) {
              messages.add(chatMessage);
              update();
              scrollToBottom();
            }
            print('Received message: ${messageData}');
          } catch (e) {
            print('Error parsing message: $e');
          }
        }
      },
    );

    print('Subscribed to topic: $topicDestination');
  }

  // Text message methods

  void sendMessage(String content) {
    if (_stompClient != null &&
        connectionStatus.value == WebSocketStatus.connected &&
        content.isNotEmpty) {
      final messageData = {
        'senderId': Get.find<ProfileController>().userInfos!.id,
        'content': content,
        'chatRoomId': chatRoomId.value,
        'type': 'TEXT',
      };

      _stompClient!.send(
        destination: ChatConstants.chatMessageDestination,
        body: json.encode(messageData),
      );
      messages.add(ChatMessageEntity.create(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: Get.find<ProfileController>().userInfos!.id,
        content: content,
        chatRoomId: chatRoomId.value,
        type: 'TEXT',
        timestamp: DateTime.now().toIso8601String(),
        createdBy: Get.find<ProfileController>().userInfos!.id,
        updatedBy: Get.find<ProfileController>().userInfos!.id,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      ));
      scrollToBottom();
      messageController.clear();
      update();
      print('Message sent: $content');
    } else {
      print('Cannot send message. Connected: ${connectionStatus.value}');
    }
  }

  // Audio message methods

  void _initializeAudio() {
    // Listen to audio player position changes
    _audioPlayer.positionStream.listen((position) {
      final duration = _audioPlayer.duration;
      if (duration != null && duration.inMilliseconds > 0) {
        playbackProgress.value =
            position.inMilliseconds / duration.inMilliseconds;
      }
    });

    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
      if (state.processingState == ProcessingState.completed) {
        currentlyPlayingId.value = '';
        playbackProgress.value = 0.0;
      }
    });
  }

  Future<bool> _requestPermissions() async {
    final microphoneStatus = await Permission.microphone.request();
    return microphoneStatus == PermissionStatus.granted;
  }

  // Voice recording methods

  Future<void> startRecording() async {
    try {
      if (!await _requestPermissions()) {
        Get.snackbar('Permission Denied', 'Microphone permission is required');
        return;
      }

      final directory = await getTemporaryDirectory();
      final filePath =
          '${directory.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

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
    } catch (e) {
      print('Error starting recording: $e');
      Get.snackbar('Error', 'Failed to start recording');
    }
  }

  Future<void> stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      isRecording.value = false;
      recordingDuration.value = '00:00';

      if (path != null) {
        // Show confirmation dialog before sending
        _showVoiceNotePreview(path);
      }
    } catch (e) {
      print('Error stopping recording: $e');
      Get.snackbar('Error', 'Failed to stop recording');
    }
  }

  void _startRecordingTimer() {
    int seconds = 0;
    Stream.periodic(const Duration(seconds: 1), (i) => i).listen((count) {
      if (!isRecording.value) return;
      seconds++;
      final minutes = seconds ~/ 60;
      final remainingSeconds = seconds % 60;
      recordingDuration.value =
          '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    });
  }

  void _showVoiceNotePreview(String filePath) {
    Get.dialog(
      AlertDialog(
        title: const Text('Send Voice Note?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Duration: '),
            Obx(() => Text(recordingDuration.value)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _playPreview(filePath),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Play'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _sendVoiceNote(filePath),
                  icon: const Icon(Icons.send),
                  label: const Text('Send'),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              File(filePath).deleteSync(); // Clean up
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _playPreview(String filePath) async {
    try {
      await _audioPlayer.setFilePath(filePath);
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing preview: $e');
    }
  }

  Future<void> _sendVoiceNote(String filePath) async {
    try {
      Get.back(); // Close dialog

      // Show loading
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final file = File(filePath);
      final bytes = await file.readAsBytes();

      // Convert to base64 for transmission
      final base64Audio = base64Encode(bytes);
      final duration = recordingDuration.value;

      // Send voice message through WebSocket
      final messageData = {
        'senderId': Get.find<ProfileController>().userInfos!.id,
        'content': base64Audio, // Base64 encoded audio
        'chatRoomId': chatRoomId,
        'type': 'VOICE',
        'duration': duration,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };

      _stompClient!.send(
        destination: ChatConstants.chatMessageDestination,
        body: json.encode(messageData),
      );

      Get.back(); // Close loading dialog
      print('Voice note sent');

      // Clean up temp file
      file.deleteSync();
    } catch (e) {
      Get.back(); // Close loading dialog
      print('Error sending voice note: $e');
      Get.snackbar('Error', 'Failed to send voice note');
    }
  }

  Future<void> playVoiceNote(SendMessageEntity message) async {
    try {
      if (currentlyPlayingId.value == message.id) {
        // Stop if already playing this message
        await _audioPlayer.stop();
        currentlyPlayingId.value = '';
        return;
      }

      // Stop any currently playing audio
      await _audioPlayer.stop();

      // Decode base64 audio data
      final audioBytes = base64Decode(message.content);

      // Save to temp file for playback
      final directory = await getTemporaryDirectory();
      final tempFile = File('${directory.path}/temp_voice_${message.id}.m4a');
      await tempFile.writeAsBytes(audioBytes);

      // Play the audio
      await _audioPlayer.setFilePath(tempFile.path);
      currentlyPlayingId.value = message.id ?? "";
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing voice note: $e');
      Get.snackbar('Error', 'Failed to play voice note');
    }
  }

  // Image message methods

  Future<void> sendImageMessage(String imagePath, String caption) async {
    if (_stompClient != null &&
        connectionStatus.value == WebSocketStatus.connected &&
        imagePath.isNotEmpty) {
      try {
        // Read image file and convert to base64
        final imageFile = File(imagePath);
        final imageBytes = await imageFile.readAsBytes();
        final base64Image = base64Encode(imageBytes);

        final messageData = {
          'senderId': Get.find<ProfileController>().userInfos!.id,
          'content': base64Image, // Base64 encoded image
          'caption': caption, // Text caption
          'chatRoomId': chatRoomId,
          'type': 'IMAGE',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };

        print(messageData);
        print(base64Image);

        // _stompClient!.send(
        //   destination: '/app/chat/message',
        //   body: json.encode(messageData),
        // );
        final message = ChatMessageEntity.create(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: Get.find<ProfileController>().userInfos!.id,
          content: caption,
          chatRoomId: chatRoomId.value,
          type: 'IMAGE',
          mediaUrl: imagePath,
          timestamp: DateTime.now().toIso8601String(),
          createdBy: Get.find<ProfileController>().userInfos!.id,
          updatedBy: Get.find<ProfileController>().userInfos!.id,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );
        messages.add(message);
        update();
        scrollToBottom();

        print('Image message sent with caption: $caption');
      } catch (e) {
        print('Error sending image message: $e');
        Get.snackbar('Error', 'Failed to send image message');
      }
    }
  }

  Future<void> pickImage() async {
    final images = await getImage(many: true);
    if (images != null) {
      selectedImages.addAll(images);
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  // Sending the message to the api server

  Future<void> insertMessageToDataBase() async {
    final result = await sendMessageUseCase.call(SendMessageCommand(
        appointmentId: globalControllerWorkshop.workshopData[
            'appointmentId'], // a remplacer lorsque le enpoint de creation des rendez voux seras fonctionnel,
        chatRoomId: globalControllerWorkshop.workshopData['chatroomId'],
        content: messageController.text,
        type: selectedImages.isNotEmpty ? "image" : "TEXT_SIMPLE",
        senderId: Get.find<ProfileController>().userInfos!.id,
        timestamp: DateTime.now().toIso8601String()));
    result.fold((e) {
      print('erreur d\'envoie du message $e');
      Get.showCustomSnackBar(e.message);
    }, (response) {
      print('message envoyer avec succes');
      print(response);
    });
  }

  Future<void> getAppoitmentByChatRoomId() async {
    appointmentLoading.value = true;
    final result = await _getAppointmentByAppointmentIdUseCase.call(
        chatroomId: chatRoomId.value);
    result.fold((e) {
      print('erreur $e');
      Get.showCustomSnackBar(e.message);
      appointmentLoading.value = false;
    }, (response) {
      print(response);
      appointment = response;
      update();
      appointmentLoading.value = false;
    });
  }

  void openMore() {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const Placeholder(),
    );
  }

  void goBack() {
    _appNavigation.goBack();
  }

  void selectMethode(String methode) {
    selectedMethod.value = methode;
  }

  void goToAppointmentDetail() {
    _appNavigation.toNamed(AppRoutes.appointmentDetails,
        arguments: appointment);
  }

  void goToAddPaymentMethodForm(String? methode) {
    Get.back();
    if (methode == 'Card') {
      _appNavigation.toNamed(WorkshopPrivateRoutes.payWithCard);
    }
    if (methode == 'MTN Momo' || methode == 'Orange Money') {
      _appNavigation.toNamed(WorkshopPrivateRoutes.payWithPhone);
    }
  }

  // // Connect to WebSocket
  // Future<void> connect() async {
  //   if (connectionStatus.value == WebSocketStatus.connecting) return;

  //   try {
  //     connectionStatus.value = WebSocketStatus.connecting;

  //     final token = _localStorage.read(AppConstants.tokenKey);
  //     if (token == null) {
  //       throw Exception("Token not found");
  //     }

  //     if (chatRoomId.value.isEmpty) {
  //       throw Exception("Chatroom ID not found");
  //     }

  //     // Build WebSocket URL with authentication
  //     final wsUrl = Uri.parse('wss://bpi.jappcare.com/ws?token=$token');

  //     print('Connecting to WebSocket: $wsUrl');

  //     // Create WebSocket connection
  //     _channel = IOWebSocketChannel.connect(
  //       wsUrl,
  //       // protocols: ['token', token],
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       },
  //     );

  //     // Listen to WebSocket stream
  //     _channel?.stream.listen(
  //       _handleMessage,
  //       onError: _handleError,
  //       onDone: _handleDisconnection,
  //     );

  //     // Send initial connection message
  //     _sendConnectionMessage();

  //     // Start heartbeat
  //     _startHeartbeat();

  //     connectionStatus.value = WebSocketStatus.connected;
  //     reconnectAttempts.value = 0;
  //     isReconnecting.value = false;

  //     print('WebSocket connected successfully');
  //   } catch (e) {
  //     print('WebSocket connection error: $e');
  //     connectionStatus.value = WebSocketStatus.error;
  //     _scheduleReconnect();
  //   }
  // }

  // // Disconnect from WebSocket
  // void disconnect() {
  //   _heartbeatTimer?.cancel();
  //   _reconnectTimer?.cancel();

  //   if (_channel != null) {
  //     // _channel!.sink.close(status.normalClosure);
  //     _channel!.sink.close();
  //     _channel = null;
  //   }

  //   connectionStatus.value = WebSocketStatus.disconnected;
  //   isReconnecting.value = false;
  //   reconnectAttempts.value = 0;

  //   print('WebSocket disconnected');
  // }

  // Future<void> getRealTimeMessage(String chatroom, String token) async {
  //   final Uri uri = Uri.parse('${ChatConstants.chatUri}$chatroom');
  //   try {
  //     // Crée une connexion WebSocket avec les headers nécessaires
  //     final webSocket = await WebSocket.connect(
  //       uri.toString(),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );
  //     // Initialise le canal WebSocket
  //     channel = IOWebSocketChannel(webSocket);
  //     // Liste pour stocker les messages reçus

  //     // Écoute les messages en temps réel
  //     channel.stream.listen(
  //       (message) {
  //         final decodedMessage = jsonDecode(message);
  //         final chatMessage =
  //             SendMessageModel.fromJson(decodedMessage).toEntity();
  //         messages.add(chatMessage);
  //         print("Nouveau message reçu : $decodedMessage");
  //       },
  //       onError: (error) {
  //         print("Erreur WebSocket : $error");
  //         _handleReconnection(chatroom, token);
  //         print("REConnexion WebSocket REUSSIE.");
  //       },
  //       onDone: () {
  //         print("Connexion WebSocket fermée.");
  //         _handleReconnection(chatroom, token);
  //         print("REConnexion WebSocket REUSSIE.");
  //       },
  //     );
  //   } on SocketException catch (e) {
  //     print("Erreur réseau : $e");
  //   } catch (e) {
  //     print("Erreur inattendue : $e");
  //   }
  // }

  // void _handleReconnection(String chatroom, String token) {
  //   print("Tentative de reconnexion...");
  //   Future.delayed(const Duration(seconds: 5), () {
  //     messages.clear();
  //     getRealTimeMessage(
  //         chatroom, token); // Tente de se reconnecter après 5 secondes
  //   });
  // }

  // void sendMessage() async {
  //   if (messageController.text.isNotEmpty || selectedImages.isNotEmpty) {
  //     try {
  //       // Créer une instance de SendMessage
  //       final newMessage = SendMessage.create(
  //         senderId: Get.find<ProfileController>().userInfos!.id,
  //         content: messageController.text,
  //         chatRoomId: globalControllerWorkshop.workshopData['chatroomId'],
  //         timestamp: DateTime.now().toIso8601String(),
  //         type: selectedImages.isNotEmpty ? "image" : "TEXT_SIMPLE",
  //         appointmentId: globalControllerWorkshop.workshopData['appointmentId'],
  //       );
  //       // Ajouter à la liste des messages
  //       messages.add(newMessage);
  //       await insertMessageToDataBase();
  //       // Réinitialiser les champs
  //       messageController.clear();
  //       selectedImages.clear();
  //       // Mettre à jour l'état
  //       update();
  //       scrollToBottom();
  //       //sauvegarder le message dans la base de donneee
  //     } catch (e) {
  //       print("Erreur lors de l'envoi du message : $e");
  //     }
  //   }
  // }

  // Private methods

  // void _handleMessage(dynamic message) {
  //   try {
  //     final Map<String, dynamic> data = jsonDecode(message);
  //     print('Received WebSocket message: $data');

  //     switch (data['type']) {
  //       case 'chat_message':
  //       case 'message_delivered':
  //       case 'message_read':
  //         _messageController.add(data);
  //         break;
  //       case 'typing_indicator':
  //         _typingController.add(data);
  //         break;
  //       case 'presence_update':
  //       case 'user_online':
  //       case 'user_offline':
  //         _presenceController.add(data);
  //         break;
  //       case 'connection_ack':
  //         print('Connection acknowledged by server');
  //         break;
  //       case 'heartbeat_ack':
  //         print('Heartbeat acknowledged');
  //         break;
  //       case 'error':
  //         print('Server error: ${data['message']}');
  //         Get.snackbar('Server Error', data['message'] ?? 'Unknown error');
  //         break;
  //       default:
  //         print('Unknown message type: ${data['type']}');
  //     }
  //   } catch (e) {
  //     print('Error handling WebSocket message: $e');
  //   }
  // }

  // void _handleError(error) {
  //   print('WebSocket error: $error');
  //   connectionStatus.value = WebSocketStatus.error;
  //   _scheduleReconnect();
  // }

  // void _handleDisconnection() {
  //   print('WebSocket disconnected');
  //   connectionStatus.value = WebSocketStatus.disconnected;
  //   _heartbeatTimer?.cancel();
  //   _scheduleReconnect();
  // }

  // void _scheduleReconnect() {
  //   if (reconnectAttempts.value >= maxReconnectAttempts) {
  //     print('Max reconnection attempts reached');
  //     isReconnecting.value = false;
  //     Get.snackbar(
  //       'Connection Failed',
  //       'Unable to connect to chat server. Please check your internet connection.',
  //       snackPosition: SnackPosition.BOTTOM,
  //       duration: const Duration(seconds: 5),
  //     );
  //     return;
  //   }

  //   if (isReconnecting.value) return;

  //   isReconnecting.value = true;
  //   reconnectAttempts.value++;

  //   print(
  //       'Scheduling reconnection attempt ${reconnectAttempts.value} in ${reconnectDelay.inSeconds} seconds');

  //   _reconnectTimer = Timer(reconnectDelay, () {
  //     print('Attempting to reconnect...');
  //     // connect();
  //   });
  // }

  // void _sendConnectionMessage() {
  //   sendMessage({
  //     'type': 'connection_init',
  //     'data': {
  //       'client_type': 'flutter_mobile',
  //       'version': '1.0.0',
  //       'timestamp': DateTime.now().toIso8601String(),
  //     }
  //   });
  // }

  // void _startHeartbeat() {
  //   _heartbeatTimer?.cancel();
  //   _heartbeatTimer = Timer.periodic(heartbeatInterval, (timer) {
  //     print("Heart beat");
  //     sendMessage({
  //       'type': 'heartbeat',
  //       'data': {
  //         'timestamp': DateTime.now().toIso8601String(),
  //       }
  //     });
  //   });
  // }

  // Send message through WebSocket
  // void sendMessage(Map<String, dynamic> message) {
  //   print(connectionStatus.value);
  //   if (connectionStatus.value != WebSocketStatus.connected) {
  //     print('Cannot send message: WebSocket not connected');
  //     return;
  //   }

  //   try {
  //     final jsonMessage = jsonEncode(message);
  //     _channel?.sink.add(jsonMessage);

  //     jsonEncode({
  //       "senderId": Get.find<ProfileController>().userInfos!.id,
  //       "content": message,
  //       "chatRoomId": chatRoom.value,
  //       "type": "TEXT"
  //     });

  //     print('Message sent: $jsonMessage');
  //   } catch (e) {
  //     print('Error sending message: $e');
  //   }
  // }
}
