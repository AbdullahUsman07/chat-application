

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/chat_dashboard/data/models/user_collection.dart';
import '../../features/chat_dashboard/data/models/message_collection.dart';
import '../../features/chat_dashboard/data/models/room_collection.dart';


class LocalCacheService {
  late Isar isar;

  Future<void> init() async{
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      [
        UserCollectionSchema,
        RoomCollectionSchema,
        MessageCollectionSchema,
      ],
      directory: dir.path,
      inspector: true);
  }
}