import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:search_predictions/widgets/predictions_list_tile.dart';

import '../models/prediction.model.dart';
import '../models/search_object.model.dart';
import '../models/special.model.dart';
import '../utils/utilities.dart';

class PredictiveSearch extends StatefulWidget {
  /// List of search objects used for predictions.
  final List<SearchObject> objs;
  /// Callback function to execute when a prediction is tapped.
  final VoidCallback onTap;
  /// Placeholder text for the search field.
  String? placeholder;
  PredictiveSearch({super.key, required this.objs, required this.onTap,
    this.placeholder});

  @override
  State<PredictiveSearch> createState() => _PredictiveSearchState();
}

class _PredictiveSearchState extends State<PredictiveSearch> {
  List<Prediction> predictions = <Prediction>[];
  String placeholder = 'Search something...';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
      ),
      child: Column(
        children: <Widget>[
          TextField(
              decoration: InputDecoration(
                hintText: widget.placeholder ?? placeholder,
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            onChanged: (String value) {
              setState(() {
                predictions = Utilities.getPredictions(value, widget.objs);
                if (value.isEmpty) {
                  predictions = <Prediction>[];
                }
              });
            },
          ),
          if (predictions.isNotEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ListView.builder(
                  itemCount: predictions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PredictionsListTile(
                        prediction: predictions[index].matchingString,
                        onTap: widget.onTap);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
