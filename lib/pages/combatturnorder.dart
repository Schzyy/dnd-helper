import 'package:dmhelper/models/mockup.dart';
import 'package:flutter/material.dart';

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
  const ParticipantsCard({super.key, required this.index});

  @override
  State<ParticipantsCard> createState() => _ParticipantsCardState();
}

class _ParticipantsCardState extends State<ParticipantsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      child: ListTile(
        tileColor: combat.partake[widget.index].good ? Colors.amber : Colors.green,
        title: Text(
          combat.partake[widget.index].name,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
        trailing: const Text(
          "hello",
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
