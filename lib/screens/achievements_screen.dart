import 'package:flutter/material.dart';
import 'package:checkers_mobile_client/router/route_path.dart';

class AchievementsPath extends AppRoutePath {
  @override
  String getRouteInformation() {
    return '/achievements';
  }
}

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Achievements\nComming Soon"),
      ),
    );
  }
}
