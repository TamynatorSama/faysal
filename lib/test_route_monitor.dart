import 'package:flutter/material.dart';

class TestRouteMonitor extends NavigatorObserver{
  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    print(previousRoute!);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(previousRoute!);
  }
}