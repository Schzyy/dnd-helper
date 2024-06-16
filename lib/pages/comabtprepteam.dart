import 'package:dmhelper/models/updater.dart';
import 'package:dmhelper/pages/combatprepenemies.dart';
import 'package:flutter/material.dart';
import 'package:dmhelper/models/campaign.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/pages/charactercreator.dart';
import 'package:provider/provider.dart';

class CombatPrepTeam extends StatelessWidget {
  final int indexCampaign;

  const CombatPrepTeam({super.key, required this.indexCampaign});

  void addToCombatHeroes() {
    for (var char in campaigns[indexCampaign].characters) {
      if (char.participate) {
        combat.heroes.add(char);
        print(combat.heroes);
      }
    }
    for(var char in combat.heroes) {
      combat.partake.add(char);
      print(combat.partake);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Combat Preparations Team"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            combat.heroes.clear();
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
                      builder: (context) => CharactercreatorPage(
                        template: false,
                        index: indexCampaign,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Add a Hero",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Expanded(
                child: CombatPrepTeamList(indexCampaign: indexCampaign),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                addToCombatHeroes();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CombatPrepEnemies()));
              },
              child: const Text("Enemies"),
            ),
          ),
        ],
      ),
    );
  }
}

class CombatPrepTeamList extends StatefulWidget {
  final int indexCampaign;
  const CombatPrepTeamList({
    super.key,
    required this.indexCampaign,
  });

  @override
  State<CombatPrepTeamList> createState() => _CombatPrepTeamListState();
}

class _CombatPrepTeamListState extends State<CombatPrepTeamList> {
  late Map<Character,bool>? charsToFight = {};

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Updater>(builder: (context, value, child) {
      return ListView.builder(
        itemCount: campaigns[widget.indexCampaign].characters.length,
        itemBuilder: (context, index) {
          return CombatPrepTeamCard(
            campaignIndex: widget.indexCampaign,
            index: index,
          );
        },
      );
    });
  }
}

class CombatPrepTeamCard extends StatefulWidget {
  final int index;
  final int campaignIndex;

  const CombatPrepTeamCard({
    super.key,
    required this.campaignIndex,
    required this.index,
  });

  @override
  State<CombatPrepTeamCard> createState() => _CombatPrepTeamCardState();
}

class _CombatPrepTeamCardState extends State<CombatPrepTeamCard> {
  bool add = true;

  void toggleIcon(int indexCampaign, int indexCharacter) {
    setState(() {
      add = !add;
      campaigns[widget.campaignIndex].characters[widget.index].participate = add;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: add ? Colors.grey[200] : Colors.black54,
        title: Text(
          campaigns[widget.campaignIndex].characters[widget.index].name,
        ),
        trailing: IconButton(
          icon: Icon(add ? Icons.remove : Icons.add),
          onPressed: () {
            toggleIcon(widget.campaignIndex, widget.index);
          },
        ),
      ),
    );
  }
}
