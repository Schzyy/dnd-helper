//Datenmodel für die Campagne und die Characters
void removeCampaing(List<Campaign> campaigns) {

}

void createCampaign(List<Campaign> campaign, String name) {
  Campaign newCampaing = Campaign(name: name, characters: []);
  campaign.add(newCampaing);
}

class Campaign {
  String name;
  List<Character> characters;

  Campaign({
    required this.name,
    required this.characters,
  });
  void removeCharacter(int i) {
    characters.removeAt(i);
  }
}

class Character {
  bool participate;
  bool dead;
  int amount;
  int initModifier;
  int currentInit;
  bool good;
  String name;
  int level;
  String race;
  String characterclass;
  int armorClass;
  int walkingspeed;
  Hp hp;
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

class Hp {
  int maxHp;
  int? currentHp;
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