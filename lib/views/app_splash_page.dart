import 'package:rive/rive.dart';
import 'package:flutter/material.dart';

class AppSplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppSplashPageState();
}

class _AppSplashPageState extends State<AppSplashPage> {
  late RiveAnimationController _partAnimation;

  @override
  void initState() {
    super.initState();
    _partAnimation = OneShotAnimation(
      'bounce',
      autoplay: true,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => timeout());
  }

  Future<void> timeout() async => Future.delayed(
      const Duration(milliseconds: 1600
      ),
      () => Navigator.of(context).pushReplacementNamed("/home"));

  @override
  void dispose() {
    _partAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
            padding: const EdgeInsets.all(64),
            color: Colors.white,
            child: RiveAnimation.asset(
              'assets/appiconanim.riv',
              alignment: Alignment.center,
              fit: BoxFit.fitWidth,
              controllers: [_partAnimation],
              animations: const ['Timeline 1'],
            )));
  }
}
