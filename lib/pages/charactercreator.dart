// ignore_for_file: unrelated_type_equality_checks

import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/pallete.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dmhelper/models/campaign.dart';
import 'package:provider/provider.dart';

class Charactercreator extends StatefulWidget {
  const Charactercreator({
    super.key,
    this.existingChar,
    required this.good,
    required this.charIndex,
    required this.campaignIndex,
    required this.newChar,
  });

  final bool newChar;
  final Character? existingChar;
  final int charIndex;
  final int campaignIndex;
  final bool good;
  @override
  State<Charactercreator> createState() => _CharactercreatorState();
}

class _CharactercreatorState extends State<Charactercreator> {
  final nameController = TextEditingController();
  final raceController = TextEditingController();
  final classController = TextEditingController();
  final armorController = TextEditingController();
  final levelController = TextEditingController();
  final msController = TextEditingController();
  final hpController = TextEditingController();
  final strController = TextEditingController();
  final conController = TextEditingController();
  final wisController = TextEditingController();
  final chaController = TextEditingController();
  final intController = TextEditingController();
  final dexController = TextEditingController();

  bool nameEditing = false;
  bool raceEditing = false;
  bool classEditing = false;
  bool armorEditing = false;
  bool levelEditing = false;
  bool msEditing = false;
  bool hpEditing = false;
  bool strEditing = false;
  bool conEditing = false;
  bool wisEditing = false;
  bool chaEditing = false;
  bool intEditing = false;
  bool dexEditing = false;
  bool strProf = false;
  bool dexProf = false;
  bool intProf = false;
  bool conProf = false;
  bool wisProf = false;
  bool chaProf = false;

  void saveCharacter(
      int charIndex, int campaignIndex, bool newChar, bool good) {
    Character newChar = Character(
        participate: true,
        amount: 0,
        currentInit: 0,
        initModifier: toProf(int.parse(dexController.text)),
        good: good ? true : false,
        name: nameController.text,
        race: raceController.text,
        level: int.parse(levelController.text),
        characterclass: classController.text,
        armorClass: int.parse(armorController.text),
        walkingspeed: int.parse(msController.text),
        hp: Hp(maxHp: int.parse(hpController.text)),
        stats: Stats(
          str: int.parse(strController.text),
          dex: int.parse(dexController.text),
          inte: int.parse(intController.text),
          cha: int.parse(chaController.text),
          wis: int.parse(wisController.text),
          con: int.parse(conController.text),
          strProfieciency: strProf,
          dexProfieciency: dexProf,
          intProfieciency: intProf,
          conProfieciency: conProf,
          chaProfieciency: chaProf,
          wisProfieciency: wisProf,
        ));
        newChar.initModifier = toProf(newChar.stats.dex);

    if (good == false && newChar == true) {
      chars.add(newChar);
    }
    if (good == false && newChar == false) {
      chars[charIndex] = newChar;
    }
    if (good == true && newChar == false) {
      campaigns[campaignIndex].characters[charIndex] = newChar;
    }
    if (good == true && newChar == true) {
      campaigns[campaignIndex].characters.add(newChar);
    }
    Navigator.pop(context);
    Provider.of<Updater>(context, listen: false).refresh();
  }

  @override
  void initState() {
    if (widget.existingChar != null) {
      useCharacter(widget.existingChar!);
    } else {
      characterTemplate();
    }
    
    super.initState();
  }

  int toProf(int i) {
    i = i - 10;
    double iTwo = i.toDouble();
    iTwo = iTwo / 2;
    i = iTwo.toInt();
    return i;
  }

  int returnProf(int i) {
    double iTwo = 1 + (i * 0.25);
    i = iTwo.toInt();
    return i + 1;
  }

  int getInitiative(int i) {
    return i + 10;
  }

  void updateValue(TextEditingController controller, String what) {
    int s = int.parse(controller.text);
    if (what == "stat") {
      s++;
      if (s == 31) {
        s = 8;
      }
    }
    if (what == "armor") {
      s++;
      if (s == 31) {
        s = 1;
      }
    }
    if (what == "speed") {
      s = s + 5;
      if (s == 95) {
        s = 0;
      }
    }
    if (what == "level") {
      s++;
      if (s == 21) {
        s = 1;
      }
    }
    controller.text = s.toString();
  }

  bool isNotNumeric(String value) {
    // ignore: unnecessary_null_comparison
    if (value == null) {
      return true;
    }
    return double.tryParse(value) == null;
  }

  void useCharacter(Character char) {
    nameController.text = char.name;
    raceController.text = char.race;
    classController.text = char.characterclass;
    armorController.text = char.armorClass.toString();
    levelController.text = char.level.toString();
    msController.text = char.walkingspeed.toString();
    hpController.text = char.hp.maxHp.toString();
    strController.text = char.stats.str.toString();
    dexController.text = char.stats.dex.toString();
    conController.text = char.stats.con.toString();
    chaController.text = char.stats.cha.toString();
    wisController.text = char.stats.wis.toString();
    intController.text = char.stats.inte.toString();
  }

  void characterTemplate() {
    nameController.text = "-";
    raceController.text = "-";
    classController.text = "-";
    armorController.text = "10";
    levelController.text = "17";
    msController.text = "30";
    hpController.text = "20";
    strController.text = "10";
    dexController.text = "14";
    conController.text = "10";
    chaController.text = "10";
    wisController.text = "10";
    intController.text = "10";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CharacterCreatorTopBar(),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppProperties.bRadius),
                        color: AppProperties.enemyRedDark,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppProperties.bRadius),
                            color: AppProperties.enemyRed,
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.spaghettiMonsterFlying,
                                size: 35,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Text(
                                  "Enemy",
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        height: 60,
                        width: 60,
                        child: GestureDetector(
                          child: const Icon(
                            Icons.add,
                            size: 40,
                          ),
                          onTap: () {
                            setState(() {
                            saveCharacter(
                                widget.charIndex,
                                widget.campaignIndex,
                                widget.newChar,
                                widget.good
                              );  
                            });  
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppProperties.bRadius),
                    color: AppProperties.cardColor2),
                height: 100,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Text("Name"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: nameEditing
                          ? TextField(
                              controller: nameController,
                              autofocus: true,
                              onSubmitted: (value) {
                                if (nameController.text.isEmpty) {
                                  nameController.text = "-";
                                }
                                setState(() {
                                  nameEditing = false;
                                });
                              },
                            )
                          : Text(nameController.text),
                    )
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  nameEditing = true;
                });
              },
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppProperties.bRadius),
                  color: AppProperties.cardColor2),
              height: 100,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Text("Race"),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: raceEditing
                                ? TextField(
                                    controller: raceController,
                                    autofocus: true,
                                    onSubmitted: (value) {
                                      if (raceController.text.isEmpty) {
                                        raceController.text = "-";
                                      }
                                      setState(() {
                                        raceEditing = false;
                                      });
                                    },
                                  )
                                : Text(raceController.text),
                          )
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          raceEditing = true;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Text("Class"),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: classEditing
                                  ? TextField(
                                      controller: classController,
                                      autofocus: true,
                                      onSubmitted: (value) {
                                        if (classController.text.isEmpty) {
                                          classController.text = "-";
                                        }
                                        setState(() {
                                          classEditing = false;
                                        });
                                      },
                                    )
                                  : Text(classController.text),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          classEditing = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppProperties.bRadius),
                  color: AppProperties.cardColor2),
              height: 185,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Text("Strength",
                                      style: TextStyle(
                                          color: strProf
                                              ? Colors.blue
                                              : Colors.white)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  child: strProf
                                      ? Text(
                                          "${strController.text}     + ${toProf(int.parse(strController.text)) + returnProf(int.parse(levelController.text))}",
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        )
                                      : Text(
                                          "${strController.text}     + ${toProf(int.parse(strController.text))}"),
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                updateValue(strController, "stat");
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                strProf = !strProf;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Text("Dexterity",
                                      style: TextStyle(
                                          color: dexProf
                                              ? Colors.blue
                                              : Colors.white)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  child: dexProf
                                      ? Text(
                                          "${dexController.text}     + ${toProf(int.parse(dexController.text)) + returnProf(int.parse(levelController.text))}",
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        )
                                      : Text(
                                          "${dexController.text}     + ${toProf(int.parse(dexController.text))}"),
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                updateValue(dexController, "stat");
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                dexProf = !dexProf;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Text("Constitution",
                                      style: TextStyle(
                                          color: conProf
                                              ? Colors.blue
                                              : Colors.white)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  child: conProf
                                      ? Text(
                                          "${conController.text}     + ${toProf(int.parse(conController.text)) + returnProf(int.parse(levelController.text))}",
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        )
                                      : Text(
                                          "${conController.text}     + ${toProf(int.parse(intController.text))}"),
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                updateValue(conController, "stat");
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                conProf = !conProf;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Text("Intelligence",
                                      style: TextStyle(
                                          color: intProf
                                              ? Colors.blue
                                              : Colors.white)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  child: intProf
                                      ? Text(
                                          "${intController.text}     + ${toProf(int.parse(intController.text)) + returnProf(int.parse(levelController.text))}",
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        )
                                      : Text(
                                          "${intController.text}     + ${toProf(int.parse(intController.text))}"),
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                updateValue(intController, "stat");
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                intProf = !intProf;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Text("Wisdom",
                                      style: TextStyle(
                                          color: wisProf
                                              ? Colors.blue
                                              : Colors.white)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  child: wisProf
                                      ? Text(
                                          "${wisController.text}     + ${toProf(int.parse(wisController.text)) + returnProf(int.parse(levelController.text))}",
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        )
                                      : Text(
                                          "${wisController.text}     + ${toProf(int.parse(wisController.text))}"),
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                updateValue(wisController, "stat");
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                wisProf = !wisProf;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Text("Charisma",
                                      style: TextStyle(
                                          color: chaProf
                                              ? Colors.blue
                                              : Colors.white)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  child: chaProf
                                      ? Text(
                                          "${chaController.text}     + ${toProf(int.parse(chaController.text)) + returnProf(int.parse(levelController.text))}",
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        )
                                      : Text(
                                          "${chaController.text}     + ${toProf(int.parse(chaController.text))}"),
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                updateValue(chaController, "stat");
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                chaProf = !chaProf;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppProperties.bRadius),
                  color: AppProperties.cardColor2),
              height: 300,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              color: AppProperties.cardColor2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: Text("Armorclass"),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                    child: Text(armorController.text),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                updateValue(armorController, "armor");
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Text("Initiative"),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                child: Text(getInitiative(
                                        toProf(int.parse(dexController.text)))
                                    .toString()),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Text("Level"),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  child: Text(levelController.text),
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                updateValue(levelController, "level");
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Text(
                                  "Proficieny",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                child: Text(
                                  "+ ${returnProf(int.parse(levelController.text))}",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Text("Walking Speed"),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  child: Text(msController.text),
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                updateValue(msController, "speed");
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Text("Health Points"),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  child: hpEditing
                                      ? TextField(
                                          controller: hpController,
                                          autofocus: true,
                                          keyboardType: TextInputType.number,
                                          onSubmitted: (value) {
                                            setState(() {
                                              if (value.isEmpty ||
                                                  isNotNumeric(value)) {
                                                hpController.text = "-";
                                              } else {
                                                hpController.text = value;
                                              }
                                              hpEditing = false;
                                            });
                                          },
                                        )
                                      : Text(hpController.text),
                                )
                              ],
                            ),
                            onTap: () {
                              hpEditing = true;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterCreatorTopBar extends StatefulWidget {
  const CharacterCreatorTopBar({super.key});

  @override
  State<CharacterCreatorTopBar> createState() => _CharacterCreatorTopBarState();
}

class _CharacterCreatorTopBarState extends State<CharacterCreatorTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppProperties.bRadius),
                color: Colors.white,
              ),
              height: 40,
              width: 40,
              child: GestureDetector(
                child: const Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 10, 0),
            child: Text(
              "Create Enemy",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
