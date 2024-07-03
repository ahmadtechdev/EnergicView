import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors.dart';
import 'signin_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Adjust duration as needed
    );
    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });
    _controller.repeat(reverse: true); // Continuous animation
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: pColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_animation.value * 6.0, 0.0),
                  child: child,
                );
              },
              child: Image.asset(
                'assets/images/logo.png',
                scale: 4,
              ),
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                Get.to(() => const SignInScreen());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                decoration: const BoxDecoration(
                    color: yColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    )),
                child: const Text(
                  "LET'S GO",
                  style: TextStyle(
                    color: wColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
