import 'package:frontend/features/chat_dashboard/domain/entities/message_status.dart';
import 'package:isar/isar.dart';

part 'message_collection.g.dart';

@collection  
class MessageCollection {
  Id id = Isar.autoIncrement;

  // The critical link for idempotency. Allows client to look up local 
  // records when the server acknowledges reciept over the WebSocket.
  @Index(unique: true, replace: true)
  final String clientUuid;

  // Nullable because the offline messages don't have the postgresId yet
  @Index(unique:true, replace: false)
  int? postgresId;

  @Index()
  final int roomId;

  final int senderId;
  final String payload;

  @enumerated
  LocalMessageStatus status;

  @Index(type: IndexType.value)
  final DateTime createdAt;

  MessageCollection({
    required this.clientUuid,
    this.postgresId,
    required this.roomId,
    required this.senderId,
    required this.payload,
    required this.status,
    required this.createdAt
  });
}
