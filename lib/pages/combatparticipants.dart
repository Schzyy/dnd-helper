import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/pallete.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Participant extends StatefulWidget {
  const Participant({super.key});

  @override
  State<Participant> createState() => _ParticipantState();
}

class _ParticipantState extends State<Participant> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Updater>(
      builder: (context, value, child) {
    return ListView.builder(
      itemCount: combat.partake.length,
      itemBuilder: (context, index) {
        return ParticipantViewCard(
          index: index
        );
      }
    );
      });
  }
}

class ParticipantViewCard extends StatefulWidget {
  const ParticipantViewCard({
    super.key,
    required this.index
  });
  final int index;

  @override
  State<ParticipantViewCard> createState() => _ParticipantCardState();
}

class _ParticipantCardState extends State<ParticipantViewCard> {
  bool dead = false;
  late Color outColor;
  late Color inColor;

  @override
  void initState() {
    super.initState();
    outColor = combat.partake[widget.index].good ? AppProperties.heroPurple : AppProperties.enemyRed ;
    inColor = combat.partake[widget.index].good ? AppProperties.herpPurpleDark : AppProperties.enemyRedDark;
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          combat.partake[widget.index].dead = !combat.partake[widget.index].dead;
          Provider.of<Updater>(context, listen: false).refresh();
           
        });
      },
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          height: 80,
          decoration: BoxDecoration(
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
                        combat.partake[widget.index].dead ? inColor : outColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppProperties.bRadius),
                          bottomLeft: Radius.circular(AppProperties.bRadius),
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          combat.partake[widget.index].good ? 'lib/assets/combatIcon.svg' : 'lib/assets/npcIcon.svg',
                          color: combat.partake[widget.index].dead ? outColor : inColor, 
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
                SizedBox(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,20,0),
                        child: Text(
                          '+ ${combat.partake[widget.index].currentInit}',
                        ),
                      ),
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
                          child: Icon(
                            FontAwesomeIcons.skull,
                            color: combat.partake[widget.index].dead ? AppProperties.screenColor : Colors.white,
                          )
      
                  )],
                  ),
                ),
            ],
          ),
        ),
    );
  }
}