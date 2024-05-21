import 'package:flutter/material.dart';
import 'package:dmhelper/models/campaign.dart';
import 'package:dmhelper/models/mockup.dart';

void main() {
  runApp(const CampaignStart());
}

class CampaignStart extends StatelessWidget {
  const CampaignStart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CharactercreatorPage(),
    );
  }
}

class CharactercreatorPage extends StatelessWidget {
  const CharactercreatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            color: Colors.amber,
            height: 100,
            child: const Center(
              child: Text(
                "Character Creation!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Expanded(child: CharacterCreator())
        ],
      ),
    );
  }
}

class CharacterCreator extends StatefulWidget {
  const CharacterCreator({super.key});

  @override
  State<CharacterCreator> createState() => _CharacterCreatorState();
}

class _CharacterCreatorState extends State<CharacterCreator> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _raceController = TextEditingController();
  final TextEditingController _characterClassController = TextEditingController();
  final TextEditingController _initModifierController = TextEditingController();
  final TextEditingController _armorClassController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();
  final TextEditingController _strController = TextEditingController();
  final TextEditingController _dexController = TextEditingController();
  final TextEditingController _conController = TextEditingController();
  final TextEditingController _intController = TextEditingController();
  final TextEditingController _wisController = TextEditingController();
  final TextEditingController _chaController = TextEditingController();

  void _submitCharacter() {
    setState(() {
      final newCharacter = Character(
        name: _nameController.text,
        level: int.tryParse(_levelController.text) ?? 1,
        race: _raceController.text,
        characterclass: _characterClassController.text,
        initModifier: int.tryParse(_initModifierController.text) ?? 0,
        armorClass: int.tryParse(_armorClassController.text) ?? 0,
        hp: Hp(
          currentHp: int.tryParse(_hpController.text) ?? 0,
          maxHp: int.tryParse(_hpController.text) ?? 0,
          tempHp: 0,
        ),
        stats: Stats(
          str: int.tryParse(_strController.text) ?? 0,
          strProfieciency: false,
          dex: int.tryParse(_dexController.text) ?? 0,
          dexProfieciency: false,
          con: int.tryParse(_conController.text) ?? 0,
          conProfieciency: false,
          inte: int.tryParse(_intController.text) ?? 0,
          intProfieciency: false,
          wis: int.tryParse(_wisController.text) ?? 0,
          wisProfieciency: false,
          cha: int.tryParse(_chaController.text) ?? 0,
          chaProfieciency: false,
        ),
      );
      chars.add(newCharacter);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final controllers = [
      _nameController,
      _levelController,
      _raceController,
      _characterClassController,
      _initModifierController,
      _armorClassController,
      _hpController,
      _strController,
      _dexController,
      _conController,
      _intController,
      _wisController,
      _chaController,
    ];

    final descriptions = [
      "Name",
      "Level",
      "Race",
      "Class",
      "Initiative Modifier",
      "Armor Class",
      "Hit Points",
      "Strength",
      "Dexterity",
      "Constitution",
      "Intelligence",
      "Wisdom",
      "Charisma",
    ];

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: controllers.length,
            itemBuilder: (context, index) {
              return InputCard(
                desc: descriptions[index],
                controller: controllers[index],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: _submitCharacter,
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }
}

class InputCard extends StatelessWidget {
  final String desc;
  final TextEditingController controller;

  const InputCard({super.key, required this.desc, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Container(
        height: 100,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text(desc)),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}