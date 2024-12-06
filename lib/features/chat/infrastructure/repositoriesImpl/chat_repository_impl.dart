//Don't translate me
import '../../domain/repositories/chat_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

class ChatRepositoryImpl implements ChatRepository {
  final NetworkService networkService;

  ChatRepositoryImpl({
    required this.networkService,
  });

  //Add methods here

}
