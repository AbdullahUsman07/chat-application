import 'package:isar/isar.dart';

part 'room_collection.g.dart';

@collection 
class RoomCollection {
  Id id = Isar.autoIncrement;


  @Index(unique: true, replace: true)
  final int postgresId;


  final bool isGroup;
  final String roomName;
  final String? lastMessagePayload;
  final DateTime? lastMessageTime;
  final int unreadCount;

  RoomCollection({
    required this.postgresId,
    required this.isGroup,
    required this.roomName,
    this.lastMessagePayload,
    this.lastMessageTime,
    required this.unreadCount
  });
}