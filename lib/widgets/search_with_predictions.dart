import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:search_predictions/widgets/predictions_list_tile.dart';

import '../models/prediction.model.dart';
import '../models/special.model.dart';

class PredictiveSearch extends StatefulWidget {
  final List<Special> specials;
  const PredictiveSearch({super.key, required this.specials});

  @override
  State<PredictiveSearch> createState() => _PredictiveSearchState();
}

class _PredictiveSearchState extends State<PredictiveSearch> {
  List<Prediction> predictions = <Prediction>[];
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
                hintText: 'Search something...',
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
                predictions = getPredictions(value);
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
                        onTap: () {});
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Prediction> getPredictions(String value) {
    String query = value.toLowerCase();
    final List<Prediction> predictions = <Prediction>[];
    //search all properties of the specials and assign the matching properties' strings to the predictions list
    // if there's a name that matches, add it to the predictions list
    // if there's a description that matches, add "name: up to five words surrounding the match" to the predictions list
    // if both name and description match, add the name to the predictions list
    // if there's no match, return an empty list
    for (Special special in widget.specials) {
      if (special.name.toLowerCase().contains(query)) {
        predictions.add(Prediction(specialId: special.id, matchingString:decorateName(special.name, query)));
      } else if (special.description.toLowerCase().contains(query)) {
        String matchingString = "${special.name}: ${decorateString(special.description, query)}";
        predictions.add(Prediction(specialId: special.id, matchingString: matchingString));
      }
    }
    return predictions;
  }

  String decorateString(String match, String query) {
    final int index = match.toLowerCase().indexOf(query);
    final int length = query.length;
    match = match.replaceFirst(RegExp(query, caseSensitive: false), "*$query*").toLowerCase();
    if (kDebugMode) {
      print("MATCH: $match");
    }
    final List<String> words = match.split(" ");
    final int matchIndex = words.indexWhere((String word) => word.toLowerCase().contains(query));
    final String firstPart = '... ${words.sublist(max(matchIndex - 5, 0), matchIndex).join(" ")}';
    final String queryPart = words[matchIndex];
    final String secondPart = '${words.sublist(matchIndex + 1, min(words.length, matchIndex + 3)).join(" ")} ...';
    return "$firstPart $queryPart $secondPart";
  }

  String decorateName(String match, String query) {
    final int index = match.toLowerCase().indexOf(query);
    final int length = query.length;
    match = toTitleCase(match.replaceFirst(RegExp(query, caseSensitive: false), "*$query*"));
    if (kDebugMode) {
      print("MATCH: $match");
    }
    final List<String> words = match.split(" ");
    final int matchIndex = words.indexWhere((String word) => word.toLowerCase().contains(query));
    final String firstPart = words.sublist(max(matchIndex - 5, 0), matchIndex).join(" ");
    final String queryPart = words[matchIndex];
    final String secondPart = words.sublist(matchIndex + 1, min(words.length, matchIndex + 3)).join(" ");
    return "$firstPart $queryPart $secondPart";
  }

  String toTitleCase(String text) {
    String output = '';
    text.split(' ').map((String word) {
      if(word[0] == '*' && word.substring(1).isNotEmpty) {
        output += '*${word[1].toUpperCase()}${word.substring(2)} ';
        return;
      }
      output += '${word[0].toUpperCase()}${word.substring(1)} ';
    }).toList();
    return output.trim();
  }
}
