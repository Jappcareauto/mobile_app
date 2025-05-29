//Don't translate me
class WorkshopConstants {
  static const String featureName = 'workshop';
  static const String featureVersion = '1.0.0';

  // Add other constants here
  static const String getsetterPostUri = '/get/set';
  static const String services = '/services';
  static const String availableServices = '/services/available';
  static const String getServiceCenterGetUri = '/service-centers';
  static const String getAllServicesCenterGetUri = '/service-center/list';
  static const String bookAppointmentPostUri = '/appointment';
  static const String createdRomeChatPostUri = '/chatroom';
  static const String chatUri =
      'wss://bpi.jappcare.com/api/v1/chat?chatRoomId=';

  static const String sendMessagePostUri = '/chat-message';
  static const String getAllservicesGetUri = '/service/list';
  static const String getVehiculByIdGetUri = '/vehicle/by-owner-id';
  static const String googleAutocompleteUri =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const String googlePlaceDetailsUri =
      'https://maps.googleapis.com/maps/api/place/details/json';
}
