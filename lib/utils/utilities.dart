import 'dart:math';

import 'package:flutter/foundation.dart';

import '../models/prediction.model.dart';
import '../models/search_object.model.dart';

class Utilities {
  static List<Prediction> getPredictions(String value, List<SearchObject> objs) {
    String query = value.toLowerCase();
    final List<Prediction> predictions = <Prediction>[];
    //search all properties of the specials and assign the matching properties' strings to the predictions list
    // if there's a name that matches, add it to the predictions list
    // if there's a description that matches, add "name: up to five words surrounding the match" to the predictions list
    // if both name and description match, add the name to the predictions list
    // if there's no match, return an empty list
    for (SearchObject obj in objs) {
      if (obj.name.toLowerCase().contains(query)) {
        predictions.add(Prediction(specialId: obj.id, matchingString:decorateName(obj.name, query)));
      } else if (obj.prop1 != null && obj.prop1!.toLowerCase().contains(query)) {
        String matchingString = "${obj.name}: ${decorateString(obj.prop1!, query)}";
        predictions.add(Prediction(specialId: obj.id, matchingString: matchingString));
      } else if (obj.prop2 != null && obj.prop2!.toLowerCase().contains(query)) {
        String matchingString = "${obj.name}: ${decorateString(obj.prop2!, query)}";
        predictions.add(Prediction(specialId: obj.id, matchingString: matchingString));
      }
    }
    return predictions;
  }

  static String decorateString(String match, String query) {
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

  static String decorateName(String match, String query) {
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

  static String toTitleCase(String text) {
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