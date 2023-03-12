import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/screensWidget/text_widget.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: TextWidget(text: " You don't have anything yet "));
  }
}
