import 'dart:io';

class UpdateProfileImageCommand {

  final String userId;
  final File file;

  const UpdateProfileImageCommand({
    required this.userId,
    required this.file,
  });
}

