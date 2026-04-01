// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPostCollection on Isar {
  IsarCollection<Post> get posts => this.collection();
}

const PostSchema = CollectionSchema(
  name: r'Post',
  id: -1683556178151468304,
  properties: {
    r'caption': PropertySchema(
      id: 0,
      name: r'caption',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.string,
    ),
    r'isFavorite': PropertySchema(
      id: 2,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'isSaved': PropertySchema(
      id: 3,
      name: r'isSaved',
      type: IsarType.bool,
    ),
    r'numOfComments': PropertySchema(
      id: 4,
      name: r'numOfComments',
      type: IsarType.long,
    ),
    r'numOfLikes': PropertySchema(
      id: 5,
      name: r'numOfLikes',
      type: IsarType.long,
    ),
    r'postContents': PropertySchema(
      id: 6,
      name: r'postContents',
      type: IsarType.stringList,
    ),
    r'user': PropertySchema(
      id: 7,
      name: r'user',
      type: IsarType.object,
      target: r'User',
    )
  },
  estimateSize: _postEstimateSize,
  serialize: _postSerialize,
  deserialize: _postDeserialize,
  deserializeProp: _postDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'User': UserSchema, r'Story': StorySchema},
  getId: _postGetId,
  getLinks: _postGetLinks,
  attach: _postAttach,
  version: '3.1.0+1',
);

int _postEstimateSize(
  Post object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.caption.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.postContents.length * 3;
  {
    for (var i = 0; i < object.postContents.length; i++) {
      final value = object.postContents[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount +=
      3 + UserSchema.estimateSize(object.user, allOffsets[User]!, allOffsets);
  return bytesCount;
}

void _postSerialize(
  Post object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.caption);
  writer.writeString(offsets[1], object.id);
  writer.writeBool(offsets[2], object.isFavorite);
  writer.writeBool(offsets[3], object.isSaved);
  writer.writeLong(offsets[4], object.numOfComments);
  writer.writeLong(offsets[5], object.numOfLikes);
  writer.writeStringList(offsets[6], object.postContents);
  writer.writeObject<User>(
    offsets[7],
    allOffsets,
    UserSchema.serialize,
    object.user,
  );
}

Post _postDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Post(
    caption: reader.readString(offsets[0]),
    id: reader.readString(offsets[1]),
    isFavorite: reader.readBool(offsets[2]),
    isSaved: reader.readBool(offsets[3]),
    numOfComments: reader.readLong(offsets[4]),
    numOfLikes: reader.readLong(offsets[5]),
    postContents: reader.readStringList(offsets[6]) ?? [],
    user: reader.readObjectOrNull<User>(
          offsets[7],
          UserSchema.deserialize,
          allOffsets,
        ) ??
        User(),
  );
  object.isarId = id;
  return object;
}

P _postDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readStringList(offset) ?? []) as P;
    case 7:
      return (reader.readObjectOrNull<User>(
            offset,
            UserSchema.deserialize,
            allOffsets,
          ) ??
          User()) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _postGetId(Post object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _postGetLinks(Post object) {
  return [];
}

void _postAttach(IsarCollection<dynamic> col, Id id, Post object) {
  object.isarId = id;
}

extension PostByIndex on IsarCollection<Post> {
  Future<Post?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  Post? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<Post?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<Post?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(Post object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(Post object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<Post> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<Post> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension PostQueryWhereSort on QueryBuilder<Post, Post, QWhere> {
  QueryBuilder<Post, Post, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PostQueryWhere on QueryBuilder<Post, Post, QWhereClause> {
  QueryBuilder<Post, Post, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterWhereClause> isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Post, Post, QAfterWhereClause> isarIdGreaterThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<Post, Post, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Post, Post, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterWhereClause> idNotEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PostQueryFilter on QueryBuilder<Post, Post, QFilterCondition> {
  QueryBuilder<Post, Post, QAfterFilterCondition> captionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> captionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'caption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> captionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'caption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> captionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'caption',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> captionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'caption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> captionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'caption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> captionContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'caption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> captionMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'caption',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> captionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caption',
        value: '',
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> captionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'caption',
        value: '',
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> isFavoriteEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> isSavedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSaved',
        value: value,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> numOfCommentsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numOfComments',
        value: value,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> numOfCommentsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numOfComments',
        value: value,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> numOfCommentsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numOfComments',
        value: value,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> numOfCommentsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numOfComments',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> numOfLikesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numOfLikes',
        value: value,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> numOfLikesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numOfLikes',
        value: value,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> numOfLikesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numOfLikes',
        value: value,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> numOfLikesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numOfLikes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> postContentsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'postContents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition>
      postContentsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'postContents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> postContentsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'postContents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> postContentsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'postContents',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> postContentsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'postContents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> postContentsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'postContents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> postContentsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'postContents',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> postContentsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'postContents',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> postContentsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'postContents',
        value: '',
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition>
      postContentsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'postContents',
        value: '',
      ));
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> postContentsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'postContents',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> postContentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'postContents',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> postContentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'postContents',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> postContentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'postContents',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> postContentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'postContents',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Post, Post, QAfterFilterCondition> postContentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'postContents',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension PostQueryObject on QueryBuilder<Post, Post, QFilterCondition> {
  QueryBuilder<Post, Post, QAfterFilterCondition> user(FilterQuery<User> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'user');
    });
  }
}

extension PostQueryLinks on QueryBuilder<Post, Post, QFilterCondition> {}

extension PostQuerySortBy on QueryBuilder<Post, Post, QSortBy> {
  QueryBuilder<Post, Post, QAfterSortBy> sortByCaption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caption', Sort.asc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> sortByCaptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caption', Sort.desc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> sortByIsSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSaved', Sort.asc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> sortByIsSavedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSaved', Sort.desc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> sortByNumOfComments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numOfComments', Sort.asc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> sortByNumOfCommentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numOfComments', Sort.desc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> sortByNumOfLikes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numOfLikes', Sort.asc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> sortByNumOfLikesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numOfLikes', Sort.desc);
    });
  }
}

extension PostQuerySortThenBy on QueryBuilder<Post, Post, QSortThenBy> {
  QueryBuilder<Post, Post, QAfterSortBy> thenByCaption() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caption', Sort.asc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> thenByCaptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caption', Sort.desc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> thenByIsSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSaved', Sort.asc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> thenByIsSavedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSaved', Sort.desc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> thenByNumOfComments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numOfComments', Sort.asc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> thenByNumOfCommentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numOfComments', Sort.desc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> thenByNumOfLikes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numOfLikes', Sort.asc);
    });
  }

  QueryBuilder<Post, Post, QAfterSortBy> thenByNumOfLikesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numOfLikes', Sort.desc);
    });
  }
}

extension PostQueryWhereDistinct on QueryBuilder<Post, Post, QDistinct> {
  QueryBuilder<Post, Post, QDistinct> distinctByCaption(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'caption', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Post, Post, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Post, Post, QDistinct> distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<Post, Post, QDistinct> distinctByIsSaved() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSaved');
    });
  }

  QueryBuilder<Post, Post, QDistinct> distinctByNumOfComments() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numOfComments');
    });
  }

  QueryBuilder<Post, Post, QDistinct> distinctByNumOfLikes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numOfLikes');
    });
  }

  QueryBuilder<Post, Post, QDistinct> distinctByPostContents() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'postContents');
    });
  }
}

extension PostQueryProperty on QueryBuilder<Post, Post, QQueryProperty> {
  QueryBuilder<Post, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<Post, String, QQueryOperations> captionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'caption');
    });
  }

  QueryBuilder<Post, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Post, bool, QQueryOperations> isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<Post, bool, QQueryOperations> isSavedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSaved');
    });
  }

  QueryBuilder<Post, int, QQueryOperations> numOfCommentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numOfComments');
    });
  }

  QueryBuilder<Post, int, QQueryOperations> numOfLikesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numOfLikes');
    });
  }

  QueryBuilder<Post, List<String>, QQueryOperations> postContentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'postContents');
    });
  }

  QueryBuilder<Post, User, QQueryOperations> userProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'user');
    });
  }
}
