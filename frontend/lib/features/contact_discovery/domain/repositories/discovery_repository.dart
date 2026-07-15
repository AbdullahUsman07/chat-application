
import '../../data/models/discovered_user_model.dart';

abstract class DiscoveryRepository {

  // pulls local contacts, filters them, sanitizes them, and matches them via backend
  Future<List<DiscoveredUserModel>> syncDeviceContacts();
}
