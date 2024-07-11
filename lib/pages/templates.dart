import 'package:dmhelper/models/pallete.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:dmhelper/pages/charactercreator.dart';
import 'package:flutter/material.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TemplatePage extends StatelessWidget {
  const TemplatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
          children: [
            TopbarTemplates(),
            Expanded(
              child: TemplatesDisplay(),
            ),
          ],
      ),
    );
  }
}

class TopbarTemplates extends StatefulWidget {
  const TopbarTemplates({super.key});

  @override
  State<TopbarTemplates> createState() => _TopbarTemplatesState();
}

class _TopbarTemplatesState extends State<TopbarTemplates> {
  void _navigateAndRefresh(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Charactercreator(
        campaignIndex: 0,
        charIndex: 0,
        existingChar: null,
        good: false,
        newChar: true,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
              "MY CHARACTERS",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          GestureDetector(
            onTap: () {
              _navigateAndRefresh(
                context,
              );
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppProperties.bRadius),
                color: Colors.white,
              ),
                child: const Icon(
                  Icons.add,
                  weight: 10,
                  size: 60,
                  color: AppProperties.screenColor,
                  ),
            ),
          )
        ],
      ),
    );
  }
}

class TemplateCard extends StatelessWidget {
  final String name;
  final String rasse;
  final String characterclass;
  final int armorclass;
  final int init;
  final int index;
  
  const TemplateCard({
    super.key,
    required this.name,
    required this.rasse,
    required this.characterclass, 
    required this.armorclass, 
    required this.init, 
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
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
                  color: AppProperties.enemyRed,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 22, 10, 0),
                    child: SvgPicture.asset(
                      'lib/assets/npcIcon.svg',
                      color: AppProperties.enemyRedDark,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0,0,0,10),
                    child: RotatedBox(
                      quarterTurns: 135,
                      child: Text(
                        "enemy",
                        style: TextStyle(
                            fontSize: 18,
                            color: AppProperties.enemyRedDark,
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
                            chars[index].name,
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
                                Icons.remove,
                                size: 30,
                                color: Colors.white,
                              ),
                              onTap: () {
                                chars.removeAt(index);
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
                              chars[index]
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
                              chars[index].characterclass,
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,10,0),
                            child: Text(
                              "+${chars[index].initModifier}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
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
                                color: AppProperties.enemyRed,
                              ),
                              Text(
                                  chars[index].armorClass.toString(),
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

class TemplatesDisplay extends StatefulWidget {
  const TemplatesDisplay({super.key});

  @override
  State<TemplatesDisplay> createState() => _TemplatesDisplayState();
}

class _TemplatesDisplayState extends State<TemplatesDisplay> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Updater>(builder: (context, value, child) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        primary: false,
        itemCount: chars.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Charactercreator(
                      campaignIndex: 0,
                      charIndex: index,
                      good: false,
                      newChar: false,
                      existingChar: chars[index],
                    ))),
            child: TemplateCard(
              name: chars[index].name,
              rasse: chars[index].race,
              characterclass: chars[index].characterclass,
              armorclass: chars[index].armorClass,
              init: chars[index].stats.dex,
              index: index,
            ),
          );
        },
      );
    });
  }
}