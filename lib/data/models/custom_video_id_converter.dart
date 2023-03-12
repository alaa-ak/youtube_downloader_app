import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class CustomVideoIdConverter extends JsonConverter<VideoId, String> {
  const CustomVideoIdConverter();
  @override
  VideoId fromJson(String json) => VideoId(json);

  @override
  String toJson(VideoId object) => object.value;
}
