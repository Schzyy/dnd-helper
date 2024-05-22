import 'package:flutter/material.dart';
import 'package:dmhelper/models/campaign.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/pages/charactercreator.dart';

class CombatPrepTeam extends StatelessWidget {
  final int indexCampaign;

  const CombatPrepTeam({super.key, required this.indexCampaign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Combat Preparations Team"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CharactercreatorPage(
                        template: false,
                        index: indexCampaign,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Add a Hero",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Expanded(
                child: CombatPrepTeamList(indexCampaign: indexCampaign),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                
              },
              child: const Text("Enemies"),
            ),
          ),
        ],
      ),
    );
  }
}

class CombatPrepTeamList extends StatefulWidget {
  final int indexCampaign;

  const CombatPrepTeamList({
    super.key,
    required this.indexCampaign,
  });

  @override
  State<CombatPrepTeamList> createState() => _CombatPrepTeamListState();
}

class _CombatPrepTeamListState extends State<CombatPrepTeamList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: campaigns[widget.indexCampaign].characters.length,
      itemBuilder: (context, index) {
        return CombatPrepTeamCard(
          campaignIndex: widget.indexCampaign,
          index: index,
        );
      },
    );
  }
}

class CombatPrepTeamCard extends StatefulWidget {
  final int index;
  final int campaignIndex;

  const CombatPrepTeamCard({
    super.key,
    required this.campaignIndex,
    required this.index,
  });

  @override
  State<CombatPrepTeamCard> createState() => _CombatPrepTeamCardState();
}

class _CombatPrepTeamCardState extends State<CombatPrepTeamCard> {
  bool add = true;

  void toggleIcon(int indexCampaign, int indexCharacter) {
    setState(() {
      add = !add;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: add ? Colors.grey[200] : Colors.black54,
        title: Text(
          campaigns[widget.campaignIndex].characters[widget.index].name,
        ),
        trailing: IconButton(
          icon: Icon(add ? Icons.remove : Icons.add),
          onPressed: () {
            toggleIcon(widget.campaignIndex, widget.index);
          },
        ),
      ),
    );
  }
}
