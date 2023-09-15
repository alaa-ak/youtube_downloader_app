import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_downloader_app/data/repositories/url_download_repository.dart';
import 'package:youtube_downloader_app/screens/base_screens/home_screen.dart';
import 'package:youtube_downloader_app/route/route_helper.dart';
import 'bloc/url_download_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final _sharedPreferences = await SharedPreferences.getInstance();

  runApp(RepositoryProvider(
    create: (context) => UrlDownloadRepository(
      urlDownloadEndPoint: '',
      sharedPreferences: _sharedPreferences,
    ),
    child: BlocProvider(
        create: (context) => UrlDownloadBloc(
            RepositoryProvider.of<UrlDownloadRepository>(context),
            RepositoryProvider.of<UrlDownloadRepository>(context)
                .getStorageData()),
        child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: RouteHelper.routes,
    );
  }
}
