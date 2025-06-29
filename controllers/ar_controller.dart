import 'dart:math';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import '../models/pollutant_model.dart';
import '../widgets/pm25_info_panel.dart';

class ARPollutionController {
  final ARSessionManager sessionManager;
  final ARObjectManager objectManager;
  final BuildContext context;

  ARPollutionController({
    required this.sessionManager,
    required this.objectManager,
    required this.context,
  });

  final _random = Random();
  final _pm25Data = PollutantModel(
    name: "PM2.5 (Fine Particulate Matter)",
    definition: "Particles <2.5µm that penetrate deep into lungs.",
    sources: "Vehicle exhaust, industrial emissions, biomass burning.",
    healthEffects: "Asthma, heart disease, premature death.",
  );

  Future<void> spawnParticles(int count) async {
    for (int i = 0; i < count; i++) {
      final position = vector.Vector3(
        _random.nextDouble() * 1.5 - 0.75,
        _random.nextDouble() * 1.5,
        -_random.nextDouble() * 1.5 - 0.5,
      );

      final node = ARNode(
        type: NodeType.localGLTF2,
        uri: "assets/models/pm25.glb",
        scale: vector.Vector3.all(0.05),
        position: position,
        rotation: vector.Vector4(0, 1, 0, _random.nextDouble() * 360),
      );

      await objectManager.addNode(node);
    }
  }

  void handleTap(List<ARHitTestResult> hits) {
    showDialog(
      context: context,
      builder: (_) => PM25InfoPanel(data: _pm25Data),
    );
  }
}
