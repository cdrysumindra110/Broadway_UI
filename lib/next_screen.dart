import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Alignment> animation;
  late Animation<Color?> colorAnimation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );
    animation = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
    colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));

    // animation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
    //   controller,
    //   // CurvedAnimation(parent: controller, curve: Curves.bounceOut)
    // );
    // animation.addListener(() {
    //   setState(() {});
    // });
    // controller.repeat();
  }

  void animatedBox() {
    controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () => animatedBox(),
            child: Column(
              children: [
                Column(children: AnimateList(
  interval: 400.ms,
  effects: [FadeEffect(duration: 300.ms)],
  children: [Text("Hello"), Text("World"),  Text("Goodbye")],
)),

                AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Align(
                      alignment: animation.value,
                      child: AnimatedBuilder(
                        animation: colorAnimation,
                        builder: (BuildContext context, Widget? child) {
                          return Container(
                            height: 100,
                            width: 100,
                            color: colorAnimation.value,

                            // height: animation.value,
                            // width: animation.value,
                            // color: animation.value,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // child: Transform.rotate(
          //   angle: animation.value,
          //   child: Icon(Icons.refresh, size: 100, color: Colors.orange),
          // ),
        ),
      ),
    );
  }
}
