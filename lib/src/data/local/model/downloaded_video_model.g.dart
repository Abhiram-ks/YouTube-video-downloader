// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloaded_video_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDownloadedVideoModelCollection on Isar {
  IsarCollection<DownloadedVideoModel> get downloadedVideoModels =>
      this.collection();
}

const DownloadedVideoModelSchema = CollectionSchema(
  name: r'DownloadedVideoModel',
  id: -8214066469875626179,
  properties: {
    r'author': PropertySchema(id: 0, name: r'author', type: IsarType.string),
    r'downloadedAt': PropertySchema(
      id: 1,
      name: r'downloadedAt',
      type: IsarType.dateTime,
    ),
    r'durationInSeconds': PropertySchema(
      id: 2,
      name: r'durationInSeconds',
      type: IsarType.long,
    ),
    r'filePath': PropertySchema(
      id: 3,
      name: r'filePath',
      type: IsarType.string,
    ),
    r'logo': PropertySchema(id: 4, name: r'logo', type: IsarType.string),
    r'progress': PropertySchema(id: 5, name: r'progress', type: IsarType.long),
    r'qualityLabel': PropertySchema(
      id: 6,
      name: r'qualityLabel',
      type: IsarType.string,
    ),
    r'sizeInBytes': PropertySchema(
      id: 7,
      name: r'sizeInBytes',
      type: IsarType.long,
    ),
    r'status': PropertySchema(
      id: 8,
      name: r'status',
      type: IsarType.byte,
      enumMap: _DownloadedVideoModelstatusEnumValueMap,
    ),
    r'thumbnailUrl': PropertySchema(
      id: 9,
      name: r'thumbnailUrl',
      type: IsarType.string,
    ),
    r'title': PropertySchema(id: 10, name: r'title', type: IsarType.string),
    r'videoId': PropertySchema(id: 11, name: r'videoId', type: IsarType.string),
  },

  estimateSize: _downloadedVideoModelEstimateSize,
  serialize: _downloadedVideoModelSerialize,
  deserialize: _downloadedVideoModelDeserialize,
  deserializeProp: _downloadedVideoModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'videoId': IndexSchema(
      id: 6273887982249211799,
      name: r'videoId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'videoId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'downloadedAt': IndexSchema(
      id: 3153155963019265192,
      name: r'downloadedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'downloadedAt',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _downloadedVideoModelGetId,
  getLinks: _downloadedVideoModelGetLinks,
  attach: _downloadedVideoModelAttach,
  version: '3.3.0',
);

int _downloadedVideoModelEstimateSize(
  DownloadedVideoModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.author.length * 3;
  bytesCount += 3 + object.filePath.length * 3;
  bytesCount += 3 + object.logo.length * 3;
  bytesCount += 3 + object.qualityLabel.length * 3;
  bytesCount += 3 + object.thumbnailUrl.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.videoId.length * 3;
  return bytesCount;
}

void _downloadedVideoModelSerialize(
  DownloadedVideoModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.author);
  writer.writeDateTime(offsets[1], object.downloadedAt);
  writer.writeLong(offsets[2], object.durationInSeconds);
  writer.writeString(offsets[3], object.filePath);
  writer.writeString(offsets[4], object.logo);
  writer.writeLong(offsets[5], object.progress);
  writer.writeString(offsets[6], object.qualityLabel);
  writer.writeLong(offsets[7], object.sizeInBytes);
  writer.writeByte(offsets[8], object.status.index);
  writer.writeString(offsets[9], object.thumbnailUrl);
  writer.writeString(offsets[10], object.title);
  writer.writeString(offsets[11], object.videoId);
}

DownloadedVideoModel _downloadedVideoModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DownloadedVideoModel();
  object.author = reader.readString(offsets[0]);
  object.downloadedAt = reader.readDateTime(offsets[1]);
  object.durationInSeconds = reader.readLong(offsets[2]);
  object.filePath = reader.readString(offsets[3]);
  object.id = id;
  object.logo = reader.readString(offsets[4]);
  object.progress = reader.readLong(offsets[5]);
  object.qualityLabel = reader.readString(offsets[6]);
  object.sizeInBytes = reader.readLongOrNull(offsets[7]);
  object.status =
      _DownloadedVideoModelstatusValueEnumMap[reader.readByteOrNull(
        offsets[8],
      )] ??
      DownloadStatus.processing;
  object.thumbnailUrl = reader.readString(offsets[9]);
  object.title = reader.readString(offsets[10]);
  object.videoId = reader.readString(offsets[11]);
  return object;
}

P _downloadedVideoModelDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (_DownloadedVideoModelstatusValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              DownloadStatus.processing)
          as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _DownloadedVideoModelstatusEnumValueMap = {
  'processing': 0,
  'canceled': 1,
  'completed': 2,
  'retry': 3,
};
const _DownloadedVideoModelstatusValueEnumMap = {
  0: DownloadStatus.processing,
  1: DownloadStatus.canceled,
  2: DownloadStatus.completed,
  3: DownloadStatus.retry,
};

Id _downloadedVideoModelGetId(DownloadedVideoModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _downloadedVideoModelGetLinks(
  DownloadedVideoModel object,
) {
  return [];
}

void _downloadedVideoModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  DownloadedVideoModel object,
) {
  object.id = id;
}

extension DownloadedVideoModelByIndex on IsarCollection<DownloadedVideoModel> {
  Future<DownloadedVideoModel?> getByVideoId(String videoId) {
    return getByIndex(r'videoId', [videoId]);
  }

  DownloadedVideoModel? getByVideoIdSync(String videoId) {
    return getByIndexSync(r'videoId', [videoId]);
  }

  Future<bool> deleteByVideoId(String videoId) {
    return deleteByIndex(r'videoId', [videoId]);
  }

  bool deleteByVideoIdSync(String videoId) {
    return deleteByIndexSync(r'videoId', [videoId]);
  }

  Future<List<DownloadedVideoModel?>> getAllByVideoId(
    List<String> videoIdValues,
  ) {
    final values = videoIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'videoId', values);
  }

  List<DownloadedVideoModel?> getAllByVideoIdSync(List<String> videoIdValues) {
    final values = videoIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'videoId', values);
  }

  Future<int> deleteAllByVideoId(List<String> videoIdValues) {
    final values = videoIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'videoId', values);
  }

  int deleteAllByVideoIdSync(List<String> videoIdValues) {
    final values = videoIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'videoId', values);
  }

  Future<Id> putByVideoId(DownloadedVideoModel object) {
    return putByIndex(r'videoId', object);
  }

  Id putByVideoIdSync(DownloadedVideoModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'videoId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByVideoId(List<DownloadedVideoModel> objects) {
    return putAllByIndex(r'videoId', objects);
  }

  List<Id> putAllByVideoIdSync(
    List<DownloadedVideoModel> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'videoId', objects, saveLinks: saveLinks);
  }
}

extension DownloadedVideoModelQueryWhereSort
    on QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QWhere> {
  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterWhere>
  anyDownloadedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'downloadedAt'),
      );
    });
  }
}

extension DownloadedVideoModelQueryWhere
    on QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QWhereClause> {
  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterWhereClause>
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

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterWhereClause>
  videoIdEqualTo(String videoId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'videoId', value: [videoId]),
      );
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterWhereClause>
  videoIdNotEqualTo(String videoId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'videoId',
                lower: [],
                upper: [videoId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'videoId',
                lower: [videoId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'videoId',
                lower: [videoId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'videoId',
                lower: [],
                upper: [videoId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterWhereClause>
  downloadedAtEqualTo(DateTime downloadedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'downloadedAt',
          value: [downloadedAt],
        ),
      );
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterWhereClause>
  downloadedAtNotEqualTo(DateTime downloadedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'downloadedAt',
                lower: [],
                upper: [downloadedAt],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'downloadedAt',
                lower: [downloadedAt],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'downloadedAt',
                lower: [downloadedAt],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'downloadedAt',
                lower: [],
                upper: [downloadedAt],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterWhereClause>
  downloadedAtGreaterThan(DateTime downloadedAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'downloadedAt',
          lower: [downloadedAt],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterWhereClause>
  downloadedAtLessThan(DateTime downloadedAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'downloadedAt',
          lower: [],
          upper: [downloadedAt],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterWhereClause>
  downloadedAtBetween(
    DateTime lowerDownloadedAt,
    DateTime upperDownloadedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'downloadedAt',
          lower: [lowerDownloadedAt],
          includeLower: includeLower,
          upper: [upperDownloadedAt],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension DownloadedVideoModelQueryFilter
    on
        QueryBuilder<
          DownloadedVideoModel,
          DownloadedVideoModel,
          QFilterCondition
        > {
  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  authorEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'author',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  authorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'author',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  authorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'author',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  authorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'author',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  authorStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'author',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  authorEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'author',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  authorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'author',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  authorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'author',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  authorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'author', value: ''),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  authorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'author', value: ''),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  downloadedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'downloadedAt', value: value),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  downloadedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'downloadedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  downloadedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'downloadedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  downloadedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'downloadedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  durationInSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'durationInSeconds', value: value),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  durationInSecondsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'durationInSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  durationInSecondsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'durationInSeconds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  durationInSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'durationInSeconds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  filePathEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'filePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  filePathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'filePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  filePathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'filePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  filePathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'filePath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  filePathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'filePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  filePathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'filePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  filePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'filePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  filePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'filePath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  filePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'filePath', value: ''),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  filePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'filePath', value: ''),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  logoEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'logo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  logoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'logo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  logoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'logo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  logoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'logo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  logoStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'logo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  logoEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'logo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  logoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'logo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  logoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'logo',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  logoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'logo', value: ''),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  logoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'logo', value: ''),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  progressEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'progress', value: value),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  progressGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'progress',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  progressLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'progress',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  progressBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'progress',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  qualityLabelEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'qualityLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  qualityLabelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'qualityLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  qualityLabelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'qualityLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  qualityLabelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'qualityLabel',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  qualityLabelStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'qualityLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  qualityLabelEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'qualityLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  qualityLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'qualityLabel',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  qualityLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'qualityLabel',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  qualityLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'qualityLabel', value: ''),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  qualityLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'qualityLabel', value: ''),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  sizeInBytesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'sizeInBytes'),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  sizeInBytesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'sizeInBytes'),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  sizeInBytesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sizeInBytes', value: value),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  sizeInBytesGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sizeInBytes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  sizeInBytesLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sizeInBytes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  sizeInBytesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sizeInBytes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  statusEqualTo(DownloadStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: value),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  statusGreaterThan(DownloadStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  statusLessThan(DownloadStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  statusBetween(
    DownloadStatus lower,
    DownloadStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  thumbnailUrlEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'thumbnailUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  thumbnailUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'thumbnailUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  thumbnailUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'thumbnailUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  thumbnailUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'thumbnailUrl',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  thumbnailUrlStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'thumbnailUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  thumbnailUrlEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'thumbnailUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  thumbnailUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'thumbnailUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  thumbnailUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'thumbnailUrl',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  thumbnailUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'thumbnailUrl', value: ''),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  thumbnailUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'thumbnailUrl', value: ''),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  titleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  titleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  videoIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'videoId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  videoIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'videoId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  videoIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'videoId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  videoIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'videoId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  videoIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'videoId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  videoIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'videoId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  videoIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'videoId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  videoIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'videoId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  videoIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'videoId', value: ''),
      );
    });
  }

  QueryBuilder<
    DownloadedVideoModel,
    DownloadedVideoModel,
    QAfterFilterCondition
  >
  videoIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'videoId', value: ''),
      );
    });
  }
}

extension DownloadedVideoModelQueryObject
    on
        QueryBuilder<
          DownloadedVideoModel,
          DownloadedVideoModel,
          QFilterCondition
        > {}

extension DownloadedVideoModelQueryLinks
    on
        QueryBuilder<
          DownloadedVideoModel,
          DownloadedVideoModel,
          QFilterCondition
        > {}

extension DownloadedVideoModelQuerySortBy
    on QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QSortBy> {
  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByAuthor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByAuthorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByDownloadedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedAt', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByDownloadedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedAt', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInSeconds', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByDurationInSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInSeconds', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByFilePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filePath', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByFilePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filePath', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByLogo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logo', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByLogoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logo', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByQualityLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityLabel', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByQualityLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityLabel', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortBySizeInBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeInBytes', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortBySizeInBytesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeInBytes', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByThumbnailUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailUrl', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByThumbnailUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailUrl', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByVideoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoId', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  sortByVideoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoId', Sort.desc);
    });
  }
}

extension DownloadedVideoModelQuerySortThenBy
    on QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QSortThenBy> {
  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByAuthor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByAuthorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'author', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByDownloadedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedAt', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByDownloadedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadedAt', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInSeconds', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByDurationInSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInSeconds', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByFilePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filePath', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByFilePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filePath', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByLogo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logo', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByLogoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logo', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByQualityLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityLabel', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByQualityLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityLabel', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenBySizeInBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeInBytes', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenBySizeInBytesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeInBytes', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByThumbnailUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailUrl', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByThumbnailUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailUrl', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByVideoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoId', Sort.asc);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QAfterSortBy>
  thenByVideoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'videoId', Sort.desc);
    });
  }
}

extension DownloadedVideoModelQueryWhereDistinct
    on QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QDistinct> {
  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QDistinct>
  distinctByAuthor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'author', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QDistinct>
  distinctByDownloadedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'downloadedAt');
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QDistinct>
  distinctByDurationInSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationInSeconds');
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QDistinct>
  distinctByFilePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'filePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QDistinct>
  distinctByLogo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QDistinct>
  distinctByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progress');
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QDistinct>
  distinctByQualityLabel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qualityLabel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QDistinct>
  distinctBySizeInBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sizeInBytes');
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QDistinct>
  distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QDistinct>
  distinctByThumbnailUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thumbnailUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QDistinct>
  distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadedVideoModel, QDistinct>
  distinctByVideoId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'videoId', caseSensitive: caseSensitive);
    });
  }
}

extension DownloadedVideoModelQueryProperty
    on
        QueryBuilder<
          DownloadedVideoModel,
          DownloadedVideoModel,
          QQueryProperty
        > {
  QueryBuilder<DownloadedVideoModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DownloadedVideoModel, String, QQueryOperations>
  authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'author');
    });
  }

  QueryBuilder<DownloadedVideoModel, DateTime, QQueryOperations>
  downloadedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'downloadedAt');
    });
  }

  QueryBuilder<DownloadedVideoModel, int, QQueryOperations>
  durationInSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationInSeconds');
    });
  }

  QueryBuilder<DownloadedVideoModel, String, QQueryOperations>
  filePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'filePath');
    });
  }

  QueryBuilder<DownloadedVideoModel, String, QQueryOperations> logoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logo');
    });
  }

  QueryBuilder<DownloadedVideoModel, int, QQueryOperations> progressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progress');
    });
  }

  QueryBuilder<DownloadedVideoModel, String, QQueryOperations>
  qualityLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qualityLabel');
    });
  }

  QueryBuilder<DownloadedVideoModel, int?, QQueryOperations>
  sizeInBytesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sizeInBytes');
    });
  }

  QueryBuilder<DownloadedVideoModel, DownloadStatus, QQueryOperations>
  statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<DownloadedVideoModel, String, QQueryOperations>
  thumbnailUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thumbnailUrl');
    });
  }

  QueryBuilder<DownloadedVideoModel, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<DownloadedVideoModel, String, QQueryOperations>
  videoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'videoId');
    });
  }
}
