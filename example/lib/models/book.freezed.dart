// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Book _$BookFromJson(Map<String, dynamic> json) {
  return _Book.fromJson(json);
}

/// @nodoc
mixin _$Book {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<String> get authors => throw _privateConstructorUsedError;
  String? get publisher => throw _privateConstructorUsedError;
  String? get publishedDate => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<IndustryIdentifiers>? get industryIdentifiers =>
      throw _privateConstructorUsedError;
  int? get pageCount => throw _privateConstructorUsedError;
  String? get printType => throw _privateConstructorUsedError;
  List<String>? get categories => throw _privateConstructorUsedError;
  ImageLinks? get imageLinks => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  String? get previewLink => throw _privateConstructorUsedError;
  String? get infoLink => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookCopyWith<Book> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookCopyWith<$Res> {
  factory $BookCopyWith(Book value, $Res Function(Book) then) =
      _$BookCopyWithImpl<$Res, Book>;
  @useResult
  $Res call(
      {int id,
      String title,
      List<String> authors,
      String? publisher,
      String? publishedDate,
      String? description,
      List<IndustryIdentifiers>? industryIdentifiers,
      int? pageCount,
      String? printType,
      List<String>? categories,
      ImageLinks? imageLinks,
      String? language,
      String? previewLink,
      String? infoLink});

  $ImageLinksCopyWith<$Res>? get imageLinks;
}

/// @nodoc
class _$BookCopyWithImpl<$Res, $Val extends Book>
    implements $BookCopyWith<$Res> {
  _$BookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? authors = null,
    Object? publisher = freezed,
    Object? publishedDate = freezed,
    Object? description = freezed,
    Object? industryIdentifiers = freezed,
    Object? pageCount = freezed,
    Object? printType = freezed,
    Object? categories = freezed,
    Object? imageLinks = freezed,
    Object? language = freezed,
    Object? previewLink = freezed,
    Object? infoLink = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: null == authors
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      publisher: freezed == publisher
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedDate: freezed == publishedDate
          ? _value.publishedDate
          : publishedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      industryIdentifiers: freezed == industryIdentifiers
          ? _value.industryIdentifiers
          : industryIdentifiers // ignore: cast_nullable_to_non_nullable
              as List<IndustryIdentifiers>?,
      pageCount: freezed == pageCount
          ? _value.pageCount
          : pageCount // ignore: cast_nullable_to_non_nullable
              as int?,
      printType: freezed == printType
          ? _value.printType
          : printType // ignore: cast_nullable_to_non_nullable
              as String?,
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      imageLinks: freezed == imageLinks
          ? _value.imageLinks
          : imageLinks // ignore: cast_nullable_to_non_nullable
              as ImageLinks?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      previewLink: freezed == previewLink
          ? _value.previewLink
          : previewLink // ignore: cast_nullable_to_non_nullable
              as String?,
      infoLink: freezed == infoLink
          ? _value.infoLink
          : infoLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ImageLinksCopyWith<$Res>? get imageLinks {
    if (_value.imageLinks == null) {
      return null;
    }

    return $ImageLinksCopyWith<$Res>(_value.imageLinks!, (value) {
      return _then(_value.copyWith(imageLinks: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BookCopyWith<$Res> implements $BookCopyWith<$Res> {
  factory _$$_BookCopyWith(_$_Book value, $Res Function(_$_Book) then) =
      __$$_BookCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      List<String> authors,
      String? publisher,
      String? publishedDate,
      String? description,
      List<IndustryIdentifiers>? industryIdentifiers,
      int? pageCount,
      String? printType,
      List<String>? categories,
      ImageLinks? imageLinks,
      String? language,
      String? previewLink,
      String? infoLink});

  @override
  $ImageLinksCopyWith<$Res>? get imageLinks;
}

/// @nodoc
class __$$_BookCopyWithImpl<$Res> extends _$BookCopyWithImpl<$Res, _$_Book>
    implements _$$_BookCopyWith<$Res> {
  __$$_BookCopyWithImpl(_$_Book _value, $Res Function(_$_Book) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? authors = null,
    Object? publisher = freezed,
    Object? publishedDate = freezed,
    Object? description = freezed,
    Object? industryIdentifiers = freezed,
    Object? pageCount = freezed,
    Object? printType = freezed,
    Object? categories = freezed,
    Object? imageLinks = freezed,
    Object? language = freezed,
    Object? previewLink = freezed,
    Object? infoLink = freezed,
  }) {
    return _then(_$_Book(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: null == authors
          ? _value._authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      publisher: freezed == publisher
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedDate: freezed == publishedDate
          ? _value.publishedDate
          : publishedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      industryIdentifiers: freezed == industryIdentifiers
          ? _value._industryIdentifiers
          : industryIdentifiers // ignore: cast_nullable_to_non_nullable
              as List<IndustryIdentifiers>?,
      pageCount: freezed == pageCount
          ? _value.pageCount
          : pageCount // ignore: cast_nullable_to_non_nullable
              as int?,
      printType: freezed == printType
          ? _value.printType
          : printType // ignore: cast_nullable_to_non_nullable
              as String?,
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      imageLinks: freezed == imageLinks
          ? _value.imageLinks
          : imageLinks // ignore: cast_nullable_to_non_nullable
              as ImageLinks?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      previewLink: freezed == previewLink
          ? _value.previewLink
          : previewLink // ignore: cast_nullable_to_non_nullable
              as String?,
      infoLink: freezed == infoLink
          ? _value.infoLink
          : infoLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Book extends _Book {
  _$_Book(
      {this.id = 0,
      required this.title,
      required final List<String> authors,
      this.publisher,
      this.publishedDate,
      this.description,
      final List<IndustryIdentifiers>? industryIdentifiers,
      this.pageCount,
      this.printType,
      final List<String>? categories,
      this.imageLinks,
      this.language,
      this.previewLink,
      this.infoLink})
      : _authors = authors,
        _industryIdentifiers = industryIdentifiers,
        _categories = categories,
        super._();

  factory _$_Book.fromJson(Map<String, dynamic> json) => _$$_BookFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  final String title;
  final List<String> _authors;
  @override
  List<String> get authors {
    if (_authors is EqualUnmodifiableListView) return _authors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authors);
  }

  @override
  final String? publisher;
  @override
  final String? publishedDate;
  @override
  final String? description;
  final List<IndustryIdentifiers>? _industryIdentifiers;
  @override
  List<IndustryIdentifiers>? get industryIdentifiers {
    final value = _industryIdentifiers;
    if (value == null) return null;
    if (_industryIdentifiers is EqualUnmodifiableListView)
      return _industryIdentifiers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? pageCount;
  @override
  final String? printType;
  final List<String>? _categories;
  @override
  List<String>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final ImageLinks? imageLinks;
  @override
  final String? language;
  @override
  final String? previewLink;
  @override
  final String? infoLink;

  @override
  String toString() {
    return 'Book(id: $id, title: $title, authors: $authors, publisher: $publisher, publishedDate: $publishedDate, description: $description, industryIdentifiers: $industryIdentifiers, pageCount: $pageCount, printType: $printType, categories: $categories, imageLinks: $imageLinks, language: $language, previewLink: $previewLink, infoLink: $infoLink)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Book &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            (identical(other.publisher, publisher) ||
                other.publisher == publisher) &&
            (identical(other.publishedDate, publishedDate) ||
                other.publishedDate == publishedDate) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._industryIdentifiers, _industryIdentifiers) &&
            (identical(other.pageCount, pageCount) ||
                other.pageCount == pageCount) &&
            (identical(other.printType, printType) ||
                other.printType == printType) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.imageLinks, imageLinks) ||
                other.imageLinks == imageLinks) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.previewLink, previewLink) ||
                other.previewLink == previewLink) &&
            (identical(other.infoLink, infoLink) ||
                other.infoLink == infoLink));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(_authors),
      publisher,
      publishedDate,
      description,
      const DeepCollectionEquality().hash(_industryIdentifiers),
      pageCount,
      printType,
      const DeepCollectionEquality().hash(_categories),
      imageLinks,
      language,
      previewLink,
      infoLink);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BookCopyWith<_$_Book> get copyWith =>
      __$$_BookCopyWithImpl<_$_Book>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookToJson(
      this,
    );
  }
}

abstract class _Book extends Book {
  factory _Book(
      {final int id,
      required final String title,
      required final List<String> authors,
      final String? publisher,
      final String? publishedDate,
      final String? description,
      final List<IndustryIdentifiers>? industryIdentifiers,
      final int? pageCount,
      final String? printType,
      final List<String>? categories,
      final ImageLinks? imageLinks,
      final String? language,
      final String? previewLink,
      final String? infoLink}) = _$_Book;
  _Book._() : super._();

  factory _Book.fromJson(Map<String, dynamic> json) = _$_Book.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  List<String> get authors;
  @override
  String? get publisher;
  @override
  String? get publishedDate;
  @override
  String? get description;
  @override
  List<IndustryIdentifiers>? get industryIdentifiers;
  @override
  int? get pageCount;
  @override
  String? get printType;
  @override
  List<String>? get categories;
  @override
  ImageLinks? get imageLinks;
  @override
  String? get language;
  @override
  String? get previewLink;
  @override
  String? get infoLink;
  @override
  @JsonKey(ignore: true)
  _$$_BookCopyWith<_$_Book> get copyWith => throw _privateConstructorUsedError;
}
