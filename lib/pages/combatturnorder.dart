import 'dart:async';

import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/pallete.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CombatTurnOrderPage extends StatelessWidget {
  const CombatTurnOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () { 
            combat.opponentes.clear();
            for (int i = combat.partake.length - 1; i >= 0; i--) {
              if (combat.partake[i].good == false) {
                combat.partake.removeAt(i);
              }
            }
            Navigator.pop(context); 
          },
        ),
        title: const Text("Turn Order"),
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment_turned_in_rounded),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle manual button tap
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text("Manual"),
            ),
          ),
          const Expanded(child: ParticipantsList()),
        ],
      ),
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
    required this.index
  });

  @override
  State<ParticipantsCard> createState() => _ParticipantsCardState();
}

class _ParticipantsCardState extends State<ParticipantsCard> {
  @override

  @override
  TextEditingController controller = new TextEditingController();
  FocusNode focusNode = FocusNode();
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        height: 80,
        child: Card(
          color: AppProperties.cardColor2,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppProperties.bRadius)
          ),
          child: Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    width: 60,
                    decoration: BoxDecoration(
                      color: combat.partake[widget.index].good ? AppProperties.heroPurple : AppProperties.enemyRed,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppProperties.bRadius),
                        bottomLeft: Radius.circular(AppProperties.bRadius),
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: combat.partake[widget.index].good ? const Icon(
                        FontAwesomeIcons.shield,
                        size: 35,
                      ) : const Icon(
                        FontAwesomeIcons.hammer,
                        size: 35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      combat.partake[widget.index].name,
                      style: const TextStyle(
                        fontSize: 20,
                      )
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    child: Text("0"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {
        
      }
    );
  }
}
