// //Don't translate me
// import '../command/get_real_time_message_command.dart';
// import 'package:dartz/dartz.dart';
// import '../../domain/core/exceptions/workshop_exception.dart';
// import '../../domain/repositories/workshop_repository.dart';
// import '../../domain/entities/send_message.dart';

// class GetRealTimeMessageUseCase {
//   final WorkshopRepository repository;

//   GetRealTimeMessageUseCase(this.repository);

//   Future<Either<WorkshopException, List<SendMessage>>> call(
//       GetRealTimeMessageCommand command) async {
//     return await repository.getRealTimeMessages(
//         command.chatroom, command.token);
//   }
// }
