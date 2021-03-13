import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:arkit_plugin/arkit_plugin.dart';

class ARScreen extends StatefulWidget {
  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  ARKitController arkitController;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('ARKit in Flutter')),
      body: ARKitSceneView(onARKitViewCreated: onARKitViewCreated));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    final node = ARKitNode(
        geometry: ARKitSphere(radius: 0.1), position: Vector3(0, 0, -0.5));
    this.arkitController.add(node);
  }
}
