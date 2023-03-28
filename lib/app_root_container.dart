import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/snowfall/snowflakes.dart';

import 'business/scene/snowfall/sky_background.dart';

class AppRootContainer extends StatefulWidget {
  const AppRootContainer({super.key});

  @override
  State<AppRootContainer> createState() => _AppRootContainerState();
}

class _AppRootContainerState extends State<AppRootContainer> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: const [
          SkyBackground(),
          Snowflakes()
        ],
      ),
    );
  }
}
