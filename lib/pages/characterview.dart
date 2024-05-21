import 'package:flutter/material.dart';
import 'package:dmhelper/models/campaign.dart';

class CharacterPage extends StatelessWidget {
  final Character char;
  const CharacterPage({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return CharacterViewPage(viewChar: char);
  }
}

class CharacterViewPage extends StatefulWidget {
  final Character viewChar;
  const CharacterViewPage({super.key, required this.viewChar});

  @override
  State<CharacterViewPage> createState() => _CharacterViewPageState();
}

class _CharacterViewPageState extends State<CharacterViewPage> {
  final List<String> desc = [
    'Name',
    'Level',
    'Race',
    'Class',
    'Initiative',
    'Armorclass',
    'HP',
    'Strength',
    'Dexterity',
    'Consitution',
    'Inteligence',
    'Wisdom',
    'Charisma'
    ];
  late final List<dynamic> characterAttributes = [
    widget.viewChar.name,
    widget.viewChar.level,
    widget.viewChar.race,
    widget.viewChar.characterclass,
    widget.viewChar.initModifier,
    widget.viewChar.armorClass,
    widget.viewChar.hp.maxHp,
    widget.viewChar.stats.str,
    widget.viewChar.stats.dex,
    widget.viewChar.stats.con,
    widget.viewChar.stats.inte,
    widget.viewChar.stats.wis,
    widget.viewChar.stats.cha

  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 13,
      itemBuilder: (context, index) {
        return Text('${desc[index]}: ${characterAttributes[index]}');
      },
    );
  }
}

