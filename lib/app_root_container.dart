import 'dart:async';
import 'dart:math';

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
  final Random _random = Random();
  double _overlayOpacity = 0;

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
    _startTimer(_backgroundWidgets[_currentIndex].duration);
  }

  void _switchBackground() {
    setState(() {
      _currentIndex = _random.nextInt(_backgroundWidgets.length);
    });
    _startTimer(_backgroundWidgets[_currentIndex].duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: SkyBackground()),
          // 注意这里一定要有约束，不然CustomPainter拿到的size和width都是0
          Positioned.fill(child: _backgroundWidgets[_currentIndex].widget),
          AnimatedOpacity(
            opacity: _overlayOpacity,
            duration: const Duration(milliseconds: 5300),
            child: Container(
              color: Colors.white.withOpacity(0.53),
            ),
          ),
        ],
      ),
    );
  }

  void _startTimer(Duration sceneDuration,
      [Duration transitionDuration = const Duration(milliseconds: 5300)]) {
    Future.delayed(sceneDuration, () {
      setState(() {
        _overlayOpacity = 1;
      });
      Future.delayed(transitionDuration, () {
        setState(() {
          _overlayOpacity = 0;
        });
        _switchBackground();
      });
    });
  }
}
