import 'package:flutter/material.dart';
import 'package:dmhelper/models/campaign.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:provider/provider.dart';

class CharactercreatorPage extends StatelessWidget {
  final bool template;
  final int index;

  const CharactercreatorPage({
    Key? key,
    required this.template,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            color: Colors.amber,
            height: 100,
            child: Center(
              child: Text(
                "Character Creation!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(child: CharacterCreator(template: template, index: index)),
        ],
      ),
    );
  }
}

class CharacterCreator extends StatefulWidget {
  final bool template;
  final int index;

  const CharacterCreator({
    Key? key,
    required this.template,
    required this.index,
  }) : super(key: key);

  @override
  State<CharacterCreator> createState() => _CharacterCreatorState();
}

class _CharacterCreatorState extends State<CharacterCreator> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _raceController = TextEditingController();
  final TextEditingController _characterClassController =
      TextEditingController();
  final TextEditingController _armorClassController =
      TextEditingController();
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
        good: true,
        name: _nameController.text,
        level: int.tryParse(_levelController.text) ?? 1,
        race: _raceController.text,
        characterclass: _characterClassController.text,
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

      if (widget.template) {
        chars.add(newCharacter);
      } else {
        campaigns[widget.index].characters.add(newCharacter);
      }
    });

    Provider.of<Updater>(context, listen: false).refresh();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final controllers = [
      _nameController,
      _levelController,
      _raceController,
      _characterClassController,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 3.0,
                    ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return InputCard(
                        desc: descriptions[index],
                        controller: controllers[index],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: _submitCharacter,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class InputCard extends StatelessWidget {
  final String desc;
  final TextEditingController controller;

  const InputCard({
    Key? key,
    required this.desc,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                desc,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}