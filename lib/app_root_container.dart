import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/transition/requiem_transition.dart';

class AppRootContainer extends StatefulWidget {
  const AppRootContainer({super.key});

  @override
  State<AppRootContainer> createState() => _AppRootContainerState();
}

class _AppRootContainerState extends State<AppRootContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue,
            child: const Center(
              child: Text("Welcome to the princess's garden."),
            ),
          ),
          const RequiemTransition(),
        ],
      ),
    );
  }
}
