import 'package:dmhelper/models/pallete.dart';
import 'package:dmhelper/pages/combatturnorder.dart';
import 'package:flutter/material.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/pages/charactercreator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CombatPrepEnemies extends StatelessWidget {
  final int indexCampaign;

  const CombatPrepEnemies({super.key, required this.indexCampaign});

  void addToCombatHeroes() {
    for (var char in campaigns[indexCampaign].characters) {
      if (char.participate) {
        combat.heroes.add(char);
      }
    }
    for(var char in combat.heroes) {
      combat.partake.add(char);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const CombatEnemyViewTopBar(),
              CombatViewAddEnemy(campaingIndex: indexCampaign),
              Expanded(
                child: CombatEnemyView(index: indexCampaign),
              ),
            ],
          ),
          Positioned(
              bottom: 30,
              right: 20,
              child: GestureDetector(
                onTap: () {
            },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppProperties.enemyRed,
                    borderRadius: BorderRadius.circular(AppProperties.bRadius)
                  ),
                  height: 50,
                  width: 50,
                  child: FittedBox(child: Icon(Icons.keyboard_double_arrow_right)),
                ),
              ),
            ),
            
        ],
      ),
    );
  }
}

class CombatEnemyViewTopBar extends StatefulWidget {
  const CombatEnemyViewTopBar({super.key});

  @override
  State<CombatEnemyViewTopBar> createState() => _CombatEnemyViewTopBar();
}

class _CombatEnemyViewTopBar extends State<CombatEnemyViewTopBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(5,10,10,10),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppProperties.enemyRed,
                    size: 40
                  ),
                ),
              ),
              const Text(
                "Combat Prep",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Add Heroes",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class CombatViewAddEnemy extends StatefulWidget {
  const CombatViewAddEnemy({super.key, required this.campaingIndex});
  final int campaingIndex;

  @override
  State<CombatViewAddEnemy> createState() => _CombatViewAddEnemy();
}

class _CombatViewAddEnemy extends State<CombatViewAddEnemy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 60,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppProperties.bRadius),
            ),
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 55,
              width: 140,
              decoration: BoxDecoration(
                color: AppProperties.cardColor2,
                borderRadius: BorderRadius.circular(AppProperties.bRadius),
              ),
              child: Center(
                child: Text(
                  '${campaigns[widget.campaingIndex].characters.length} Participants',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppProperties.bRadius)
              ),
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 50,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Charactercreator(
                    good: true, 
                    charIndex: 0, 
                    campaignIndex: widget.campaingIndex, 
                    newChar: true
                  )
                )
              );
            },
          )
        ],
      ),
    );
  }
}

class CombatEnemyView extends StatefulWidget {
  final int index;
  const CombatEnemyView({super.key, required this.index});

  @override
  State<CombatEnemyView> createState() => _CombatHeroView();
}

class _CombatHeroView extends State<CombatEnemyView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Updater>(builder: (context, value, child) {
      return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: campaigns[widget.index].characters.length,
        itemBuilder: (context, characterIndex) {
          return CombatEnemyCard(
            indexCampaing: widget.index,
            indexCharacter: characterIndex, 
            index: widget.index,
          );
        },
      );
    });
  }
}

class CombatEnemyCard extends StatelessWidget {
  final int indexCampaing;
  final int indexCharacter;
  final int index;
  const CombatEnemyCard(
      {super.key, 
      required this.indexCampaing, 
      required this.indexCharacter, 
      required this.index
      });

  @override
  Widget build(BuildContext context) {
    final character = campaigns[indexCampaing].characters[indexCharacter];
    return SizedBox(
      height: AppProperties.screenHeight(context)*0.5,
      child: Card(
        color: const Color.fromARGB(255, 55, 55, 55),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppProperties.enemyRed,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)
                )
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10,10,10,0),
                      child: Icon(
                        FontAwesomeIcons.shield,
                        size: 30,
                      ),
                    ),
                  RotatedBox(
                    quarterTurns: 135,
                    child: Text(
                      "Enemy",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppProperties.enemyRedDark,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 4,
                          child: Text(
                            character.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 30
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                            child: const Icon(
                              Icons.remove,
                              size: 30,
                              color: Colors.white,
                            ),
                            onTap: () {
                              campaigns[indexCampaing].characters.removeAt(indexCharacter);
                              Provider.of<Updater>(context, listen: false).refresh();
                            }
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            character.race,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            ),
                        ),
                          Flexible(
                          flex: 1,
                            child: Text(
                            character.characterclass,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            ),
                          ),
                          const Flexible(
                          flex: 1,
                            child: Text(
                            "10",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            ),
                          ),
                        Flexible(
                          flex: 1,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.shield,
                                size: 35,
                                color: AppProperties.enemyRed,
                              ),
                              Text(
                                character.armorClass.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        
      ),
    );
  }
}
