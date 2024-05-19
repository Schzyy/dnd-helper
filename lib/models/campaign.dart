class Campaign {
  String? name;
  List<Character> characters;
  String? notes;

  Campaign(
    {
      required this.name, 
      required this.characters,
      this.notes,
    }
  );
}

class Character {
  late String name;
  late int level;
  late String? characterclass;
  late int initModifier;
  late int? armorClass;
  late Hp? hp;
  late Stats? stats;
  late int proficiency;
  late Spells? spells;
  late Conditions? conditions;

  Character(
    {
      required this.name,
      required this.level,
      required this.characterclass,
      required this.initModifier,
      required this.armorClass,
      required this.hp,
      required this.stats,
      this.spells,
      this.conditions,
    }
  );
}

class Hp {
  int? maxHp;
  int? currentHp;
  int? tempHp;

  Hp({
    this.maxHp, 
    this.currentHp, 
    this.tempHp
    }
  );
}

class Stats {
  late int str;
  late bool strProfieciency;
  late int dex;
  late bool dexProfieciency;
  late int con;
  late bool conProfieciency;
  late int inte;
  late bool intProfieciency;
  late int wis;
  late bool wisProfieciency;
  late int cha;
  late bool chaProfieciency;

  Stats(
    {
      required this.str,
      required this.strProfieciency,
      required this.dex,
      required this.dexProfieciency,
      required this.con,
      required this.conProfieciency,
      required this.inte,
      required this.intProfieciency,
      required this.wis,
      required this.wisProfieciency,
      required this.cha,
      required this.chaProfieciency,

    }
  );
}

class Spells {
  late Slots? one;
  late Slots? two;
  late Slots? three;
  late Slots? four;
  late Slots? fife;
  late Slots? six;
  late Slots? seven;
  late Slots? eight;
  late Slots? nine;

  Spells(
    {
      this.one,
      this.two,
      this.three,
      this.four,
      this.fife,
      this.six,
      this.seven,
      this.eight,
      this.nine
    }
  );
}

class Slots {
  late int base;
  late int used;
}

class Conditions {
  late bool blinded;
  late bool charmed;
  late bool deafend;
  late bool frightend;
  late bool grappled;
  late bool incapacitated;
  late bool invisible;
  late bool paralyzed;
  late bool petrified;
  late bool poisoned;
  late bool prone;
  late bool restrained;
  late bool stunned;
  late bool unconscious;
  late int exhaustion;


}
