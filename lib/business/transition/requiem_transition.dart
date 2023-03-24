import 'package:flutter/material.dart';

class RequiemTransition extends StatefulWidget {
  const RequiemTransition({Key? key}) : super(key: key);

  @override
  State<RequiemTransition> createState() => _RequiemTransitionState();
}

class _RequiemTransitionState extends State<RequiemTransition> {
  double _opacity = 0.0;
  bool _showWhiteContainer = true;

  Future<void> _startAnimation() async {
    await Future.delayed(
      const Duration(
        milliseconds: 530,
      ),
    );
    setState(() {
      _opacity = 1.0;
    });

    await Future.delayed(
      const Duration(
        milliseconds: 5300,
        seconds: 3,
      ),
    );
    setState(() {
      _showWhiteContainer = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_showWhiteContainer)
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(microseconds: 5300),
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
