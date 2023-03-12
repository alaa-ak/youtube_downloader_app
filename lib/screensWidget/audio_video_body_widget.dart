import 'package:flutter/material.dart';
import '../utils/dimensions.dart';
import 'list_view_widget.dart';

class AudioVideoBodyWidget extends StatelessWidget {
  const AudioVideoBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Dimensions.height300 * 3,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: Dimensions.height10 + Dimensions.height8,
          left: Dimensions.width10,
          right: Dimensions.width10,
        ),
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.height10,
            ),
            const Expanded(
              flex: 10,
              child: ListViewWidget(),
            )
          ],
        ));
  }
}
