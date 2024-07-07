import 'package:dmhelper/models/pallete.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:dmhelper/pages/combatprepenemies.dart';
import 'package:flutter/material.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/pages/charactercreator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CombatPrepTeam extends StatelessWidget {
  final int indexCampaign;

  const CombatPrepTeam({super.key, required this.indexCampaign});
  void addHeroesToPartake() {
    for (int i = 0; i < campaigns[indexCampaign].characters.length; i++) {
      if (campaigns[indexCampaign].characters[i].participate == true) {
        combat.heroes.add(campaigns[indexCampaign].characters[i]);
      }
    }
  }
  void addHeroesToCombat() {
    for(int i = 0; i < combat.heroes.length; i++) {
      combat.partake.add(combat.heroes[i]);
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
                addHeroesToCombat();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const CombatPrepEnemies(indexCampaign: 0),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppProperties.herpPurpleDark,
                    borderRadius: BorderRadius.circular(AppProperties.bRadius)),
                height: 50,
                width: 50,
                child: const FittedBox(
                    child: Icon(Icons.keyboard_double_arrow_right)),
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
          margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  combat.heroes.clear();
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                  child: Icon(Icons.arrow_back,
                      color: AppProperties.heroPurple, size: 40),
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
            "Add Enemies",
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
                  campaigns[widget.campaingIndex].characters.length < 2
                      ? '${getAllParticipatingTeam()} Participant'
                      : '${getAllParticipatingTeam()} Participants',
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
                  borderRadius: BorderRadius.circular(AppProperties.bRadius)),
              child: const Icon(
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
                          newChar: true)));
            },
          )
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
    return SizedBox(
      height: AppProperties.screenHeight(context) * 0.5,
      child: Opacity(
        opacity: campaigns[widget.indexCampaing]
                .characters[widget.indexCharacter]
                .participate
            ? 1.0
            : 0.4,
        child: Card(
          color: const Color.fromARGB(255, 55, 55, 55),
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: AppProperties.heroPurple,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                            color: AppProperties.herpPurpleDark,
                            fontWeight: FontWeight.bold),
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
                              campaigns[widget.indexCampaing]
                                  .characters[widget.indexCharacter]
                                  .name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 30),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                                child: Icon(
                                  campaigns[widget.indexCampaing]
                                          .characters[widget.indexCharacter]
                                          .participate
                                      ? Icons.remove
                                      : Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  campaigns[widget.indexCampaing]
                                          .characters[widget.indexCharacter]
                                          .participate =
                                      !campaigns[widget.indexCampaing]
                                          .characters[widget.indexCharacter]
                                          .participate;
                                  Provider.of<Updater>(context, listen: false)
                                      .refresh();
                                }),
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
                              campaigns[widget.indexCampaing]
                                  .characters[widget.indexCharacter]
                                  .race,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
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
                          const Flexible(
                            flex: 1,
                            child: Text(
                              "10",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
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
                                  color: AppProperties.heroPurple,
                                ),
                                Text(
                                    campaigns[widget.indexCampaing]
                                        .characters[widget.indexCharacter]
                                        .armorClass
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ))
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
      ),
    );
  }
}
