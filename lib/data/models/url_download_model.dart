import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:json_annotation/json_annotation.dart';
import 'custom_video_id_converter.dart';
part 'url_download_model.g.dart';

@JsonSerializable()
@CustomVideoIdConverter()
class UrlDownloadModel {
  final VideoId urlDownloadId;
  String urlDownloadTitle;
  final String urlDownloadAuthor;
  final Duration? urlDownloadDuration;
  final String urlDownloadThumbnail;
  String urlDownloadPath;

  UrlDownloadModel({
    required this.urlDownloadId,
    required this.urlDownloadTitle,
    required this.urlDownloadAuthor,
    required this.urlDownloadDuration,
    required this.urlDownloadThumbnail,
    required this.urlDownloadPath,
  });

  factory UrlDownloadModel.formJson(Map<String, dynamic> json) =>
      _$UrlDownloadModelFromJson(json);

  Map<String, dynamic> toJson() => _$UrlDownloadModelToJson(this);
}
