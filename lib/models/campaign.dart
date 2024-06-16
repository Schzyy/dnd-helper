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
  bool participate;
  int amount;
  int currentInit;
  bool good;
  String name;
  int level;
  String race;
  String characterclass;
  int armorClass;
  Hp hp;
  Stats stats;

  Character({
    required this.participate,
    required this.amount,
    required this.currentInit,
    required this.good,
    required this.name,
    required this.race,
    required this.level,
    required this.characterclass,
    required this.armorClass,
    required this.hp,
    required this.stats,
  });
}

class Hp {
  int maxHp;
  int? currentHp;
  int? tempHp;

  Hp({
    required this.maxHp,
    this.currentHp,
    this.tempHp,
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

class Combat {
  List<Character> partake = [];
  List<Character> heroes = [];
  List<Character> opponentes = [];
}

//Help für die CharacterViewSeite
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