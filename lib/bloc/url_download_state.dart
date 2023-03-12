part of 'url_download_bloc.dart';

@immutable
abstract class UrlDownloadState {}

class UrlInitialState extends UrlDownloadState {}

class EmptyUrlState extends UrlDownloadState {}

class ExistUrlState extends UrlDownloadState {}

class ShowDialog extends UrlDownloadState {}

class LoadUrlDownloadState extends UrlDownloadState {}

class CheckUrlDownloadTypeState extends UrlDownloadState {}

class SuccessUrlDownloadState extends UrlDownloadState {
  final Widget _widget;
  Widget get widget => _widget;
  SuccessUrlDownloadState(this._widget);
}

class UpdateDataState extends UrlDownloadState {}

class ErrorUrlDownloadState extends UrlDownloadState {
  String error;
  ErrorUrlDownloadState({required this.error});
}
