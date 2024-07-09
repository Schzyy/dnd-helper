import 'dart:math';

import 'package:dmhelper/models/campaign.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/pallete.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CombatPage extends StatefulWidget {
  const CombatPage({super.key});

  @override
  State<CombatPage> createState() => _CombatPageState();
}

class _CombatPageState extends State<CombatPage> {
  @override
  Widget build(BuildContext context) {
    return const Combat();
  }
}

class Combat extends StatefulWidget {
  const Combat({super.key});

  @override
  State<Combat> createState() => _CombatState();
}

class _CombatState extends State<Combat> {
  List<Character> dialogChars = [];
  int count = 1;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    sortByInit();
    dialogChars.add(combat.partake[0]);
    scrollController = ScrollController();

  }
void sortByInit() {
  int n = combat.partake.length;
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (combat.partake[j].currentInit < combat.partake[j + 1].currentInit ||
          (combat.partake[j].currentInit == combat.partake[j + 1].currentInit &&
              combat.partake[j].initModifier < combat.partake[j + 1].initModifier)) {
        Character temp = combat.partake[j];
        combat.partake[j] = combat.partake[j + 1];
        combat.partake[j + 1] = temp;
      }
    }
  }
}
  void goNext() {
    setState(() {
      if (combat.partake[count % combat.partake.length].dead == false) {
        dialogChars.add(combat.partake[count % combat.partake.length]);
      }
      count++;
      scrollToBottom();
    });
    Provider.of<Updater>(context, listen: false).refresh();
  }
  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
          scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CombatTopBar(),
          Expanded(
            child: CombatDialog(
              dialogChars: dialogChars,
              goNext: scrollToBottom,
              scrollController: scrollController
            ),
          ),
          CombatAdvance(
            goNext: goNext,
          ),
        ],
      ),
    );
  }
}

class CombatTopBar extends StatefulWidget {
  const CombatTopBar({super.key});

  @override
  State<CombatTopBar> createState() => _CombatTopBarState();
}

class _CombatTopBarState extends State<CombatTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  color: AppProperties.enemyRed, size: 40),
            ),
          ),
          const Text(
            "Combat",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class CombatDialog extends StatefulWidget {
  final Function goNext;
  final ScrollController scrollController;

  const CombatDialog({
    super.key,
    required this.dialogChars, 
    required this.goNext,
    required this.scrollController
  });
  final List<Character> dialogChars;

  @override
  State<CombatDialog> createState() => _CombatDialogState();
}

class _CombatDialogState extends State<CombatDialog> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<Updater>(
      builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.dialogChars.length - 1,
                  controller: widget.scrollController,
                  itemBuilder: (context, index) {
                    return ParticipantCard(
                      displayChar: widget.dialogChars[index],
                    );
                  },
                ),
              ),
            ),
            if (widget.dialogChars.isNotEmpty)
              CurrentParticipantCard(
                displayChar:
                    widget.dialogChars[widget.dialogChars.length - 1],
              ),
          ],
        );
      },
    );
  }
}

class CurrentParticipantCard extends StatefulWidget {
  const CurrentParticipantCard({
    super.key,
    required this.displayChar,
  });

  final Character displayChar;

  @override
  State<CurrentParticipantCard> createState() =>
      _CurrentParticipantCardState();
}

class _CurrentParticipantCardState extends State<CurrentParticipantCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      width: double.infinity,
      height: AppProperties.screenHeight(context) * 0.35,
      child: Card(
        color: AppProperties.cardColor2,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: widget.displayChar.good
                    ? AppProperties.heroPurple
                    : AppProperties.enemyRed,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Icon(
                      FontAwesomeIcons.shield,
                      size: 30,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 135,
                    child: Text(
                      widget.displayChar.good ? "Hero" : "Enemy",
                      style: const TextStyle(
                        fontSize: 20,
                        color: AppProperties.herpPurpleDark,
                        fontWeight: FontWeight.bold,
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
                          child: FittedBox(
                            child: Text(
                              widget.displayChar.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: GestureDetector(
                              child: const Icon(
                                FontAwesomeIcons.skull,
                                size: 30,
                                color: Colors.white,
                              ),
                              onTap: () {
                                widget.displayChar.dead = true;
                                Provider.of<Updater>(context, listen: false).refresh();
                              },
                            ),
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
                            widget.displayChar.race,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            widget.displayChar.characterclass,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            widget.displayChar.currentInit.toString(),
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
                                color: AppProperties.heroPurple,
                              ),
                              Text(
                                widget.displayChar.armorClass.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
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

class ParticipantCard extends StatefulWidget {
  const ParticipantCard({super.key, required this.displayChar});
  final Character displayChar;
  @override
  State<ParticipantCard> createState() => _ParticipantCardState();
}

class _ParticipantCardState extends State<ParticipantCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.displayChar.good ? EdgeInsets.fromLTRB(70, 0, 10, 0) : EdgeInsets.fromLTRB(10, 0, 70, 0),
      width: double.infinity,
      height: AppProperties.screenHeight(context) * 0.35,
      child: Card(
        color: AppProperties.cardColor2,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: widget.displayChar.good
                    ? AppProperties.heroPurple
                    : AppProperties.enemyRed,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Icon(
                      FontAwesomeIcons.shield,
                      size: 30,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 135,
                    child: Text(
                      widget.displayChar.good ? "Hero" : "Enemy",
                      style: TextStyle(
                        fontSize: 20,
                        color: widget.displayChar.good ? AppProperties.herpPurpleDark : AppProperties.enemyRedDark,
                        fontWeight: FontWeight.bold,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 4,
                          child: Text(
                            widget.displayChar.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
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
                            widget.displayChar.race,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            widget.displayChar.characterclass,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            widget.displayChar.currentInit.toString(),
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
                                color: AppProperties.heroPurple,
                              ),
                              Text(
                                widget.displayChar.armorClass.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
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

class CombatAdvance extends StatefulWidget {
  const CombatAdvance({
    super.key,
    required this.goNext,
  });

  final Function goNext;

  @override
  State<CombatAdvance> createState() => _CombatAdvanceState();
}

class _CombatAdvanceState extends State<CombatAdvance> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      height: 100,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            right: 20,
            child: GestureDetector(
              onTap: () {
                widget.goNext();
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppProperties.bRadius),
                  color: AppProperties.cardColor2,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 50,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppProperties.bRadius),
                  color: AppProperties.cardColor2,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
