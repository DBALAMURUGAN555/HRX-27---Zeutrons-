import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'controllers/ar_controller.dart';

class TryARPage extends StatefulWidget {
  const TryARPage({super.key});

  @override
  State<TryARPage> createState() => _TryARPageState();
}

class _TryARPageState extends State<TryARPage> {
  late ARSessionManager _sessionManager;
  late ARObjectManager _objectManager;
  ARPollutionController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PM2.5 AR Visualizer")),
      body: ARView(
        onARViewCreated: _onARViewCreated,
        planeDetectionConfig: PlaneDetectionConfig.horizontal,
      ),
    );
  }

  void _onARViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager anchorManager,
    ARLocationManager locationManager,
  ) {
    _sessionManager = sessionManager;
    _objectManager = objectManager;

    _controller = ARPollutionController(
      sessionManager: sessionManager,
      objectManager: objectManager,
      context: context,
    );

    _sessionManager.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      handleTaps: true,
    );

    _objectManager.onInitialize();
    _objectManager.onNodeTap = (nodes) => _controller?.handleTap([]);

    _controller?.spawnParticles(5);
  }
}