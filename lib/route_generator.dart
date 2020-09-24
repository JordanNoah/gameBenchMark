import 'package:flutter/material.dart';
import 'package:reactiongame_frontend/src/pages/homeLoginRegister.dart';
import 'package:reactiongame_frontend/src/pages/login.dart';
import 'package:reactiongame_frontend/src/pages/register.dart';
import 'package:reactiongame_frontend/src/pages/configAccount.dart';
import 'package:reactiongame_frontend/src/pages/games.dart';
import 'package:reactiongame_frontend/src/pages/game/reactionTime_game.dart';
import 'package:reactiongame_frontend/src/pages/game/memoryTest_game.dart';
import 'package:reactiongame_frontend/src/pages/game/numberMemory_game.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/homeLogRegister':
        return MaterialPageRoute(builder: (_) => HomeLoginRegister());
        break;
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
        break;
      case '/register':
        return MaterialPageRoute(builder: (_) => Register());
        break;
      case '/configAccount':
        return MaterialPageRoute(builder: (_) => ConfigAccount());
        break;
      case '/listGame':
        return MaterialPageRoute(builder: (_) => Games());
        break;
      case '/reactionTime_game':
        return MaterialPageRoute(builder: (_) => ReactionTime());
        break;
      case '/memoryTest_game':
        return MaterialPageRoute(builder: (_) => MemoryTest());
        break;
      case '/numberMemory_game':
        return MaterialPageRoute(builder: (_) => NumberMemory());
        break;
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text("NO EXISTE RUTA"),
        ),
      );
    });
  }
}
