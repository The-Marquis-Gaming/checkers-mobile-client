import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:checkers_mobile_client/providers/app_state.dart';
import 'package:checkers_mobile_client/providers/starknet.dart';
import 'package:upgrader/upgrader.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({
    super.key,
  });
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool isRun = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpgradeAlert(
        dialogStyle: kIsWeb || Platform.isAndroid
            ? UpgradeDialogStyle.material
            : UpgradeDialogStyle.cupertino,
        child: FutureBuilder(future: () async {
          if (isRun) return;
          isRun = true;
          // final connectivityResult = await Connectivity().checkConnectivity();
          // if (connectivityResult == ConnectivityResult.none) {
          //   ref.read(appStateProvider.notifier).setConnectivity(false);
          // } else {
          //   ref.read(appStateProvider.notifier).setConnectivity(true);
          // }
          if (ref.read(appStateProvider).autoLoginResult == null) {
            await ref.read(starknetProvider.notifier).initAccount();
          }
          // if (ref.read(userProvider) != null) {
          //   ref.read(appStateProvider.notifier).setAutoLogin(true);
          //   ref.read(appStateProvider.notifier).syncServer();
          // }
        }(), builder: (context, snapshot) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Image.asset('assets/images/splash_logo.png'),
                ),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                if (snapshot.error != null)
                  Text(
                    snapshot.error.toString(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
