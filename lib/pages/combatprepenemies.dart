import 'package:dmhelper/pages/combatturnorder.dart';
import 'package:flutter/material.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/pages/charactercreator.dart';
import 'package:provider/provider.dart';

class CombatPrepEnemies extends StatelessWidget {
  const CombatPrepEnemies({super.key});

  void addToCombatEnemies() {
    for (var char in chars) {
      for (int i = 0; i < char.amount; i++) {
        combat.opponentes.add(char);
      }
    }
    for(var char in combat.opponentes) {
      combat.partake.add(char);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Combat Preparations Enemies"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            combat.heroes.clear();
            combat.opponentes.clear(); 
            combat.partake.clear();
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CharactercreatorPage(
                        template: true,
                        index: 0,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Add an Enemy",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const Expanded(
                child: CombatPrepEnemiesList(),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                addToCombatEnemies();
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CombatTurnOrderPage())
                );
              },
              child: const Text("Combat"),
            ),
          ),
        ],
      ),
    );
  }
}

class CombatPrepEnemiesList extends StatefulWidget {
  const CombatPrepEnemiesList({super.key});

  @override
  State<CombatPrepEnemiesList> createState() => _CombatPrepEnemiesListState();
}

class _CombatPrepEnemiesListState extends State<CombatPrepEnemiesList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Updater>(builder: (context, value, child) {
      return ListView.builder(
        itemCount: chars.length,
        itemBuilder: (context, index) {
          return CombatPrepEnemiesCard(index: index);
        },
      );
    });
  }
}

class CombatPrepEnemiesCard extends StatefulWidget {
  final int index;
  const CombatPrepEnemiesCard({super.key, required this.index});

  @override
  State<CombatPrepEnemiesCard> createState() => _CombatPrepEnemiesCardState();
}

class _CombatPrepEnemiesCardState extends State<CombatPrepEnemiesCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: Colors.grey[200],
        title: Text(
          chars[widget.index].name,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (chars[widget.index].amount > 0) {
                  setState(() {
                    chars[widget.index].amount--;
                  });
                }
              },
            ),
            Text('${chars[widget.index].amount}'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  chars[widget.index].amount++;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
