//Don't translate me
import '../../domain/repositories/notifications_repository.dart';
import '../../../../core/services/networkServices/network_service.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NetworkService networkService;

  NotificationsRepositoryImpl({
    required this.networkService,
  });

  //Add methods here

}
