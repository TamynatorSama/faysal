import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin{


  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this,duration: const Duration(seconds: 2))..addListener(() {
      setState(() {
        
      });
      if(controller.isCompleted){
        controller.reverse();
      }
    })..forward()..repeat();
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedRotation(
        turns: controller.value * math.pi ,
        duration: controller.duration! ,
        child: AnimatedScale(
          duration: controller.duration!,
          scale: controller.value+0.5,
          child: SvgPicture.asset("assets/svg/single-logo.svg"))),
    );
  }
}