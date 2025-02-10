import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:checkers_mobile_client/models/app_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "app_state.g.dart";

@Riverpod(keepAlive: true)
class AppState extends _$AppState {
  final Box<AppStateData> _hiveBox;

  AppState({Box<AppStateData>? hiveBox})
      : _hiveBox = hiveBox ?? Hive.box<AppStateData>("appState");

  @override
  AppStateData build() {
    return _hiveBox.get("appState", defaultValue: AppStateData())!;
  }

  void changeNavigatorIndex(int newIndex) {
    state = state.copyWith(navigatorIndex: newIndex);
    _hiveBox.put("appState", state);
  }

  void changeTheme(String theme) {
    state = state.copyWith(theme: theme);
    _hiveBox.put("appState", state);
  }

  void selectGame(String? id) {
    state = state.copyWith(
      selectedGame: id,
    );
    _hiveBox.put("appState", state);
  }

  void selectGameSessionId(String? game, String? id) {
    state = state.copyWith(selectedGame: game, selectedGameSessionId: id);
    _hiveBox.put("appState", state);
  }

  void toggleBalanceVisibility() {
    state = state.copyWith(isBalanceVisible: !state.isBalanceVisible);
    _hiveBox.put("isBalanceVisible", state);
  }

  void setConnectivity(bool val) {
    state = state.copyWith(isConnectedInternet: val);
  }
}
