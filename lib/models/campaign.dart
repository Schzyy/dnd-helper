//Datenmodel für die Campagne und die Characters

class Campaign {
  String name;
  List<Character> characters;

  Campaign({
    required this.name,
    required this.characters,
  });
}

class Character {
  String name;
  int level;
  String rasse;
  String characterclass;
  int initModifier;
  int armorClass;
  Hp hp;
  Stats stats;

  Character({
    required this.name,
    required this.rasse,
    required this.level,
    required this.characterclass,
    required this.initModifier,
    required this.armorClass,
    required this.hp,
    required this.stats,
  });
}

class Hp {
  int maxHp;
  int currentHp;
  int tempHp;

  Hp({
    required this.maxHp,
    required this.currentHp,
    required this.tempHp,
  });
}

class Stats {
  int str;
  bool strProfieciency;
  int dex;
  bool dexProfieciency;
  int con;
  bool conProfieciency;
  int inte;
  bool intProfieciency;
  int wis;
  bool wisProfieciency;
  int cha;
  bool chaProfieciency;

  Stats({
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
  });
}