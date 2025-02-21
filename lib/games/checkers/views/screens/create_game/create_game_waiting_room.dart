import 'package:checkers_mobile_client/games/checkers/utils/string_validation.dart';
import 'package:checkers_mobile_client/games/checkers/views/widgets/chevron_border.dart';
import 'package:checkers_mobile_client/games/checkers/views/widgets/divider_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:checkers_mobile_client/games/checkers/checkers_game_controller.dart';
import 'package:checkers_mobile_client/games/checkers/providers/checkers_provider.dart';
import 'package:checkers_mobile_client/models/enums.dart';
import 'package:checkers_mobile_client/widgets/error_dialog.dart';

class CheckersWaitingRoom extends ConsumerWidget {
  final CheckersGameController _gameController;
  final GameMode? _gameMode;

  const CheckersWaitingRoom(this._gameController,
      {super.key, GameMode? gameMode})
      : _gameMode = gameMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(checkersSessionProvider);
    if (session == null) {
      Future.microtask(() {
        _gameController.updatePlayState(PlayState.welcome);
      });
    }
    return session == null
        ? const Center(
            child: Text('Not In a session!\n You should not see this.'))
        : Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 40, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('WAITING ROOM',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                    GestureDetector(
                      onTap: Navigator.of(context).pop,
                      child: Container(
                        decoration: ShapeDecoration(
                            color: Colors.white, shape: ChevronBorder()),
                        padding: EdgeInsets.only(
                            top: 1, left: 8, bottom: 1, right: 31),
                        child: const Text('MENU',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 10,
                decoration: const ShapeDecoration(
                    color: Color(0xFFF3B46E),
                    shape: DividerShape(Color(0xFFF3B46E))),
              ),
              SizedBox(height: 129),
              const Text('Room ID',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              SizedBox(height: 6),
              Container(
                height: 30,
                width: 97,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/waitingRoomID.png'))),
                child: Center(
                    child: Text(session.id,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600))),
              ),
              if (_gameMode == GameMode.token)
                Padding(
                  padding: const EdgeInsets.only(top: 32, right: 70, left: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('Play Amount',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          SizedBox(height: 5),
                          Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFF3B46E)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/svg/starknet.svg'),
                                  Text(session.nextPlayerId,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          Text('Total Prize',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          SizedBox(height: 5),
                          Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFF3B46E))),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/svg/starknet.svg'),
                                  Text(
                                      session.sessionUserStatus.length == 2
                                          ? '${int.parse(session.nextPlayerId) * 2}'
                                          : '0',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 32),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 28,
                        width: 110,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFF3B46E)),
                          gradient: RadialGradient(colors: [
                            Colors.transparent,
                            const Color(0xFFF3B46E).withOpacity(0.9)
                          ], radius: 1.7),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          width: 130,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFF3B46E).withOpacity(0.6),
                                Colors.transparent,
                                Color(0xFFF3B46E).withOpacity(0.6)
                              ],
                              stops: [0.05, 0.4, 1],
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text('Players',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                    const Divider(
                        thickness: 2, color: Color(0xFFF3B46E), height: 2),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: _gameMode == GameMode.token ? 106 : 148),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                  session.sessionUserStatus.first.playerId
                                      .truncate(5),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 4),
                              Container(
                                height: 72,
                                width: 72,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xFFF3B46E)),
                                child: Center(
                                    child: Image.asset(
                                        'assets/images/jason.png',
                                        width: 91,
                                        height: 91)),
                              ),
                            ],
                          ),
                          const Text('VS',
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w600)),
                          Column(
                            children: [
                              Text('????'.truncate(5),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 4),
                              Container(
                                height: 72,
                                width: 72,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Color(0xFFF3B46E), width: 1)),
                                child: Center(
                                    child: SvgPicture.asset(
                                        'assets/svg/userCheckers.svg',
                                        width: 41,
                                        height: 41)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    minimumSize: Size(double.infinity, 43),
                    disabledBackgroundColor: const Color(0xFF32363A),
                    backgroundColor: const Color(0xFFF3B46E),
                    disabledForegroundColor: const Color(0xFF939393),
                    foregroundColor: const Color(0xFF000000),
                    textStyle: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: session.sessionUserStatus
                              .where((element) => element.status == 'PLAYING')
                              .length >=
                          2
                      ? () => _startGame(context, ref)
                      : null,
                  child: Text(
                    session.sessionUserStatus
                                .where((element) => element.status == 'PLAYING')
                                .length >=
                            2
                        ? 'Start Game'
                        : 'Waiting for Players...',
                  ),
                ),
              ),
            ],
          );
  }

  Future<void> _startGame(BuildContext context, WidgetRef ref) async {
    try {
      // Check if we have enough players
      final session = ref.read(checkersSessionProvider);
      if (session == null) {
        throw Exception('No active session found');
      }

      if (session.sessionUserStatus.length < 2) {
        throw Exception('Waiting for more players to join');
      }

      await _gameController.updatePlayState(PlayState.playing);
    } catch (e) {
      if (context.mounted) {
        showErrorDialog(e.toString(), context);
      }
    }
  }
}
