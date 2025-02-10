import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part "app_state.freezed.dart";
part "app_state.g.dart";

@freezed
class AppStateData extends HiveObject with _$AppStateData {
  AppStateData._();
  @HiveType(typeId: 0)
  factory AppStateData({
    @HiveField(0) @Default(0) int navigatorIndex,
    @HiveField(1) @Default("system") String theme,
    @HiveField(2) String? selectedGame,
    @HiveField(3) String? selectedGameSessionId,
    @HiveField(4) @Default(true) bool isConnectedInternet,
    @HiveField(5) @Default(false) bool isBalanceVisible,
  }) = _AppStateData;
}
