import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/pallete.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:dmhelper/pages/comabtprepteam.dart';
import 'package:flutter/material.dart';
import 'package:dmhelper/pages/charactercreator.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                  color: AppProperties.enemyRed,
                  borderRadius: BorderRadius.circular(AppProperties.bRadius*3)),
              height: 60,
              width: 60,
              child: 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'lib/assets/combatIcon.svg',
                  color: Colors.white,
                ),
              )
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
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 40, 15, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  exit();
                },
                child: const SizedBox(
                  width: 50,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                    child: Icon(Icons.arrow_back, color: AppProperties.cardColor3, size: 30),
                  ),
                ),
              ),
              const Text(
                "MY CAMPAIGNS",
                style: TextStyle(
                  fontSize: 18,
                  color: AppProperties.cardColor3,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 0, 20),
            alignment: Alignment.centerLeft,
            child: Text(
              campaigns[widget.index].name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ],
      ),
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
                newChar: true
              )));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            alignment: Alignment.centerLeft,
            height: 50,
            width: AppProperties.screenWidth(context) > 450 ? 400 : double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppProperties.cardRadius-5),
              color: Colors.white,
            ),
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "Add a Hero",
                style: TextStyle(color: AppProperties.cardColor, 
                fontSize: 20,
                fontWeight: FontWeight.w600
                ),
              ),
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
                    existingChar: campaigns[campaignIndex].characters[characterIndex],
                    newChar: false,
                  )));
    }

    return SizedBox(
      height: 160,
      child: Card(
        color: const Color.fromARGB(255, 55, 55, 55),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: AppProperties.heroPurple,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 22, 10, 0),
                    child: SvgPicture.asset(
                      'lib/assets/heroIcon.svg',
                      color: AppProperties.herpPurpleDark,
                    )
                  ),
                 const Padding(
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
                            campaigns[campaignIndex]
                                .characters[characterIndex]
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
                          child: GestureDetector(
                              child: const Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.white,
                              ),
                              onTap: () {
                                goToHeroCreation();
                                Provider.of<Updater>(context, listen: false).refresh();
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
                        Row(
                          children: [
                            FittedBox(
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                                  campaigns[campaignIndex]
                                      .characters[characterIndex]
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
    );
  }
}
