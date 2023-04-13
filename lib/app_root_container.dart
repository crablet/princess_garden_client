import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/atom/atom.dart';
import 'package:princess_garden_client/business/scene/snowfall/snowflakes.dart';
import 'package:princess_garden_client/business/scene/starlight/starlight.dart';
import 'package:princess_garden_client/business/scene/the_eye_of_the_deep_sea/the_eye_of_the_deep_sea.dart';

import 'base/background_widget.dart';
import 'business/scene/dizzy_rotation/dizzy_rotation.dart';
import 'business/scene/snowfall/sky_background.dart';

class AppRootContainer extends StatefulWidget {
  const AppRootContainer({super.key});

  @override
  State<AppRootContainer> createState() => _AppRootContainerState();
}

class _AppRootContainerState extends State<AppRootContainer> {
  late List<BackgroundWidget> _backgroundWidgets;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _backgroundWidgets = [
      BackgroundWidget(
        widget: const Atom(),
        duration: const Duration(milliseconds: 5300),
      ),
      BackgroundWidget(
        widget: const DizzyRotation(),
        duration: const Duration(milliseconds: 5300),
      ),
      BackgroundWidget(
        widget: const Snowflakes(),
        duration: const Duration(milliseconds: 5300),
      ),
      BackgroundWidget(
        widget: const StarLight(),
        duration: const Duration(milliseconds: 5300),
      ),
      BackgroundWidget(
        widget: const TheEyeOfDeepSea(),
        duration: const Duration(milliseconds: 5300),
      ),
    ];
  }

  void _switchBackground() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _backgroundWidgets.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:  [
          const Positioned.fill(child: SkyBackground()),
          // 注意这里一定要有约束，不然CustomPainter拿到的size和width都是0
          Positioned.fill(child: _backgroundWidgets[_currentIndex].widget),
        ],
      ),
    );
  }
}
