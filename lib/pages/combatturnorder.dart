import 'dart:async';
import 'dart:math';

import 'package:dmhelper/models/campaign.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/pallete.dart';
import 'package:dmhelper/pages/combat.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CombatTurnOrderPage extends StatelessWidget {
  const CombatTurnOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    void rollCharacters() {
      for(int i = 0; i < combat.partake.length; i++) {
        if(combat.partake[i].currentInit == 0) {
          combat.partake[i].currentInit = Random().nextInt(20) + 1 + combat.partake[i].initModifier;
        }
      }
    }
    return Scaffold(
      body: Stack(
        children: [ 
          const Column(
            children: [
              TurnOrderTopBar(),
              Expanded(child: ParticipantsList()),
            ],
          ),
          Positioned(
            bottom: 30,
            right: 20,
              child: ElevatedButton(
                onPressed: () {
                  rollCharacters();
                  Navigator.push(
                    context,
                      MaterialPageRoute(
                        builder: (context) => const CombatPage(
                      )
                    ),
                  );
                }, 
                child: Icon(
                  FontAwesomeIcons.fire,
                  color: AppProperties.enemyRed
                )
              ),
            )
        ] 
      ),
    );
  }
}

class TurnOrderTopBar extends StatefulWidget {
  const TurnOrderTopBar({super.key});

  @override
  State<TurnOrderTopBar> createState() => _TurnOrderTopBarState();
}

class _TurnOrderTopBarState extends State<TurnOrderTopBar> {
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
                "Turn Order",
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
            "Set Initiative",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class ParticipantsList extends StatefulWidget {
  const ParticipantsList({super.key});

  @override
  State<ParticipantsList> createState() => ParticipantsListState();
}

class ParticipantsListState extends State<ParticipantsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: combat.partake.length,
      itemBuilder: (context, index) {
        return ParticipantsCard(index: index);
      },
    );
  }
}

class ParticipantsCard extends StatefulWidget {
  final int index;
  const ParticipantsCard({
    super.key,
    required this.index,
  });

  @override
  State<ParticipantsCard> createState() => _ParticipantsCardState();
}

class _ParticipantsCardState extends State<ParticipantsCard> {
  TextEditingController controller = TextEditingController();
  bool inUse = true;
  bool isNotNumeric(String value) {
    return double.tryParse(value) == null;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        color: AppProperties.cardColor2,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppProperties.bRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 80,
                  width: 60,
                  decoration: BoxDecoration(
                    color: combat.partake[widget.index].good
                        ? AppProperties.heroPurple
                        : AppProperties.enemyRed,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppProperties.bRadius),
                      bottomLeft: Radius.circular(AppProperties.bRadius),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: combat.partake[widget.index].good
                        ? const Icon(
                            FontAwesomeIcons.shield,
                            size: 35,
                          )
                        : const Icon(
                            FontAwesomeIcons.hammer,
                            size: 35,
                          ),
                  ),
                ),
                Container(
                  height: 80,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: FittedBox(
                      child: Text(
                        combat.partake[widget.index].name,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      color: AppProperties.cardColor2,
                      width: 50,
                      height: 80,
                      child: inUse
                          ? FittedBox(
                            child: Text(controller.text.isEmpty ? "init" : controller.text,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                          : TextField(
                              textAlign: TextAlign.end,
                              controller: controller,
                              focusNode: FocusNode(),
                              onSubmitted: (value) {
                                if (isNotNumeric(value)) {
                                  controller.text = "invalid";
                                } else if (int.parse(value) < 0 ||
                                    int.parse(value) > 20) {
                                  controller.text = "0";
                                } else {
                                  combat.partake[widget.index].currentInit =
                                      int.parse(value) +
                                          combat.partake[widget.index]
                                              .initModifier;
                                }
                                setState(() {
                                  inUse = true;
                                });
                              },
                            ),
                    ),
                    onTap: () {
                      setState(() {
                        inUse = false;
                      });
                    },
                  ),
                  Container(
                    color: Colors.blue,
                    alignment: Alignment.center,
                    width: 50,
                    child: Text(
                      '+ ${combat.partake[widget.index].initModifier}',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    color: combat.partake[widget.index].good
                        ? AppProperties.heroPurple
                        : AppProperties.enemyRed,
                    alignment: Alignment.center,
                    width: 50,
                    child: Text(
                        combat.partake[widget.index].currentInit.toString(),
                        style: const TextStyle(
                              fontSize: 20,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
