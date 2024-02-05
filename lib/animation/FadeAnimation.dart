import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sa4_migration_kit/sa4_migration_kit.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AnimProps>()
      ..add(AnimProps.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(AnimProps.translateY, Tween(begin: -30.0, end: 0.0));

    return PlayAnimationBuilder<MultiTweenValues<AnimProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      builder: (context, animation, child) {
        final opacity = animation.get(AnimProps.opacity);
        final translateY = animation.get(AnimProps.translateY);

        if (opacity != null && translateY != null) {
          return Opacity(
            opacity: opacity,
            child: Transform.translate(
              offset: Offset(0, translateY),
              child: child,
            ),
          );
        } else {
          return Container();
        }
      },
      child: child,
    );
  }
}

enum AnimProps { opacity, translateY }
