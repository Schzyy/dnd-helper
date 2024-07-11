import 'dart:math';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/pallete.dart';
import 'package:dmhelper/pages/combat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    void removeEnemies() {
      combat.partake.clear();
      combat.opponentes.clear();
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
            child: GestureDetector(
              onTap: () {
                rollCharacters();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const CombatPage(),
                  ),
                );
              },
              child: Container(
              decoration: BoxDecoration(
                  color: AppProperties.enemyRed,
                  borderRadius: BorderRadius.circular(AppProperties.bRadius*3)),
              height: 60,
              width: 60,
              child: const Icon(
                FontAwesomeIcons.fire,
                color: Colors.white,
                size: 40,
              ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: GestureDetector(
              onTap: () {
                removeEnemies();
                Navigator.pop(context);
              },
              child: Container(
              decoration: BoxDecoration(
                  color: AppProperties.enemyRed,
                  borderRadius: BorderRadius.circular(AppProperties.bRadius*3)),
              height: 60,
              width: 60,
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 40,
              ),
              ),
            ),
          ),
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
                      HelperFunctions.cancelCombat(context, 3);
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
          padding: const EdgeInsets.fromLTRB(17.5, 0, 0, 10),
          alignment: Alignment.centerLeft,
          child: const Text(
            "SELECT INITIATIVE",
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
  
  bool inUse = false;
  FocusNode node = FocusNode();
  late Color outColor;
  late Color inColor;
  bool isNotNumeric(String value) {
    return double.tryParse(value) == null;
  }
  void handleFocus() {
    setState(() {
      inUse = node.hasFocus;
    });
    if(!node.hasFocus) {
      setState(() {
        inUse = false;
      });
    }
  }
  void showSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text("Invalid Input! Try any postive number"),
      duration: Duration(
        seconds: 3
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  void initState() {
    super.initState();
    controller.text = '0';
    outColor = combat.partake[widget.index].good ? AppProperties.heroPurple : AppProperties.enemyRed ;
    inColor = combat.partake[widget.index].good ? AppProperties.herpPurpleDark : AppProperties.enemyRedDark;
    node.addListener(handleFocus);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          inUse = true;
          node.requestFocus();
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: inUse ? Colors.white : AppProperties.screenColor,
          ),
          color: AppProperties.cardColor2,
          borderRadius: BorderRadius.circular(AppProperties.bRadius)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 50,
                    decoration: BoxDecoration(
                      color: 
                      inUse ? inColor : outColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppProperties.bRadius),
                        bottomLeft: Radius.circular(AppProperties.bRadius),
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        combat.partake[widget.index].good ? 'lib/assets/combatIcon.svg' : 'lib/assets/npcIcon.svg',
                        color: inUse ? outColor : inColor, 
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text(
                        combat.partake[widget.index].name
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(AppProperties.bRadius),
                        bottomRight: Radius.circular(AppProperties.bRadius)
                      )
                    ),
                      height: 80,
                      width: 40,
                      child: TextField(
                        controller: controller,
                        focusNode: node,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onSubmitted: (value) {
                          setState(() {
                          if(isNotNumeric(value)) {
                            inUse = false;
                            controller.text = '0';
                            showSnackbar(context);
                            return;
                          } 
                          if(int.parse(value) <= 0) {
                            inUse = false;
                            controller.text = '0';
                            showSnackbar(context);
                            return;
                          }
                          inUse = false;
                          combat.partake[widget.index].currentInit = int.parse(value);
                          
                          });
                          },
                      ),
              
              )],
              ),
          ],
        ),
      ),
    );
  }
}
