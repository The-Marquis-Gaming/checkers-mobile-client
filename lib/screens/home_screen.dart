import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:checkers_mobile_client/dialog/auth_dialog.dart';
import 'package:checkers_mobile_client/providers/app_state.dart';
import 'package:checkers_mobile_client/providers/starknet.dart';
import 'package:checkers_mobile_client/router/route_path.dart';
import 'package:checkers_mobile_client/widgets/balance_appbar.dart';
import 'package:checkers_mobile_client/widgets/locked_game_widget.dart';
import 'package:checkers_mobile_client/widgets/ui_widgets.dart';

class HomePath extends AppRoutePath {
  @override
  String getRouteInformation() {
    return '/';
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool showBalance = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 64),
                Image.asset('assets/images/banner.png',
                    width: MediaQuery.of(context).size.width, fit: BoxFit.fill),
              ],
            ),
            Column(
              children: [
                AppBar(
                  backgroundColor: Colors.white.withOpacity(0.02),
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light,
                      statusBarBrightness: Brightness.light),
                  title: const BalanceAppBar(),
                ),
                const SizedBox(height: 24.0),
                const ListTile(
                  title: Text('Top picks',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                  subtitle: Text('Lets explore our games',
                      style: TextStyle(fontSize: 12)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Stack(
                        children: [
                          Image.asset('assets/images/checkers.png',
                              fit: BoxFit.fitWidth,
                              color: Colors.black.withAlpha(100),
                              colorBlendMode: BlendMode.darken),
                          const Positioned(
                            bottom: 0,
                            left: 0,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Board Game',
                                      style: TextStyle(fontSize: 12)),
                                  Text('Checkers',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: IconButton(
                                onPressed: () async {
                                  final starknet = ref.read(starknetProvider);
                                  if (starknet.signerAccount == null) {
                                    await ref
                                        .read(starknetProvider.notifier)
                                        .initAccount();
                                    return;
                                  }
                                  ref
                                      .read(appStateProvider.notifier)
                                      .selectGame("checkers");
                                },
                                icon: const Icon(Icons.arrow_forward, size: 32),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white.withAlpha(100),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String gameType;
  final String imagePath;
  final bool isActive;
  final bool isPopular;
  final Function()? onPlay;

  const GameCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.gameType,
    required this.imagePath,
    required this.isActive,
    required this.isPopular,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 8,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          width: 220,
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  imagePath,
                  width: 220,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ), // Replace with the actual asset
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: MyChip(
                          title: gameType,
                          icon: FontAwesomeIcons.dice,
                          isLightColor: true,
                          color: Theme.of(context).colorScheme.primary,
                          iconPadding: 8,
                        ),
                      ),
                      if (isPopular)
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: MyChip(
                            title: 'Hot',
                            icon: Icons.local_fire_department,
                            isLightColor: false,
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        if (isActive)
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: MyChip(
                              title: '300+ Players',
                              icon: Icons.people,
                              isLightColor: false,
                              color: Colors.transparent,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isActive)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 1.8,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                    ),
                    onPressed: () {
                      if (onPlay != null) {
                        onPlay!();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'PLAY',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyChip extends StatelessWidget {
  const MyChip({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.isLightColor,
    this.iconPadding = 4,
  });
  final IconData icon;
  final String title;
  final Color color;
  final bool isLightColor;
  final double iconPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, iconPadding, 0),
            child: Icon(
              icon,
              color: isLightColor
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurface,
              size: 15,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: isLightColor
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurface,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
