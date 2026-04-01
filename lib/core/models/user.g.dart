// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const UserSchema = Schema(
  name: r'User',
  id: -7838171048429979076,
  properties: {
    r'doIFollowHim': PropertySchema(
      id: 0,
      name: r'doIFollowHim',
      type: IsarType.bool,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.string,
    ),
    r'image': PropertySchema(
      id: 2,
      name: r'image',
      type: IsarType.string,
    ),
    r'isHasNewStory': PropertySchema(
      id: 3,
      name: r'isHasNewStory',
      type: IsarType.bool,
    ),
    r'isMe': PropertySchema(
      id: 4,
      name: r'isMe',
      type: IsarType.bool,
    ),
    r'nickName': PropertySchema(
      id: 5,
      name: r'nickName',
      type: IsarType.string,
    ),
    r'userName': PropertySchema(
      id: 6,
      name: r'userName',
      type: IsarType.string,
    ),
    r'userStories': PropertySchema(
      id: 7,
      name: r'userStories',
      type: IsarType.objectList,
      target: r'Story',
    )
  },
  estimateSize: _userEstimateSize,
  serialize: _userSerialize,
  deserialize: _userDeserialize,
  deserializeProp: _userDeserializeProp,
);

int _userEstimateSize(
  User object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.image;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.nickName.length * 3;
  bytesCount += 3 + object.userName.length * 3;
  bytesCount += 3 + object.userStories.length * 3;
  {
    final offsets = allOffsets[Story]!;
    for (var i = 0; i < object.userStories.length; i++) {
      final value = object.userStories[i];
      bytesCount += StorySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _userSerialize(
  User object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.doIFollowHim);
  writer.writeString(offsets[1], object.id);
  writer.writeString(offsets[2], object.image);
  writer.writeBool(offsets[3], object.isHasNewStory);
  writer.writeBool(offsets[4], object.isMe);
  writer.writeString(offsets[5], object.nickName);
  writer.writeString(offsets[6], object.userName);
  writer.writeObjectList<Story>(
    offsets[7],
    allOffsets,
    StorySchema.serialize,
    object.userStories,
  );
}

User _userDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = User(
    doIFollowHim: reader.readBoolOrNull(offsets[0]) ?? false,
    id: reader.readStringOrNull(offsets[1]) ?? '',
    image: reader.readStringOrNull(offsets[2]),
    nickName: reader.readStringOrNull(offsets[5]) ?? '',
    userName: reader.readStringOrNull(offsets[6]) ?? '',
    userStories: reader.readObjectList<Story>(
          offsets[7],
          StorySchema.deserialize,
          allOffsets,
          Story(),
        ) ??
        const [],
  );
  return object;
}

P _userDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (reader.readObjectList<Story>(
            offset,
            StorySchema.deserialize,
            allOffsets,
            Story(),
          ) ??
          const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension UserQueryFilter on QueryBuilder<User, User, QFilterCondition> {
  QueryBuilder<User, User, QAfterFilterCondition> doIFollowHimEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doIFollowHim',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> idBetween(
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

  QueryBuilder<User, User, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> imageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> imageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> imageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> imageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> imageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> imageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> imageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> imageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> imageContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> imageMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> isHasNewStoryEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHasNewStory',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> isMeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMe',
        value: value,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nickNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nickNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nickNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nickNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nickName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nickNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nickNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nickNameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nickName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nickNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nickName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nickNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickName',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> nickNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nickName',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userNameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userName',
        value: '',
      ));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userStoriesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userStories',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userStoriesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userStories',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userStoriesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userStories',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userStoriesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userStories',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userStoriesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userStories',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> userStoriesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userStories',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension UserQueryObject on QueryBuilder<User, User, QFilterCondition> {
  QueryBuilder<User, User, QAfterFilterCondition> userStoriesElement(
      FilterQuery<Story> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'userStories');
    });
  }
}
