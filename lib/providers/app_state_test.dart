import 'package:checkers_mobile_client/models/app_state.dart';
import 'package:checkers_mobile_client/providers/app_state.dart';

class AppStateTest extends AppState {
  AppStateTest() : super();

  @override
  AppStateData build() {
    return AppStateData();
  }

  @override
  void selectGameSessionId(String? game, String? id) {
    state = state.copyWith(selectedGame: game, selectedGameSessionId: id);
  }
}
