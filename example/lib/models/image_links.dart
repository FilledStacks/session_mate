import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_links.freezed.dart';
part 'image_links.g.dart';

@freezed
class ImageLinks with _$ImageLinks {
  ImageLinks._();

  factory ImageLinks({
    required String smallThumbnail,
    required String thumbnail,
  }) = _ImageLinks;

  factory ImageLinks.fromJson(Map<String, dynamic> json) =>
      _$ImageLinksFromJson(json);

  factory ImageLinks.empty() => ImageLinks(
        smallThumbnail: '',
        thumbnail: '',
      );
}
