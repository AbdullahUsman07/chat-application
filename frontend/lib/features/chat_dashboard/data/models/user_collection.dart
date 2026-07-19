
import 'package:isar/isar.dart';


part 'user_collection.g.dart';

@collection
class UserCollection {
  Id id = Isar.autoIncrement;

  @Index(unique:true, replace: true)
  final int postgresId;

  final String username;
  final String? phoneNumber;
  final DateTime cachedAt;

  UserCollection({
    required this.postgresId,
    required this.username,
    this.phoneNumber,
    required this.cachedAt
  });
}
