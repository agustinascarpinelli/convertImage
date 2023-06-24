import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:image_to_text/screens/home_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with SingleTickerProviderStateMixin{
  late final AnimationController _controller;

  @override
  void initState() {
   
    super.initState();
 _controller=AnimationController(vsync: this);

  }

  @override
  void dispose() {
   _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFd6f2e5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animation.json',
            controller: _controller,
            onLoaded: (compos){
              _controller
              ..duration=compos.duration * 2
              ..forward().then((value) {
                Navigator.pushReplacement(context,
                  PageRouteBuilder(
                    pageBuilder: (context,animation,secondaryAnimation)=>
                    const HomeScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation,child: child,);
                    },
                    transitionDuration: const Duration(milliseconds: 3000)
                    ));
              }); 
            },
            width: 300,
            height: 400),
             AnimatedTextKit(
              isRepeatingAnimation: false,
              totalRepeatCount: 1,
              animatedTexts:[
                WavyAnimatedText(
                  'Image to text converter' ,textStyle: const TextStyle(color: Colors.deepPurple,fontSize: 30,fontWeight: FontWeight.bold)
                  )
              ] 
             )
          ],
        ),
      ),
    );
  }
}