import 'package:checkers_mobile_client/games/checkers/checkers_main.dart';
import 'package:checkers_mobile_client/router/route_path.dart';
import 'package:checkers_mobile_client/screens/game_screen.dart';
import 'package:checkers_mobile_client/screens/home_screen.dart';
import 'package:checkers_mobile_client/screens/page_not_found_screen.dart';

import 'package:flutter/material.dart';
import 'package:checkers_mobile_client/screens/profile_screen.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = routeInformation.uri;
    if (uri.pathSegments.isEmpty) {
      return HomePath();
    } else {
      final first = uri.pathSegments[0];
      switch (first) {
        // case 'signup':
        //   return SignUpPath();
        case 'profile':
          return ProfilePath();
        case 'game':
          if (uri.pathSegments.length >= 2) {
            if (uri.pathSegments[1] == 'checkers' &&
                uri.pathSegments.length == 3) {
              return CheckersGameAppPath(uri.pathSegments[2]);
            }
            return GamePath(uri.pathSegments[1]);
          }
          break;
        default:
      }
    }
    return PageNotFoundPath();
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath configuration) {
    return RouteInformation(
        uri: Uri.parse(configuration.getRouteInformation()));
  }
}
