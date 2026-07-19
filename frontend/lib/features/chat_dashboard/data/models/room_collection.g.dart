// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRoomCollectionCollection on Isar {
  IsarCollection<RoomCollection> get roomCollections => this.collection();
}

const RoomCollectionSchema = CollectionSchema(
  name: r'RoomCollection',
  id: 1548848606307669749,
  properties: {
    r'isGroup': PropertySchema(
      id: 0,
      name: r'isGroup',
      type: IsarType.bool,
    ),
    r'lastMessagePayload': PropertySchema(
      id: 1,
      name: r'lastMessagePayload',
      type: IsarType.string,
    ),
    r'lastMessageTime': PropertySchema(
      id: 2,
      name: r'lastMessageTime',
      type: IsarType.dateTime,
    ),
    r'postgresId': PropertySchema(
      id: 3,
      name: r'postgresId',
      type: IsarType.long,
    ),
    r'roomName': PropertySchema(
      id: 4,
      name: r'roomName',
      type: IsarType.string,
    ),
    r'unreadCount': PropertySchema(
      id: 5,
      name: r'unreadCount',
      type: IsarType.long,
    )
  },
  estimateSize: _roomCollectionEstimateSize,
  serialize: _roomCollectionSerialize,
  deserialize: _roomCollectionDeserialize,
  deserializeProp: _roomCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'postgresId': IndexSchema(
      id: 7386607967474333024,
      name: r'postgresId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'postgresId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _roomCollectionGetId,
  getLinks: _roomCollectionGetLinks,
  attach: _roomCollectionAttach,
  version: '3.1.0+1',
);

int _roomCollectionEstimateSize(
  RoomCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.lastMessagePayload;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.roomName.length * 3;
  return bytesCount;
}

void _roomCollectionSerialize(
  RoomCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isGroup);
  writer.writeString(offsets[1], object.lastMessagePayload);
  writer.writeDateTime(offsets[2], object.lastMessageTime);
  writer.writeLong(offsets[3], object.postgresId);
  writer.writeString(offsets[4], object.roomName);
  writer.writeLong(offsets[5], object.unreadCount);
}

RoomCollection _roomCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RoomCollection(
    isGroup: reader.readBool(offsets[0]),
    lastMessagePayload: reader.readStringOrNull(offsets[1]),
    lastMessageTime: reader.readDateTimeOrNull(offsets[2]),
    postgresId: reader.readLong(offsets[3]),
    roomName: reader.readString(offsets[4]),
    unreadCount: reader.readLong(offsets[5]),
  );
  object.id = id;
  return object;
}

P _roomCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _roomCollectionGetId(RoomCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _roomCollectionGetLinks(RoomCollection object) {
  return [];
}

void _roomCollectionAttach(
    IsarCollection<dynamic> col, Id id, RoomCollection object) {
  object.id = id;
}

extension RoomCollectionByIndex on IsarCollection<RoomCollection> {
  Future<RoomCollection?> getByPostgresId(int postgresId) {
    return getByIndex(r'postgresId', [postgresId]);
  }

  RoomCollection? getByPostgresIdSync(int postgresId) {
    return getByIndexSync(r'postgresId', [postgresId]);
  }

  Future<bool> deleteByPostgresId(int postgresId) {
    return deleteByIndex(r'postgresId', [postgresId]);
  }

  bool deleteByPostgresIdSync(int postgresId) {
    return deleteByIndexSync(r'postgresId', [postgresId]);
  }

  Future<List<RoomCollection?>> getAllByPostgresId(List<int> postgresIdValues) {
    final values = postgresIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'postgresId', values);
  }

  List<RoomCollection?> getAllByPostgresIdSync(List<int> postgresIdValues) {
    final values = postgresIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'postgresId', values);
  }

  Future<int> deleteAllByPostgresId(List<int> postgresIdValues) {
    final values = postgresIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'postgresId', values);
  }

  int deleteAllByPostgresIdSync(List<int> postgresIdValues) {
    final values = postgresIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'postgresId', values);
  }

  Future<Id> putByPostgresId(RoomCollection object) {
    return putByIndex(r'postgresId', object);
  }

  Id putByPostgresIdSync(RoomCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'postgresId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPostgresId(List<RoomCollection> objects) {
    return putAllByIndex(r'postgresId', objects);
  }

  List<Id> putAllByPostgresIdSync(List<RoomCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'postgresId', objects, saveLinks: saveLinks);
  }
}

extension RoomCollectionQueryWhereSort
    on QueryBuilder<RoomCollection, RoomCollection, QWhere> {
  QueryBuilder<RoomCollection, RoomCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhere> anyPostgresId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'postgresId'),
      );
    });
  }
}

extension RoomCollectionQueryWhere
    on QueryBuilder<RoomCollection, RoomCollection, QWhereClause> {
  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause> idBetween(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      postgresIdEqualTo(int postgresId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'postgresId',
        value: [postgresId],
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      postgresIdNotEqualTo(int postgresId) {
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      postgresIdGreaterThan(
    int postgresId, {
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      postgresIdLessThan(
    int postgresId, {
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterWhereClause>
      postgresIdBetween(
    int lowerPostgresId,
    int upperPostgresId, {
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
}

extension RoomCollectionQueryFilter
    on QueryBuilder<RoomCollection, RoomCollection, QFilterCondition> {
  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      isGroupEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGroup',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessagePayloadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMessagePayload',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessagePayloadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMessagePayload',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessagePayloadEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessagePayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessagePayloadGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMessagePayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessagePayloadLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMessagePayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessagePayloadBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMessagePayload',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessagePayloadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastMessagePayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessagePayloadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastMessagePayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessagePayloadContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastMessagePayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessagePayloadMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastMessagePayload',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessagePayloadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessagePayload',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessagePayloadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastMessagePayload',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessageTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMessageTime',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessageTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMessageTime',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessageTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMessageTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessageTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMessageTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessageTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMessageTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      lastMessageTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMessageTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      postgresIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'postgresId',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      postgresIdGreaterThan(
    int value, {
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      postgresIdLessThan(
    int value, {
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      postgresIdBetween(
    int lower,
    int upper, {
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

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomName',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      roomNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomName',
        value: '',
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      unreadCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unreadCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      unreadCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unreadCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      unreadCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unreadCount',
        value: value,
      ));
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterFilterCondition>
      unreadCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unreadCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RoomCollectionQueryObject
    on QueryBuilder<RoomCollection, RoomCollection, QFilterCondition> {}

extension RoomCollectionQueryLinks
    on QueryBuilder<RoomCollection, RoomCollection, QFilterCondition> {}

extension RoomCollectionQuerySortBy
    on QueryBuilder<RoomCollection, RoomCollection, QSortBy> {
  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByIsGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByLastMessagePayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessagePayload', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByLastMessagePayloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessagePayload', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByLastMessageTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageTime', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByLastMessageTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageTime', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByPostgresId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postgresId', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByPostgresIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postgresId', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> sortByRoomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomName', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByRoomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomName', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByUnreadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadCount', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      sortByUnreadCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadCount', Sort.desc);
    });
  }
}

extension RoomCollectionQuerySortThenBy
    on QueryBuilder<RoomCollection, RoomCollection, QSortThenBy> {
  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByIsGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGroup', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByLastMessagePayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessagePayload', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByLastMessagePayloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessagePayload', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByLastMessageTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageTime', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByLastMessageTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMessageTime', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByPostgresId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postgresId', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByPostgresIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postgresId', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy> thenByRoomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomName', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByRoomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomName', Sort.desc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByUnreadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadCount', Sort.asc);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QAfterSortBy>
      thenByUnreadCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unreadCount', Sort.desc);
    });
  }
}

extension RoomCollectionQueryWhereDistinct
    on QueryBuilder<RoomCollection, RoomCollection, QDistinct> {
  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByIsGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGroup');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByLastMessagePayload({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMessagePayload',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByLastMessageTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMessageTime');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByPostgresId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'postgresId');
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct> distinctByRoomName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RoomCollection, RoomCollection, QDistinct>
      distinctByUnreadCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unreadCount');
    });
  }
}

extension RoomCollectionQueryProperty
    on QueryBuilder<RoomCollection, RoomCollection, QQueryProperty> {
  QueryBuilder<RoomCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RoomCollection, bool, QQueryOperations> isGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGroup');
    });
  }

  QueryBuilder<RoomCollection, String?, QQueryOperations>
      lastMessagePayloadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMessagePayload');
    });
  }

  QueryBuilder<RoomCollection, DateTime?, QQueryOperations>
      lastMessageTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMessageTime');
    });
  }

  QueryBuilder<RoomCollection, int, QQueryOperations> postgresIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'postgresId');
    });
  }

  QueryBuilder<RoomCollection, String, QQueryOperations> roomNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomName');
    });
  }

  QueryBuilder<RoomCollection, int, QQueryOperations> unreadCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unreadCount');
    });
  }
}
