import 'package:dmhelper/models/campaign.dart';
import 'package:dmhelper/models/pallete.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:dmhelper/pages/combatprepenemies.dart';
import 'package:flutter/material.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/pages/charactercreator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CombatPrepTeam extends StatelessWidget {
  final int indexCampaign;

  const CombatPrepTeam({super.key, required this.indexCampaign});
  void addHeroesToPartake() {
    for (int i = 0; i < campaigns[indexCampaign].characters.length; i++) {
      Character original = campaigns[indexCampaign].characters[i];
      if (original.participate == true) {
        combat.heroes.add(Character.copy(original));
        combat.partake.add(Character.copy(original));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              CombatHeroesViewTopBar(
                campaingIndex: indexCampaign,
              ),
              CombatViewAddHero(campaingIndex: indexCampaign),
              Expanded(
                child: CombatHeroView(index: indexCampaign),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: GestureDetector(
              onTap: () {
                addHeroesToPartake();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const CombatPrepEnemies(indexCampaign: 0),
                  ),
                ).then(
                  (value) {
                    combat.partake.clear();
                    combat.opponentes.clear();
                    combat.heroes.clear();
                  },
                );
              },
              child: Container(
              decoration: BoxDecoration(
                  color: AppProperties.enemyRed,
                  borderRadius: BorderRadius.circular(AppProperties.bRadius*3)),
              height: 60,
              width: 60,
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 40,
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CombatHeroesViewTopBar extends StatefulWidget {
  const CombatHeroesViewTopBar({
    super.key,
    required this.campaingIndex,
  });
  final int campaingIndex;
  @override
  State<CombatHeroesViewTopBar> createState() => _CombatHeroesViewTopBar();
}

class _CombatHeroesViewTopBar extends State<CombatHeroesViewTopBar> {
  
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
                      HelperFunctions.cancelCombat(context, 1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 15, 10),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Icon(FontAwesomeIcons.x,
                            color: Colors.white, 
                            size: 30,
                            ),
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
            "ADD HEROES",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class CombatViewAddHero extends StatefulWidget {
  const CombatViewAddHero({super.key, required this.campaingIndex});
  final int campaingIndex;

  @override
  State<CombatViewAddHero> createState() => _CombatViewAddHero();
}

class _CombatViewAddHero extends State<CombatViewAddHero> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int getAllParticipatingTeam() {
    int count = 0;
    for(int i = 0; i < campaigns[widget.campaingIndex].characters.length ; i++) {
      if(campaigns[widget.campaingIndex].characters[i].participate == true) {
        count++;
      }
    }
    return count;
  }
  int count = getAllParticipatingTeam();
    return Consumer<Updater>(builder: (context, value, child) {
    return Container(
      margin: const EdgeInsets.fromLTRB(17.5, 20, 20, 0),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Container(
              height: 55,
              width: 170,
              decoration: BoxDecoration(
                color: AppProperties.cardColor2,
                borderRadius: BorderRadius.circular(AppProperties.bRadius),
                border: Border.all(color: Colors.white)
              ),
              child: Center(
                child: Text(
                  campaigns[widget.campaingIndex].characters.length < 2
                      ? '${getAllParticipatingTeam()} Participant'
                      : '${getAllParticipatingTeam()} Participants',
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

class CombatHeroView extends StatefulWidget {
  final int index;
  const CombatHeroView({super.key, required this.index});

  @override
  State<CombatHeroView> createState() => _CombatHeroView();
}

class _CombatHeroView extends State<CombatHeroView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Updater>(builder: (context, value, child) {
      return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: campaigns[widget.index].characters.length,
        itemBuilder: (context, characterIndex) {
          return CombatCharacterCard(
            indexCampaing: widget.index,
            indexCharacter: characterIndex,
          );
        },
      );
    });
  }
}

class CombatCharacterCard extends StatefulWidget {
  final int indexCampaing;
  final int indexCharacter;
  const CombatCharacterCard({
    super.key,
    required this.indexCampaing,
    required this.indexCharacter,
  });

  @override
  State<CombatCharacterCard> createState() => _CombatCharacterCardState();
}

class _CombatCharacterCardState extends State<CombatCharacterCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        campaigns[widget.indexCampaing].characters[widget.indexCharacter].participate = !campaigns[widget.indexCampaing].characters[widget.indexCharacter].participate;
        Provider.of<Updater>(context, listen: false).refresh();                        
      },
      child: SizedBox(
        height: 160,
        child: Opacity(
          opacity: campaigns[widget.indexCampaing]
                  .characters[widget.indexCharacter]
                  .participate
              ? 1.0
              : 0.4,
          child: Card(
          color: const Color.fromARGB(255, 55, 55, 55),
          margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: AppProperties.heroPurple,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 22, 10, 0),
                      child: Icon(
                        FontAwesomeIcons.shieldHalved,
                        color: AppProperties.herpPurpleDark,
                        size: 25,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,0,0,10),
                      child: RotatedBox(
                        quarterTurns: 135,
                        child: Text(
                          "hero",
                          style: TextStyle(
                              fontSize: 18,
                              color: AppProperties.herpPurpleDark,
                              fontWeight: FontWeight.w600,
                            ),
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
                      padding: const EdgeInsets.fromLTRB(15.0, 17.5, 15.0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 4,
                            child: Text(
                              campaigns[widget.indexCampaing]
                                  .characters[widget.indexCharacter]
                                  .name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                                ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                                child: Icon(
                                  campaigns[widget.indexCampaing]
                                  .characters[widget.indexCharacter].participate ? Icons.add : Icons.remove,
                                  size: 30,
                                  color: Colors.white,
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
                          Row(
                            children: [
                              FittedBox(
                              child: Text(
                                campaigns[widget.indexCampaing]
                                  .characters[widget.indexCharacter]
                                  .race,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                campaigns[widget.indexCampaing]
                                  .characters[widget.indexCharacter]
                                  .characterclass,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            ],
                          ),
                          Row(
                            children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0,0,10,0),
                              child: Text(
                                "10",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.shield,
                                  size: 30,
                                  color: AppProperties.heroPurple,
                                ),
                                Text(
                                    campaigns[widget.indexCampaing]
                                  .characters[widget.indexCharacter]
                                  .armorClass
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: AppProperties.cardColor,
                                    ))
                              ],
                            ),
                            ],
                          )
      
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
      ),
    );
  }
}
