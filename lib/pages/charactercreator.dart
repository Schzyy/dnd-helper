// ignore_for_file: unrelated_type_equality_checks

import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/pallete.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  bool intProf = true;
  bool conProf = false;
  bool wisProf = false;
  bool chaProf = false;

  void saveCharacter(
      int charIndex, int campaignIndex, bool newCharacter, bool good) {
    Character newChar = Character(
        participate: true,
        dead: false,
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

    if (good == false && newCharacter == true) {
      chars.add(newChar);
    }
    if (good == false && newCharacter == false) {
      chars[charIndex] = newChar;
    }
    if (good == true && newCharacter == false) {
      campaigns[campaignIndex].characters[charIndex] = newChar;
    }
    if (good == true && newCharacter == true) {
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
  i = iTwo.floor();
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
  void toggleProf(bool prof) {
    prof = !prof;
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
    levelController.text = "1";
    msController.text = "30";
    hpController.text = "20";
    strController.text = "8";
    dexController.text = "8";
    conController.text = "8";
    chaController.text = "8";
    wisController.text = "8";
    intController.text = "8";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Updater>(builder: (context, value, child) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CharacterCreatorTopBar(),
            Container(
              margin: const EdgeInsets.fromLTRB(17.5, 30, 0, 0),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      height: 60,
                      decoration: BoxDecoration(
                        color: widget.good ? AppProperties.heroPurple : AppProperties.enemyRed,
                        borderRadius: BorderRadius.circular(AppProperties.bRadius),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: widget.good ? 
                          const Icon(
                            FontAwesomeIcons.shield,
                            color: AppProperties.herpPurpleDark,
                          ) :
                          SvgPicture.asset(
                            'lib/assets/npcIcon.svg',
                            color: AppProperties.enemyRedDark,
                          ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              widget.good ? "HERO" : "ENEMY",
                              style: TextStyle(
                                color: widget.good ? AppProperties.herpPurpleDark : AppProperties.enemyRedDark,
                                fontSize: 32,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
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
                            saveToBox(hiveBox);
                            });  
                          },
                        ),
                      ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextInputChar(
                controller: nameController,
                desc: "NAME",
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppProperties.bRadius),
                  color: AppProperties.cardColor2),
              height: 100,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  children: [
                  Flexible(
                    flex: 1,
                    child: TextInputChar(
                          controller: raceController,
                          desc: "RACE",
                        ),
                  ),

                  Flexible(
  flex: 1,
  child: TextInputChar(
                          controller: classController,
                          desc: "CLASS"
                        ),
),

                  ],
                ),
              ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppProperties.bRadius),
                  color: AppProperties.cardColor2),
              height: 260,
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
                          child: TapInputChar(
                            controller: strController,
                            desc: "STRENGTH",
                            prof: strProf,
                            returnProf: returnProf,
                            levelController: levelController,
                            toProf: toProf,
                            toggleProf: toggleProf,
                            updateValue: updateValue,
                          )
                        ),
                        Expanded(
                          child: TapInputChar(
                            controller: dexController,
                            desc: "DEXTERITY",
                            prof: dexProf,
                            returnProf: returnProf,
                            levelController: levelController,
                            toProf: toProf,
                            toggleProf: toggleProf,
                            updateValue: updateValue,
                          )
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: TapInputChar(
                            controller: intController,
                            desc: "INTELIGENCE",
                            prof: intProf,
                            returnProf: returnProf,
                            levelController: levelController,
                            toProf: toProf,
                            toggleProf: toggleProf,
                            updateValue: updateValue,
                          )
                        ),
                        Expanded(
                          child: TapInputChar(
                            controller: conController,
                            desc: "CONSTITUTION",
                            prof: conProf,
                            returnProf: returnProf,
                            levelController: levelController,
                            toProf: toProf,
                            toggleProf: toggleProf,
                            updateValue: updateValue,
                          )
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: TapInputChar(
                            controller: wisController,
                            desc: "WISDOM",
                            prof: wisProf,
                            returnProf: returnProf,
                            levelController: levelController,
                            toProf: toProf,
                            toggleProf: toggleProf,
                            updateValue: updateValue,
                          )
                        ),
                        Expanded(
                          child: TapInputChar(
                            controller: chaController,
                            desc: "CHARISMA",
                            prof: chaProf,
                            returnProf: returnProf,
                            levelController: levelController,
                            toProf: toProf,
                            toggleProf: toggleProf,
                            updateValue: updateValue,
                          )
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
                              decoration: BoxDecoration(
                                color: AppProperties.cardColor2,
                                borderRadius: BorderRadius.circular(AppProperties.bRadius)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: Text(
                                      "ARMORCLASS",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                    child: Text(
                                      armorController.text,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20
                                      ),
                                    ),
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
                                child: Text("INITIATIVE",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20
                                ),
                              ),
                            ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                child: Text(getInitiative(
                                        toProf(int.parse(dexController.text))).toString(),
                                        style:const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20
                                ),),
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
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppProperties.cardColor2
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: Text(
                                      "LEVEL",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                    child: Text(
                                      levelController.text,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
                                  style: TextStyle(
                                  color: AppProperties.allyYellow,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20
                                ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                child: Text(
                                  "+ ${returnProf(int.parse(levelController.text))}",
                                  style: const TextStyle(
                                    color: AppProperties.allyYellow,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20
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
                            child: Container(
                              color: AppProperties.cardColor2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: Text("WALKINGSPEED",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                    child: Text(msController.text,
                                    style:  const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                updateValue(msController, "speed");
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: TextInputChar(
              controller: hpController,
              desc: "Health Points",
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
    );});
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


class TextInputChar extends StatefulWidget {
  const TextInputChar({
    super.key,
    required this.controller,
    required this.desc
  });
  final String desc;
  final TextEditingController controller;
  @override
  State<TextInputChar> createState() => _TextInputCharState();
}

class _TextInputCharState extends State<TextInputChar> {
  bool editing = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppProperties.bRadius),
                    color: AppProperties.cardColor2),
                height: 100,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Text(
                        widget.desc,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: editing
                          ? TextField(
                              controller: widget.controller,
                              autofocus: true,
                              onSubmitted: (value) {
                                if (widget.controller.text.isEmpty) {
                                  widget.controller.text = "-";
                                }
                                setState(() {
                                  editing = false;
                                });
                              },
                            )
                          : Text(
                            widget.controller.text,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20
                            ),
                          ),
                    )
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  editing = true;
                });
              },
            );
  }
}

class TapInputChar extends StatefulWidget {
  const TapInputChar({
    super.key,
    required this.prof,
    required this.controller,
    required this.levelController,
    required this.toProf,
    required this.returnProf,
    required this.updateValue,
    required this.toggleProf,
    required this.desc,
  });

  final bool prof;
  final TextEditingController controller;
  final TextEditingController levelController;
  final Function(int) toProf;
  final Function returnProf;
  final Function updateValue;
  final Function(bool) toggleProf;
  final String desc;

  @override
  State<TapInputChar> createState() => _TapInputCharState();
}

class _TapInputCharState extends State<TapInputChar> {
  late bool _isProf;

  @override
  void initState() {
    super.initState();
    _isProf = widget.prof;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: AppProperties.cardColor2,
          borderRadius: BorderRadius.circular(AppProperties.bRadius)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                widget.desc,
                style: TextStyle(
                  color: _isProf ? AppProperties.allyYellow : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: _isProf
                  ? Text(
                      "${widget.controller.text}     + ${widget.toProf(int.parse(widget.controller.text)) + widget.returnProf(int.parse(widget.levelController.text))}",
                      style: const TextStyle(
                        color: AppProperties.allyYellow,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  : Text(
                      "${widget.controller.text}     + ${widget.toProf(int.parse(widget.controller.text))}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    ),
            ),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          widget.updateValue(widget.controller, "stat");
          Provider.of<Updater>(context, listen: false).refresh();
        });
      },
      onLongPress: () {
        setState(() {
          _isProf = !_isProf;
          widget.toggleProf(_isProf);
          Provider.of<Updater>(context, listen: false).refresh();
        });
      },
    );
  }
}