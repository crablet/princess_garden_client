import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/starlight/starlight.dart';

import 'business/scene/snowfall/sky_background.dart';

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
        children: const [
          Positioned.fill(child: SkyBackground()),
          // 注意这里一定要有约束，不然CustomPainter拿到的size和width都是0
          Positioned.fill(child: StarLight()),
        ],
      ),
    );
  }
}
