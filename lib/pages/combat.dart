import 'dart:math';

import 'package:dmhelper/models/campaign.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/pallete.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  @override
  void initState() {
    super.initState();
    sortByInit();
    dialogChars.add(combat.partake[0]);
  }
  ScrollController scrollController = ScrollController();
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
  void sortByInit() {
    Random random = Random();
    setState(() {
      combat.partake.sort((a,b) {
      int initiativeComparison= b.currentInit.compareTo(a.currentInit);
      if(initiativeComparison != 0) return initiativeComparison;

      int initModifierComparision = b.initModifier.compareTo(a.initModifier);
      if(initModifierComparision != 0) return initModifierComparision;

      return random.nextInt(2) - 1;
    });
    });
  }
  void goNext() {
    setState(() {
      
      if (combat.partake[count % combat.partake.length].dead == false) {
        dialogChars.add(combat.partake[count % combat.partake.length]);
      }
      count++;
    });
    Provider.of<Updater>(context, listen: false).refresh();
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
              scrollController: scrollController,
            ),
          ),
          CombatAdvance(
            goNext: goNext,
            scrollToEnd: scrollToBottom,
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
                    "COMBAT",
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
                      HelperFunctions.cancelCombat(context, 4);
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
              ),])
    );
  }
}

class CombatDialog extends StatefulWidget {
  const CombatDialog({
    super.key,
    required this.dialogChars,
    required this.scrollController
  });
  final ScrollController scrollController;
  final List<Character> dialogChars;

  @override
  State<CombatDialog> createState() => _CombatDialogState();
}

class _CombatDialogState extends State<CombatDialog> {
  late ScrollController scrollController;
  
  @override
  initState() {
    super.initState();
  }
  
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
    return GestureDetector(
      onTap: () {
        widget.displayChar.dead = !widget.displayChar.dead;
        Provider.of<Updater>(context, listen: false).refresh();
      },
      child: Container(
        margin: widget.displayChar.good ? const EdgeInsets.fromLTRB(30, 10, 10, 0) : const EdgeInsets.fromLTRB(10, 10, 30, 0),
        width: double.infinity,
        height: AppProperties.screenHeight(context) * 0.35,
        decoration: BoxDecoration(
          color: AppProperties.cardColor2,
          borderRadius: widget.displayChar.good ?
          BorderRadius.only(
            bottomLeft: Radius.circular(AppProperties.bRadius),
            topLeft: Radius.circular(AppProperties.bRadius),
            topRight: const Radius.circular(0),
            bottomRight: const Radius.circular(0),
          ) :
          BorderRadius.only(
            bottomLeft: const Radius.circular(0),
            topLeft: const Radius.circular(0),
            topRight: Radius.circular(AppProperties.bRadius),
            bottomRight: Radius.circular(AppProperties.bRadius),
          )
        ),
        child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.displayChar.good
                      ? AppProperties.heroPurple
                      : AppProperties.enemyRed,
                  borderRadius: widget.displayChar.good ?
          BorderRadius.only(
            bottomLeft: Radius.circular(AppProperties.bRadius),
            topLeft: Radius.circular(AppProperties.bRadius),
            topRight: const Radius.circular(0),
            bottomRight: const Radius.circular(0),
          ) :
          const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: widget.displayChar.good ? SvgPicture.asset(
                        'lib/assets/heroIcon.svg',
                        color: AppProperties.herpPurpleDark,
                      )  : SvgPicture.asset(
                        'lib/assets/enemyIcon.svg',
                        color: AppProperties.enemyRedDark,
                      )
                    ),
                    RotatedBox(
                      quarterTurns: 135,
                      child: Text(
                        widget.displayChar.good ? "hero" : "enemy",
                        style: TextStyle(
                          fontSize: 20,
                          color: widget.displayChar.good ? AppProperties.herpPurpleDark : AppProperties.enemyRedDark,
                          fontWeight: FontWeight.w600,
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
                              child: Icon(
                                  FontAwesomeIcons.skull,
                                  size: 30,
                                  color: widget.displayChar.dead ? AppProperties.screenColor : Colors.white,
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
                                Icon(
                                  FontAwesomeIcons.shield,
                                  size: 35,
                                  color: widget.displayChar.good ? AppProperties.heroPurple : AppProperties.enemyRed,
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
    return Opacity(
      opacity: widget.displayChar.dead ? 0.4 : 1.0,
      child: Container(
        margin: widget.displayChar.good ? const EdgeInsets.fromLTRB(80, 10, 10, 10) : const EdgeInsets.fromLTRB(10, 10, 80, 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppProperties.cardColor2,
          borderRadius: widget.displayChar.good ?
          BorderRadius.only(
            bottomLeft: Radius.circular(AppProperties.bRadius),
            topLeft: Radius.circular(AppProperties.bRadius),
            topRight: const Radius.circular(0),
            bottomRight: const Radius.circular(0),
          ) :
          BorderRadius.only(
            bottomLeft: const Radius.circular(0),
            topLeft: const Radius.circular(0),
            topRight: Radius.circular(AppProperties.bRadius),
            bottomRight: Radius.circular(AppProperties.bRadius),
          )
        ),
        height: 90,
        child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.displayChar.good
                      ? AppProperties.heroPurple
                      : AppProperties.enemyRed,
                borderRadius: widget.displayChar.good ?
          BorderRadius.only(
            bottomLeft: Radius.circular(AppProperties.bRadius),
            topLeft: Radius.circular(AppProperties.bRadius),
            topRight: const Radius.circular(0),
            bottomRight: const Radius.circular(0),
          ) :
          const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ) 
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: widget.displayChar.good ? SvgPicture.asset(
                        'lib/assets/heroIcon.svg',
                        color: AppProperties.herpPurpleDark,
                      ) : SvgPicture.asset(
                        'lib/assets/enemyIcon.svg',
                        color: AppProperties.enemyRedDark,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 4,
                              child: Text(
                                widget.displayChar.name,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                widget.displayChar.race,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                widget.displayChar.characterclass,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                widget.displayChar.currentInit.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.shield,
                                    size: 20,
                                    color: widget.displayChar.good ?AppProperties.heroPurple : AppProperties.enemyRed,
                                  ),
                                  Text(
                                    widget.displayChar.armorClass.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                    ),
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
    required this.scrollToEnd,
  });
  final Function scrollToEnd;
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
                widget.scrollToEnd();
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
              onTap: () {
                HelperFunctions.showParticipants(context);
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppProperties.bRadius),
                  color: AppProperties.cardColor2,
                ),
                child: const Icon(
                  Icons.person,
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
