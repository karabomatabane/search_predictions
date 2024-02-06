// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:search_predictions/widgets/search_with_predictions.dart';

import 'models/special.model.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Special> specials = <Special>[
    Special (
      id: "1",
      name: "Pizza Bonanza",
      description: "Buy one pizza get one free. This special is limited to 2 pizzas per customer."
          "The special is only valid on Mondays and Tuesdays. The special is not valid on public holidays."
          "You can choose from any of our pizzas. The special is not valid for delivery.",
    ),
    Special (
      id: "2",
      name: "Bottomless Mondays",
      description: "Bottomless Mondays is a special where you can eat as much as you want for a fixed price."
          "The special is only valid on Mondays. The special is not valid on public holidays. The special is not valid for takeaways.",
    ),
    Special (
      id: "3",
      name: "Weekend Special",
      description: "The weekend special is a special where you can get a free drink with every meal."
          "The special is only valid on Saturdays and Sundays. The special is not valid on public holidays."
          "The special is not valid for takeaways. The special is not valid for delivery.",
    ),
    Special (
      id: "4",
      name: "Plant-based Special",
      description: "this is the description for special 4. the special is about lentils and rice",
    ),
    Special (
      id: "5",
      name: "Special 5",
      description: "Special 5 description",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PredictiveSearch(specials: specials),
            ),
            const Center(
              child: Text(
                'Home Page',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
