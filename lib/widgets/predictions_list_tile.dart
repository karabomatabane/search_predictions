// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class PredictionsListTile extends StatelessWidget {
  final String prediction;
  final VoidCallback onTap;
  const PredictionsListTile({super.key, required this.prediction, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Check if prediction contains '*' for bolding
    bool shouldBold = prediction.contains('*');
    String nonBoldText = '', boldText = '', lastNonBoldText = '';
    if (shouldBold) {
      //find first part of the string (non-bold)
      nonBoldText = prediction.split('*')[0];
      //find second part of the string (bold)
      boldText = prediction.split('*')[1];
      //find last part of the string (non-bold)
      lastNonBoldText = prediction.split('*')[2];
    }

    // Remove '*' for display, if present
    String displayPrediction = prediction.replaceAll('*', '');
    return Column(
        children: <Widget> [
          ListTile(
            onTap: onTap,
            horizontalTitleGap: 0,
            leading: const Icon(Icons.restaurant),
            title: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child:  shouldBold
                  ? RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: nonBoldText),
                    TextSpan(
                      text: boldText,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: lastNonBoldText),
                  ],
                ),
              )
                  : Text(
                displayPrediction,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Divider(
            height: 2,
            thickness: 2,
            color: Colors.grey[200],
          ),
        ]
    );
  }
}