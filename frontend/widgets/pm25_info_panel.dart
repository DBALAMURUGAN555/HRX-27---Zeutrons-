import 'package:flutter/material.dart';
import '../models/pollutant_model.dart';

class PM25InfoPanel extends StatelessWidget {
  final PollutantModel data;
  const PM25InfoPanel({required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(data.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("🧪 ${data.definition}"),
          SizedBox(height: 8),
          Text("🌍 Sources: ${data.sources}"),
          SizedBox(height: 8),
          Text("❤️ Health Effects: ${data.healthEffects}"),
        ],
      ),
      actions: [
        TextButton(
          child: Text("Close"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}