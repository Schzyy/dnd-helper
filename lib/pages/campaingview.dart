import 'package:flutter/material.dart';
import 'package:dmhelper/pages/charactercreator.dart';
import 'package:dmhelper/models/campaign.dart';
import 'package:dmhelper/models/mockup.dart';

class CampaingViewPage extends StatelessWidget {
  final int index;
  const CampaingViewPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(campaigns[index].name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CharactercreatorPage(template: false, index: index),
                  ),
                );
              },
              child: const Text(
                "Add a Hero",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: Campaingview(index: index),
          ),
        ],
      ),
    );
  }
}

class Campaingview extends StatefulWidget {
  final int index;
  const Campaingview({super.key, required this.index});

  @override
  State<Campaingview> createState() => _CampaingviewState();
}

class _CampaingviewState extends State<Campaingview> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: campaigns[widget.index].characters.length,
      itemBuilder: (context, characterIndex) {
        return CharacterCard(
          indexCampaing: widget.index,
          indexCharacter: characterIndex,
        );
      },
    );
  }
}

class CharacterCard extends StatelessWidget {
  final int indexCampaing;
  final int indexCharacter;
  const CharacterCard({super.key, required this.indexCampaing, required this.indexCharacter});

  @override
  Widget build(BuildContext context) {
    final character = campaigns[indexCampaing].characters[indexCharacter];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                character.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    character.characterclass,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    character.race,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}