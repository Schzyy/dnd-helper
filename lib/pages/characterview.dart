import 'package:flutter/material.dart';
import 'package:dmhelper/models/campaign.dart';

class CharacterPage extends StatelessWidget {
  final Character char;
  const CharacterPage({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(char.name),
        backgroundColor: Colors.blueAccent,
      ),
      body: CharacterViewPage(viewChar: char),
    );
  }
}

class CharacterViewPage extends StatefulWidget {
  final Character viewChar;
  const CharacterViewPage({super.key, required this.viewChar});

  @override
  State<CharacterViewPage> createState() => _CharacterViewPageState();
}

class _CharacterViewPageState extends State<CharacterViewPage> {
  
  late final List<dynamic> characterAttributes = [
    widget.viewChar.name,
    widget.viewChar.level,
    widget.viewChar.race,
    widget.viewChar.characterclass,
    widget.viewChar.armorClass,
    widget.viewChar.hp.maxHp,
    widget.viewChar.stats.str,
    widget.viewChar.stats.dex,
    widget.viewChar.stats.con,
    widget.viewChar.stats.inte,
    widget.viewChar.stats.wis,
    widget.viewChar.stats.cha
  ];

  late final List<String> attributeNames = [
    'Name',
    'Level',
    'Race',
    'Class',
    'Initiative Modifier',
    'Armor Class',
    'Max HP',
    'Strength',
    'Dexterity',
    'Constitution',
    'Intelligence',
    'Wisdom',
    'Charisma'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: characterAttributes.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(attributeNames[index][0]),
              backgroundColor: Colors.blueAccent,
            ),
            title: Text(
              attributeNames[index],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(characterAttributes[index].toString()),
          ),
        );
      },
    );
  }
}