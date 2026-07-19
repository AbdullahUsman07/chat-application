// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMessageCollectionCollection on Isar {
  IsarCollection<MessageCollection> get messageCollections => this.collection();
}

const MessageCollectionSchema = CollectionSchema(
  name: r'MessageCollection',
  id: -7394621338610000233,
  properties: {
    r'clientUuid': PropertySchema(
      id: 0,
      name: r'clientUuid',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'payload': PropertySchema(
      id: 2,
      name: r'payload',
      type: IsarType.string,
    ),
    r'postgresId': PropertySchema(
      id: 3,
      name: r'postgresId',
      type: IsarType.long,
    ),
    r'roomId': PropertySchema(
      id: 4,
      name: r'roomId',
      type: IsarType.long,
    ),
    r'senderId': PropertySchema(
      id: 5,
      name: r'senderId',
      type: IsarType.long,
    ),
    r'status': PropertySchema(
      id: 6,
      name: r'status',
      type: IsarType.byte,
      enumMap: _MessageCollectionstatusEnumValueMap,
    )
  },
  estimateSize: _messageCollectionEstimateSize,
  serialize: _messageCollectionSerialize,
  deserialize: _messageCollectionDeserialize,
  deserializeProp: _messageCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'clientUuid': IndexSchema(
      id: 9054268822263051315,
      name: r'clientUuid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'clientUuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'postgresId': IndexSchema(
      id: 7386607967474333024,
      name: r'postgresId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'postgresId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'roomId': IndexSchema(
      id: -3609232324653216207,
      name: r'roomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _messageCollectionGetId,
  getLinks: _messageCollectionGetLinks,
  attach: _messageCollectionAttach,
  version: '3.1.0+1',
);

int _messageCollectionEstimateSize(
  MessageCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.clientUuid.length * 3;
  bytesCount += 3 + object.payload.length * 3;
  return bytesCount;
}

void _messageCollectionSerialize(
  MessageCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.clientUuid);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.payload);
  writer.writeLong(offsets[3], object.postgresId);
  writer.writeLong(offsets[4], object.roomId);
  writer.writeLong(offsets[5], object.senderId);
  writer.writeByte(offsets[6], object.status.index);
}

MessageCollection _messageCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MessageCollection(
    clientUuid: reader.readString(offsets[0]),
    createdAt: reader.readDateTime(offsets[1]),
    payload: reader.readString(offsets[2]),
    postgresId: reader.readLongOrNull(offsets[3]),
    roomId: reader.readLong(offsets[4]),
    senderId: reader.readLong(offsets[5]),
    status: _MessageCollectionstatusValueEnumMap[
            reader.readByteOrNull(offsets[6])] ??
        LocalMessageStatus.sending,
  );
  object.id = id;
  return object;
}

P _messageCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (_MessageCollectionstatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          LocalMessageStatus.sending) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MessageCollectionstatusEnumValueMap = {
  'sending': 0,
  'sent': 1,
  'delievered': 2,
  'read': 3,
  'failed': 4,
};
const _MessageCollectionstatusValueEnumMap = {
  0: LocalMessageStatus.sending,
  1: LocalMessageStatus.sent,
  2: LocalMessageStatus.delievered,
  3: LocalMessageStatus.read,
  4: LocalMessageStatus.failed,
};

Id _messageCollectionGetId(MessageCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _messageCollectionGetLinks(
    MessageCollection object) {
  return [];
}

void _messageCollectionAttach(
    IsarCollection<dynamic> col, Id id, MessageCollection object) {
  object.id = id;
}

extension MessageCollectionByIndex on IsarCollection<MessageCollection> {
  Future<MessageCollection?> getByClientUuid(String clientUuid) {
    return getByIndex(r'clientUuid', [clientUuid]);
  }

  MessageCollection? getByClientUuidSync(String clientUuid) {
    return getByIndexSync(r'clientUuid', [clientUuid]);
  }

  Future<bool> deleteByClientUuid(String clientUuid) {
    return deleteByIndex(r'clientUuid', [clientUuid]);
  }

  bool deleteByClientUuidSync(String clientUuid) {
    return deleteByIndexSync(r'clientUuid', [clientUuid]);
  }

  Future<List<MessageCollection?>> getAllByClientUuid(
      List<String> clientUuidValues) {
    final values = clientUuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'clientUuid', values);
  }

  List<MessageCollection?> getAllByClientUuidSync(
      List<String> clientUuidValues) {
    final values = clientUuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'clientUuid', values);
  }

  Future<int> deleteAllByClientUuid(List<String> clientUuidValues) {
    final values = clientUuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'clientUuid', values);
  }

  int deleteAllByClientUuidSync(List<String> clientUuidValues) {
    final values = clientUuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'clientUuid', values);
  }

  Future<Id> putByClientUuid(MessageCollection object) {
    return putByIndex(r'clientUuid', object);
  }

  Id putByClientUuidSync(MessageCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'clientUuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByClientUuid(List<MessageCollection> objects) {
    return putAllByIndex(r'clientUuid', objects);
  }

  List<Id> putAllByClientUuidSync(List<MessageCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'clientUuid', objects, saveLinks: saveLinks);
  }

  Future<MessageCollection?> getByPostgresId(int? postgresId) {
    return getByIndex(r'postgresId', [postgresId]);
  }

  MessageCollection? getByPostgresIdSync(int? postgresId) {
    return getByIndexSync(r'postgresId', [postgresId]);
  }

  Future<bool> deleteByPostgresId(int? postgresId) {
    return deleteByIndex(r'postgresId', [postgresId]);
  }

  bool deleteByPostgresIdSync(int? postgresId) {
    return deleteByIndexSync(r'postgresId', [postgresId]);
  }

  Future<List<MessageCollection?>> getAllByPostgresId(
      List<int?> postgresIdValues) {
    final values = postgresIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'postgresId', values);
  }

  List<MessageCollection?> getAllByPostgresIdSync(List<int?> postgresIdValues) {
    final values = postgresIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'postgresId', values);
  }

  Future<int> deleteAllByPostgresId(List<int?> postgresIdValues) {
    final values = postgresIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'postgresId', values);
  }

  int deleteAllByPostgresIdSync(List<int?> postgresIdValues) {
    final values = postgresIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'postgresId', values);
  }

  Future<Id> putByPostgresId(MessageCollection object) {
    return putByIndex(r'postgresId', object);
  }

  Id putByPostgresIdSync(MessageCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'postgresId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPostgresId(List<MessageCollection> objects) {
    return putAllByIndex(r'postgresId', objects);
  }

  List<Id> putAllByPostgresIdSync(List<MessageCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'postgresId', objects, saveLinks: saveLinks);
  }
}

extension MessageCollectionQueryWhereSort
    on QueryBuilder<MessageCollection, MessageCollection, QWhere> {
  QueryBuilder<MessageCollection, MessageCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhere>
      anyPostgresId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'postgresId'),
      );
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhere> anyRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'roomId'),
      );
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhere>
      anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension MessageCollectionQueryWhere
    on QueryBuilder<MessageCollection, MessageCollection, QWhereClause> {
  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      clientUuidEqualTo(String clientUuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'clientUuid',
        value: [clientUuid],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      clientUuidNotEqualTo(String clientUuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientUuid',
              lower: [],
              upper: [clientUuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientUuid',
              lower: [clientUuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientUuid',
              lower: [clientUuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'clientUuid',
              lower: [],
              upper: [clientUuid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      postgresIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'postgresId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      postgresIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'postgresId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      postgresIdEqualTo(int? postgresId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'postgresId',
        value: [postgresId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      postgresIdNotEqualTo(int? postgresId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'postgresId',
              lower: [],
              upper: [postgresId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'postgresId',
              lower: [postgresId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'postgresId',
              lower: [postgresId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'postgresId',
              lower: [],
              upper: [postgresId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      postgresIdGreaterThan(
    int? postgresId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'postgresId',
        lower: [postgresId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      postgresIdLessThan(
    int? postgresId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'postgresId',
        lower: [],
        upper: [postgresId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      postgresIdBetween(
    int? lowerPostgresId,
    int? upperPostgresId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'postgresId',
        lower: [lowerPostgresId],
        includeLower: includeLower,
        upper: [upperPostgresId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdEqualTo(int roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdNotEqualTo(int roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [],
              upper: [roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [roomId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [roomId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [],
              upper: [roomId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdGreaterThan(
    int roomId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId',
        lower: [roomId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdLessThan(
    int roomId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId',
        lower: [],
        upper: [roomId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      roomIdBetween(
    int lowerRoomId,
    int upperRoomId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'roomId',
        lower: [lowerRoomId],
        includeLower: includeLower,
        upper: [upperRoomId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterWhereClause>
      createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MessageCollectionQueryFilter
    on QueryBuilder<MessageCollection, MessageCollection, QFilterCondition> {
  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      clientUuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      clientUuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      clientUuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      clientUuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientUuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      clientUuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clientUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      clientUuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clientUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      clientUuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      clientUuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      clientUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      clientUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      payloadEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      payloadGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      payloadLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      payloadBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payload',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      payloadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      payloadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      payloadContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      payloadMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payload',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      payloadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payload',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      payloadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payload',
        value: '',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      postgresIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'postgresId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      postgresIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'postgresId',
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      postgresIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'postgresId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      postgresIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'postgresId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      postgresIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'postgresId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      postgresIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'postgresId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      roomIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      roomIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      roomIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      roomIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      senderIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      senderIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      senderIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderId',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      senderIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      statusEqualTo(LocalMessageStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      statusGreaterThan(
    LocalMessageStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      statusLessThan(
    LocalMessageStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterFilterCondition>
      statusBetween(
    LocalMessageStatus lower,
    LocalMessageStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MessageCollectionQueryObject
    on QueryBuilder<MessageCollection, MessageCollection, QFilterCondition> {}

extension MessageCollectionQueryLinks
    on QueryBuilder<MessageCollection, MessageCollection, QFilterCondition> {}

extension MessageCollectionQuerySortBy
    on QueryBuilder<MessageCollection, MessageCollection, QSortBy> {
  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByClientUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientUuid', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByClientUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientUuid', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByPayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payload', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByPayloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payload', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByPostgresId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postgresId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByPostgresIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postgresId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortBySenderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension MessageCollectionQuerySortThenBy
    on QueryBuilder<MessageCollection, MessageCollection, QSortThenBy> {
  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByClientUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientUuid', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByClientUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientUuid', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByPayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payload', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByPayloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payload', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByPostgresId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postgresId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByPostgresIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postgresId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenBySenderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.desc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension MessageCollectionQueryWhereDistinct
    on QueryBuilder<MessageCollection, MessageCollection, QDistinct> {
  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByClientUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientUuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByPayload({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payload', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByPostgresId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'postgresId');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomId');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderId');
    });
  }

  QueryBuilder<MessageCollection, MessageCollection, QDistinct>
      distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }
}

extension MessageCollectionQueryProperty
    on QueryBuilder<MessageCollection, MessageCollection, QQueryProperty> {
  QueryBuilder<MessageCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MessageCollection, String, QQueryOperations>
      clientUuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientUuid');
    });
  }

  QueryBuilder<MessageCollection, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<MessageCollection, String, QQueryOperations> payloadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payload');
    });
  }

  QueryBuilder<MessageCollection, int?, QQueryOperations> postgresIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'postgresId');
    });
  }

  QueryBuilder<MessageCollection, int, QQueryOperations> roomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomId');
    });
  }

  QueryBuilder<MessageCollection, int, QQueryOperations> senderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderId');
    });
  }

  QueryBuilder<MessageCollection, LocalMessageStatus, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
