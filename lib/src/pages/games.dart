import 'package:flutter/material.dart';
import 'package:reactiongame_frontend/src/widgets/drawer.dart';

class Games extends StatefulWidget {
  Games({Key key}) : super(key: key);

  @override
  _GamesState createState() => _GamesState();
}

class ItemGame {
  final String nameGame;
  final String description;
  final String route;
  const ItemGame(this.nameGame, this.description, this.route);
}

List games = [
  const ItemGame(
      'Reaction time', 'Test your visual reflexes.', 'reactionTime_game'),
  const ItemGame('Memorie test',
      'Remember an increasingly large board of squares.', 'memoryTest_game'),
  const ItemGame('Number memory', 'Are you smarter than a chimpanzee?',
      'numberMemory_game')
];

class _GamesState extends State<Games> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text("Games"),
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: SafeArea(
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 1.5,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(games.length, (index) {
            var game = games[index];
            return GestureDetector(
              onTap: () => {Navigator.of(context).pushNamed('/' + game.route)},
              child: Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      game.nameGame,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      game.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
      endDrawer: DrawerAplication(),
      // Disable opening the end drawer with a swipe gesture.
      endDrawerEnableOpenDragGesture: false,
      drawerEnableOpenDragGesture: true,
    );
  }
}
