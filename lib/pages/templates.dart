import 'package:dmhelper/models/updater.dart';
import 'package:dmhelper/pages/charactercreator.dart';
import 'package:flutter/material.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/pages/characterview.dart';
import 'package:provider/provider.dart';
import 'package:dmhelper/models/updater.dart';

class TemplatePage extends StatelessWidget {
  TemplatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
        children: [
          TopbarTemplates(),
          Expanded(
            child: TemplatesDisplay(),
          ),
        ],
    );
  }
}

class TopbarTemplates extends StatefulWidget {
  const TopbarTemplates({super.key});

  @override
  State<TopbarTemplates> createState() => _TopbarTemplatesState();
}

class _TopbarTemplatesState extends State<TopbarTemplates> {
  void _navigateAndRefresh(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CharactercreatorPage(template: true, index: 0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              "My Characters",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 15, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              height: 50,
              width: 50,
              child: GestureDetector(
                child: const Icon(
                  Icons.add,
                  size: 40,
                ),
                onTap: () {
                  _navigateAndRefresh(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TemplateCard extends StatelessWidget {
  final String name;
  final String rasse;
  final String characterclass;
  final int armorclass;
  final int init;
  final int index;
  
  const TemplateCard({
    super.key,
    required this.name,
    required this.rasse,
    required this.characterclass, 
    required this.armorclass, 
    required this.init, 
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Card(
        color: const Color.fromARGB(255, 55, 55, 55),
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 223, 54, 77),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)
                )
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10,10,10,0),
                      child: Icon(
                        Icons.battery_saver,
                        size: 30,
                      ),
                    ),
                  RotatedBox(
                    quarterTurns: 135,
                    child: Text(
                      "Enemy",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 128, 21, 35)
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 35
                          ),
                        ),
                        GestureDetector(
                          child: const Icon(
                            Icons.add_circle,
                            size: 30,
                          ),
                          onTap: () {
                            chars.removeAt(index);
                            Provider.of<Updater>(context, listen: false).refresh();
                          }
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$rasse    $characterclass",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          ),
                        Text(
                          "+ $init     $armorclass",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        
      ),
    );
  }
}

class TemplatesDisplay extends StatefulWidget {
  const TemplatesDisplay({super.key});

  @override
  State<TemplatesDisplay> createState() => _TemplatesDisplayState();
}

class _TemplatesDisplayState extends State<TemplatesDisplay> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Updater>(builder: (context, value, child) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        primary: false,
        itemCount: chars.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CharacterPage(char: chars[index]))),
            child: TemplateCard(
              name: chars[index].name,
              rasse: chars[index].race,
              characterclass: chars[index].characterclass,
              armorclass: chars[index].armorClass,
              init: chars[index].stats.dex,
              index: index,
            ),
          );
        },
      );
    });
  }
}