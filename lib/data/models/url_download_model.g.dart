// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_download_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UrlDownloadModel _$UrlDownloadModelFromJson(Map<String, dynamic> json) =>
    UrlDownloadModel(
      urlDownloadId: const CustomVideoIdConverter()
          .fromJson(json['urlDownloadId'] as String),
      urlDownloadTitle: json['urlDownloadTitle'] as String,
      urlDownloadAuthor: json['urlDownloadAuthor'] as String,
      urlDownloadDuration: json['urlDownloadDuration'] == null
          ? null
          : Duration(microseconds: json['urlDownloadDuration'] as int),
      urlDownloadThumbnail: json['urlDownloadThumbnail'] as String,
      urlDownloadPath: json['urlDownloadPath'] as String,
    );

Map<String, dynamic> _$UrlDownloadModelToJson(UrlDownloadModel instance) =>
    <String, dynamic>{
      'urlDownloadId':
          const CustomVideoIdConverter().toJson(instance.urlDownloadId),
      'urlDownloadTitle': instance.urlDownloadTitle,
      'urlDownloadAuthor': instance.urlDownloadAuthor,
      'urlDownloadDuration': instance.urlDownloadDuration?.inMicroseconds,
      'urlDownloadThumbnail': instance.urlDownloadThumbnail,
      'urlDownloadPath': instance.urlDownloadPath,
    };
