import 'package:dmhelper/models/campaign.dart';
import 'package:dmhelper/models/pallete.dart';
import 'package:dmhelper/pages/combatturnorder.dart';
import 'package:flutter/material.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CombatPrepEnemies extends StatelessWidget {
  final int indexCampaign;

  const CombatPrepEnemies({super.key, required this.indexCampaign});

  void addEnemiesToCombat() {
  for (int i = 0; i < chars.length; i++) {
    Character original = chars[i];
    for (int j = 0; j < original.amount; j++) {
      combat.opponentes.add(Character.copy(original));
    }
  }
}

void addEnemiesToPartake() {
  for (int i = 0; i < combat.opponentes.length; i++) {
    Character original = combat.opponentes[i];
    Character temp = Character.copy(original);
    if (i > 0) {
      temp.name = "${temp.name} $i";
    }
    combat.partake.add(temp);
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
              left: 20,
              child: GestureDetector(
                onTap: () {
                  combat.partake.clear();
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppProperties.enemyRed,
                    borderRadius: BorderRadius.circular(AppProperties.bRadius*3)
                  ),
                  height: 60,
                  width: 60,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 40
                    )
                  ),
                ),
              ),
          Positioned(
              bottom: 30,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  if(combat.partake.isEmpty) {
                    for(int i = 0; i < combat.heroes.length; i++) {
                      combat.partake.add(combat.heroes[i]);
                    }
                  }
                addEnemiesToCombat();
                addEnemiesToPartake();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CombatTurnOrderPage())
                  ).then(
                    (value) {
                      combat.partake.clear();
                      combat.opponentes.clear();
                      Provider.of<Updater>(context, listen: false).refresh();
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppProperties.enemyRed,
                    borderRadius: BorderRadius.circular(AppProperties.bRadius*3)
                  ),
                  height: 60,
                  width: 60,
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 40,
                    color: Colors.white,
                    )
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
  void initState() {
    for(int i = 0; i < chars.length; i++) {
      chars[i].amount = 0;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(17.5, 40, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                  'lib/assets/combatIcon.svg',
                  height: 24,
                 ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(5,0,0,0),
                  child: Text(
                    "COMBAT PREP",
                    style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      HelperFunctions.cancelCombat(context, 2);
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 15, 10),
                      child: Icon(FontAwesomeIcons.x,
                          color: Colors.white, 
                          size: 30,
                          ),
                    ),
                  ),
                ],
              ),  
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(17.5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: const Text(
            "ADD ENEMIES",
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
  int getAllParticipatingEnemies() {
    int count = 1;
    for(int i = 0; i < chars.length ; i++) {
      count += chars[i].amount;
    }
    return count;
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Updater>(builder: (context, value, child) {
    return Container(
      margin: const EdgeInsets.fromLTRB(17.5, 20, 20, 0),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 55,
              width: 140,
              decoration: BoxDecoration(
                color: AppProperties.cardColor2,
                borderRadius: BorderRadius.circular(AppProperties.bRadius),
                border: Border.all(color: Colors.white)
              ),
              child: Center(
                child: Text(
                  "${getAllParticipatingEnemies()-1} Enemies",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  });
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
        padding: const EdgeInsets.all(8),
        itemCount: chars.length,
        itemBuilder: (context, characterIndex) {
          return CombatEnemyCard(
            indexCharacter: characterIndex, 
          );
        },
      );
    });
  }
}

class CombatEnemyCard extends StatelessWidget {
  final int indexCharacter;
  const CombatEnemyCard(
      {super.key,  
      required this.indexCharacter, 
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Card(
        color: const Color.fromARGB(255, 55, 55, 55),
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppProperties.cardRadius)
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppProperties.enemyRed,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppProperties.cardRadius),
                  bottomLeft: Radius.circular(AppProperties.cardRadius)
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,10,0),
                      child: SvgPicture.asset(
                        'lib/assets/npcIcon.svg',
                        color: AppProperties.enemyRedDark,
                      )
                    ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10.0, 15.0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 4,
                          child: FittedBox(
                            child: Text(
                              chars[indexCharacter].name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20
                              ),
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
                              if(chars[indexCharacter].amount > 0) {
                                chars[indexCharacter].amount--;
                              }                             
                              Provider.of<Updater>(context, listen: false).refresh();
                            }
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(chars[indexCharacter].amount.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600
                          ),
                          )
                        ),
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                            child: const Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.white,
                            ),
                            onTap: () {
                              chars[indexCharacter].amount++;
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          Text(
                            chars[indexCharacter].race,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(10,0,0,0),
                              child: Text(
                              chars[indexCharacter].characterclass,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10,
                              ),
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
