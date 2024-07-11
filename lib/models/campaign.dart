import 'package:hive/hive.dart';

part 'campaign.g.dart';

class HiveFunctions {
  
  final Box box = Hive.box('mockup');

}

@HiveType(
  typeId: 0,
  adapterName: 'campaignAdapter'
)

class Campaign {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<Character> characters;

  Campaign({
    required this.name,
    required this.characters,
  });
}
@HiveType(
  typeId: 1,
  adapterName: 'CharacterAdapter'
)
class Character {
  
  @HiveField(0)
  bool participate;
  @HiveField(1)
  bool dead;
  @HiveField(2)
  int amount;
  @HiveField(3)
  int initModifier;
  @HiveField(4)
  int currentInit;
  @HiveField(5)
  bool good;
  @HiveField(6)
  String name;
  @HiveField(7)
  int level;
  @HiveField(8)
  String race;
  @HiveField(9)
  String characterclass;
  @HiveField(10)
  int armorClass;
  @HiveField(11)
  int walkingspeed;
  @HiveField(12)
  Hp hp;
  @HiveField(13)
  Stats stats;

  int returnInitModifier(int i) {
    i = i - 10;
    double iTwo = i.toDouble();
    iTwo = iTwo / 2;
    i = iTwo.toInt();
    return i;
  }

  Character({
    required this.participate,
    required this.dead,
    required this.amount,
    required this.initModifier,
    required this.currentInit,
    required this.good,
    required this.name,
    required this.race,
    required this.level,
    required this.characterclass,
    required this.armorClass,
    required this.walkingspeed,
    required this.hp,
    required this.stats,
  });

  // Copy constructor
  Character.copy(Character from)
      : participate = from.participate,
        dead = from.dead,
        amount = from.amount,
        initModifier = from.initModifier,
        currentInit = from.currentInit,
        good = from.good,
        name = from.name,
        level = from.level,
        race = from.race,
        characterclass = from.characterclass,
        armorClass = from.armorClass,
        walkingspeed = from.walkingspeed,
        hp = Hp.copy(from.hp),
        stats = Stats.copy(from.stats);
}
@HiveType(
  typeId: 2,
  adapterName: 'hpAdapter'
)
class Hp {
  @HiveField(0)
  int maxHp;
  @HiveField(1)
  int? currentHp;
  @HiveField(2)
  int? tempHp;

  Hp({
    required this.maxHp,
    this.currentHp,
    this.tempHp,
  });

  // Copy constructor
  Hp.copy(Hp from)
      : maxHp = from.maxHp,
        currentHp = from.currentHp,
        tempHp = from.tempHp;
}
@HiveType(
  typeId: 3,
  adapterName: 'hpAdapter'
)
class Stats {
  @HiveField(0)
  int str;
  @HiveField(1)
  bool strProfieciency;
  @HiveField(2)
  int dex;
  @HiveField(3)
  bool dexProfieciency;
  @HiveField(4)
  int con;
  @HiveField(5)
  bool conProfieciency;
  @HiveField(6)
  int inte;
  @HiveField(7)
  bool intProfieciency;
  @HiveField(8)
  int wis;
  @HiveField(9)
  bool wisProfieciency;
  @HiveField(10)
  int cha;
  @HiveField(11)
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

  // Copy constructor
  Stats.copy(Stats from)
      : str = from.str,
        strProfieciency = from.strProfieciency,
        dex = from.dex,
        dexProfieciency = from.dexProfieciency,
        con = from.con,
        conProfieciency = from.conProfieciency,
        inte = from.inte,
        intProfieciency = from.intProfieciency,
        wis = from.wis,
        wisProfieciency = from.wisProfieciency,
        cha = from.cha,
        chaProfieciency = from.chaProfieciency;
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