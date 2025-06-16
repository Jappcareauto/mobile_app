enum MessageType {
  textSimple,
  textRich,
  attachmentAppointment,
  textWithAttachment,
  image,
  video,
  audio,
  textWithVideo
}

extension MessageTypeExtension on MessageType {
  String get value => _messageTypeValues[this] ?? '';

  static const _messageTypeValues = {
    MessageType.textSimple: "TEXT_SIMPLE",
    MessageType.textRich: "TEXT_RICH",
    MessageType.attachmentAppointment: "ATTACHMENT_APPOINTMENT",
    MessageType.textWithAttachment: "TEXT_WITH_ATTACHMENT",
    MessageType.image: "IMAGE",
    MessageType.video: "VIDEO",
    MessageType.audio: "AUDIO",
    MessageType.textWithVideo: "VIDEO",
  };
}
