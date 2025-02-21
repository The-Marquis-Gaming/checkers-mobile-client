// import 'package:magic_sdk/magic_sdk.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:checkers_mobile_client/games/checkers/models/checkers_session.dart';
import 'package:checkers_mobile_client/models/app_state.dart';
import 'package:checkers_mobile_client/models/user.dart';
import 'package:checkers_mobile_client/providers/app_state.dart';
import 'package:checkers_mobile_client/providers/starknet.dart';
import 'package:checkers_mobile_client/router/route_information_parser.dart';
import 'package:checkers_mobile_client/router/router_delegate.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Upgrader.clearSavedSettings(); // REMOVE this for release builds
  await Hive.initFlutter();
  Hive.registerAdapter(AppStateDataImplAdapter());
  Hive.registerAdapter(UserDataImplAdapter());
  Hive.registerAdapter(CheckersSessionDataImplAdapter());
  Hive.registerAdapter(CheckersSessionUserStatusImplAdapter());
  await Future.wait(
      [_loadAppStateBox(), _loadUserBox(), _loadCheckersSessionBox()]);
  runApp(const ProviderScope(child: MyApp()));
  // Magic.instance = Magic("pk_live_D38AAC9114F908B0");
}

Future<void> _loadAppStateBox() async {
  try {
    await Hive.openBox<AppStateData>("appState");
  } catch (e) {
    await Hive.deleteBoxFromDisk("appState");
    await Hive.openBox<AppStateData>("appState");
  }
}

Future<void> _loadUserBox() async {
  try {
    await Hive.openBox<UserData>("user");
  } catch (e) {
    await Hive.deleteBoxFromDisk("user");
    await Hive.openBox<UserData>("user");
  }
}

Future<void> _loadCheckersSessionBox() async {
  try {
    await Hive.openBox<CheckersSessionData>("checkersSession");
  } catch (e) {
    await Hive.deleteBoxFromDisk("checkersSession");
    await Hive.openBox<CheckersSessionData>("checkersSession");
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    ref.watch(starknetProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: appState.isSandbox,
      title: 'The Marquis',
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          surface: const Color(0xff0f1118),
          brightness: Brightness.dark,
        ),
        fontFamily: "Orbitron",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routeInformationParser: AppRouteInformationParser(),
      routerDelegate: ref.watch(routerDelegateProvider),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
