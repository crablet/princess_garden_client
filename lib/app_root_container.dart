import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:princess_garden_client/business/scene/atom/atom.dart';
import 'package:princess_garden_client/business/scene/colourful_black_hole/colourful_black_hole.dart';
import 'package:princess_garden_client/business/scene/game_of_life/game_of_life.dart';
import 'package:princess_garden_client/business/scene/snowfall/snowflakes.dart';
import 'package:princess_garden_client/business/scene/starlight/starlight.dart';
import 'package:princess_garden_client/business/scene/the_eye_of_the_deep_sea/the_eye_of_the_deep_sea.dart';
import 'package:princess_garden_client/business/transition/requiem_transition.dart';

import 'base/background_widget.dart';
import 'business/scene/dizzy_rotation/dizzy_rotation.dart';

class AppRootContainer extends StatefulWidget {
  const AppRootContainer({super.key});

  @override
  State<AppRootContainer> createState() => _AppRootContainerState();
}

class _AppRootContainerState extends State<AppRootContainer> {
  late List<BackgroundWidget> _backgroundWidgets;
  int _currentIndex = 0;
  final Random _random = Random();
  late Duration _sceneDuration;
  late Duration _transitionDuration;

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
      BackgroundWidget(
        widget: const GameOfLife(),
        duration: const Duration(milliseconds: 5300),
      ),
      BackgroundWidget(
        widget: const ColourfulBlackHole(),
        duration: const Duration(milliseconds: 5300),
      ),
    ];

    _switchBackground();
  }

  void _switchBackground() {
    setState(() {
      _currentIndex = _random.nextInt(_backgroundWidgets.length);
      _sceneDuration = _backgroundWidgets[_currentIndex].duration;
      _transitionDuration = const Duration(milliseconds: 5253);

      debugPrint("_currentIndex: $_currentIndex");
      debugPrint("_sceneDuration: $_sceneDuration");
      debugPrint("_transitionDuration: $_transitionDuration");
      debugPrint("--------------------------");
    });

    Future.delayed(
      _sceneDuration +
          _transitionDuration +
          const Duration(seconds: 2, milliseconds: 530),
      _switchBackground,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 注意这里一定要有约束，不然CustomPainter拿到的size和width都是0
          Positioned.fill(
            key: Key((_currentIndex + _random.nextInt(999)).toString()),
            child: _backgroundWidgets[_currentIndex].widget,
          ),
          RequiemTransition(
            key: Key((_currentIndex + _random.nextInt(999)).toString()),
            sceneDuration: _sceneDuration,
            transitionDuration: _transitionDuration,
          ),
        ],
      ),
    );
  }
}
