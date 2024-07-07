import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/pallete.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:dmhelper/pages/comabtprepteam.dart';
import 'package:flutter/material.dart';
import 'package:dmhelper/pages/charactercreator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CampaignViewPage extends StatelessWidget {
  final int index;

  const CampaignViewPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CampaignView(
        index: index,
      ),
    );
  }
}

class CampaignView extends StatefulWidget {
  final int index;

  const CampaignView({super.key, required this.index});

  @override
  State<CampaignView> createState() => _CampaignViewState();
}

class _CampaignViewState extends State<CampaignView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CampaingTopBar(
              index: widget.index,
            ),
            CampaingAddHero(
              campaignIndex: widget.index,
            ),
            Expanded(
                child: HeroesList(
              campaignIndex: widget.index,
            ))
          ],
        ),
        Positioned(
          bottom: 30,
          right: 20,
          child: GestureDetector(
            onTap: () {
              combat.heroes.clear();
              combat.opponentes.clear();
              combat.partake.clear();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CombatPrepTeam(
                    indexCampaign: widget.index,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppProperties.herpPurpleDark,
                  borderRadius: BorderRadius.circular(AppProperties.bRadius)),
              height: 50,
              width: 50,
              child: const FittedBox(child: Icon(Icons.keyboard_double_arrow_right)),
            ),
          ),
        ),
      ],
    );
  }
}

class CampaingTopBar extends StatefulWidget {
  final int index;

  const CampaingTopBar({super.key, required this.index});

  @override
  State<CampaingTopBar> createState() => _CampaingTopBar();
}

class _CampaingTopBar extends State<CampaingTopBar> {
  void exit() {
    Navigator.pop(context);
  }

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
                  exit();
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                  child: Icon(Icons.arrow_back, color: Colors.white, size: 40),
                ),
              ),
              const Text(
                "My Campaigns",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Text(
            campaigns[widget.index].name,
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }
}

class CampaingAddHero extends StatefulWidget {
  final int campaignIndex;

  const CampaingAddHero({
    super.key,
    required this.campaignIndex,
  });

  @override
  State<CampaingAddHero> createState() => _CampaingAddHeroState();
}

class _CampaingAddHeroState extends State<CampaingAddHero> {
  void gotToHeroCreation() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Charactercreator(
                good: true,
                charIndex: 0,
                campaignIndex: widget.campaignIndex,
                newChar: true)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          alignment: Alignment.centerLeft,
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppProperties.bRadius),
            color: Colors.white,
          ),
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              "Add a Hero",
              style: TextStyle(color: AppProperties.cardColor2, fontSize: 25),
            ),
          ),
        ),
        onTap: () {
          gotToHeroCreation();
        });
  }
}

class HeroesList extends StatefulWidget {
  final int campaignIndex;

  const HeroesList({super.key, required this.campaignIndex});

  @override
  State<HeroesList> createState() => _HeroesListState();
}

class _HeroesListState extends State<HeroesList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Updater>(builder: (context, value, child) {
      return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: campaigns[widget.campaignIndex].characters.length,
        itemBuilder: (context, characterIndex) {
          return HeroCard(
            campaignIndex: widget.campaignIndex,
            characterIndex: characterIndex,
          );
        },
      );
    });
  }
}

class HeroCard extends StatelessWidget {
  final int campaignIndex;
  final int characterIndex;

  const HeroCard({
    super.key,
    required this.campaignIndex,
    required this.characterIndex,
  });

  @override
  Widget build(BuildContext context) {
    void goToHeroCreation() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Charactercreator(
                    good: true,
                    charIndex: characterIndex,
                    campaignIndex: campaignIndex,
                    newChar: false,
                  )));
    }

    return SizedBox(
      height: AppProperties.screenHeight(context) * 0.5,
      child: Card(
        color: const Color.fromARGB(255, 55, 55, 55),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                      "Hero",
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
                            campaigns[campaignIndex]
                                .characters[characterIndex]
                                .name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                              child: const Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.white,
                              ),
                              onTap: () {
                                goToHeroCreation();
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
                          child: FittedBox(
                            child: Text(
                              campaigns[campaignIndex]
                                  .characters[characterIndex]
                                  .race,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            campaigns[campaignIndex]
                                .characters[characterIndex]
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
                                  campaigns[campaignIndex]
                                      .characters[characterIndex]
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
    );
  }
}
