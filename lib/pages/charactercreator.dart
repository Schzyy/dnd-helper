import 'package:flutter/material.dart';
import 'package:dmhelper/models/campaign.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:provider/provider.dart';

class Charactercreator extends StatelessWidget {
  const Charactercreator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CharactercreatorPage(),
    );
  }
}

class CharactercreatorPage extends StatefulWidget {
  const CharactercreatorPage({super.key});

  @override
  State<CharactercreatorPage> createState() => _CharactercreatorPageState();
}

class _CharactercreatorPageState extends State<CharactercreatorPage> {
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CharacterCreatorAppBar(),
          Text("Create A NEW HERO"),
          Row(
            children: [
              CharacterNavigator(),
              GestureDetector(
                onTap: () {},
                child: Container(
                    height: 50,
                    width: 100,
                    color: Colors.white,
                    child: const Icon(
                      Icons.add,
                    )),
              ),
            ],
          ),
          Card(
            child: Column(
              children: [
                Text("Name"),
                TextField(
                  controller: nameController,
                )
              ],
            )
          ),
          Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Race"),
                    Text("Class"),
                  ],
                ),
                Row(
                  children: [
                    TextField(

                    ),
                    TextField()
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CharacterCreatorAppBar extends StatelessWidget {
  const CharacterCreatorAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CharacterNavigator extends StatefulWidget {
  const CharacterNavigator({super.key});

  @override
  State<CharacterNavigator> createState() => _CharacterNavigatorState();
}

class _CharacterNavigatorState extends State<CharacterNavigator> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


/*
import 'package:flutter/material.dart';
import 'package:dmhelper/models/campaign.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:provider/provider.dart';

class CharactercreatorPage extends StatelessWidget {
  final bool template;
  final int index;

  const CharactercreatorPage({
    super.key,
    required this.template,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Character Creation!"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
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
    super.key,
    required this.template,
    required this.index,
  });

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
        currentInit: 10,
        amount: 0,
        participate: true,
        good: true,
        name: _nameController.text,
        level: int.tryParse(_levelController.text) ?? 1,
        race: _raceController.text,
        characterclass: _characterClassController.text,
        armorClass: int.tryParse(_armorClassController.text) ?? 10,
        hp: Hp(
          currentHp: int.tryParse(_hpController.text) ?? 20,
          maxHp: int.tryParse(_hpController.text) ?? 20,
          tempHp: 0,
        ),
        stats: Stats(
          str: int.tryParse(_strController.text) ?? 10,
          strProfieciency: false,
          dex: int.tryParse(_dexController.text) ?? 10,
          dexProfieciency: false,
          con: int.tryParse(_conController.text) ?? 10,
          conProfieciency: false,
          inte: int.tryParse(_intController.text) ?? 10,
          intProfieciency: false,
          wis: int.tryParse(_wisController.text) ?? 10,
          wisProfieciency: false,
          cha: int.tryParse(_chaController.text) ?? 10,
          chaProfieciency: false,
        ),
      );
      if (widget.template) {
        newCharacter.participate = false;
        chars.add(newCharacter);
      } else {
        newCharacter.participate = true;
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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Change this to 2 for smaller card size
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 6.0, // Adjust this ratio to fit your needs
              ),
              itemCount: descriptions.length,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              desc,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */