import 'package:hive/hive.dart';

import 'campaign.dart';

late Box hiveBox;

void getFromBox(Box box) {
  campaigns = (box.get('mockupcampaigns', defaultValue: campaigns).cast<Campaign>());
  chars = (box.get('mockupcharacters', defaultValue: chars) as List).cast<Character>();
}

void saveToBox(Box box) {
  box.put('mockupcampaigns', campaigns);
  box.put('mockupcharacters', chars);
}

List<Campaign> campaigns = [
  Campaign(
    name: 'Azeroth',
    characters: [
      Character(
        participate: true,
        dead: false,
        amount: 0,
        currentInit: 0,
        initModifier: 4,
        good: true,
        name: "Hugo",
        level: 13,
        race: "Altersheim",
        characterclass: "Barbar",
        walkingspeed: 30,
        armorClass: 17,
        hp: Hp(
          maxHp: 60,
          currentHp: 60,
          tempHp: 0
        ),
        stats: Stats(
          str: 16,
          strProfieciency: false,
          dex: 10,
          dexProfieciency: false,
          con: 16,
          conProfieciency: true,
          inte: 10,
          intProfieciency: true,
          wis: 16,
          wisProfieciency: false,
          cha: 10,
          chaProfieciency: false,
        )
      ),
      Character(
        participate: true,
        dead: false,
        amount: 0,
        currentInit: 0,
        initModifier: 4,
        good: true,
        name: "Lakschuh",
        level: 13,
        race: "Gamer",
        characterclass: "Barbar",
        walkingspeed: 30,
        armorClass: 17,
        hp: Hp(
          maxHp: 60,
          currentHp: 60,
          tempHp: 0
        ),
        stats: Stats(
          str: 16,
          strProfieciency: false,
          dex: 10,
          dexProfieciency: false,
          con: 16,
          conProfieciency: false,
          inte: 10,
          intProfieciency: false,
          wis: 16,
          wisProfieciency: false,
          cha: 10,
          chaProfieciency: false,
        )
      ),  
    Character(
        participate: false,
        dead: false,
        amount: 0,
        currentInit: 0,
        initModifier: 4,
        good: true,
        name: "Bando",
        level: 13,
        race: "Balkan",
        characterclass: "Barbar",
        walkingspeed: 30,
        armorClass: 17,
        hp: Hp(
          maxHp: 60,
          currentHp: 60,
          tempHp: 0
        ),
        stats: Stats(
          str: 16,
          strProfieciency: false,
          dex: 10,
          dexProfieciency: false,
          con: 16,
          conProfieciency: false,
          inte: 10,
          intProfieciency: false,
          wis: 16,
          wisProfieciency: false,
          cha: 10,
          chaProfieciency: false,
        )
      )
    ]
  ),
  Campaign(
    name: 'Blackrockspire',
    characters: [
      Character(
        participate: false,
        dead: false,
        amount: 0,
        currentInit: 0,
        initModifier: 4,
        good: true,
        name: "Hugo",
        level: 13,
        race: "unknown",
        characterclass: "Barbar",
        walkingspeed: 30,
        armorClass: 17,
        hp: Hp(
          maxHp: 60,
          currentHp: 60,
          tempHp: 0
        ),
        stats: Stats(
          str: 16,
          strProfieciency: false,
          dex: 10,
          dexProfieciency: false,
          con: 16,
          conProfieciency: false,
          inte: 10,
          intProfieciency: false,
          wis: 16,
          wisProfieciency: false,
          cha: 10,
          chaProfieciency: false,
        )
      ),
      Character(
        participate: false,
        dead: false,
        amount: 0,
        currentInit: 0,
        initModifier: 4,
        good: true,
        name: "Lakschuh",
        level: 13,
        race: "Mensch",
        characterclass: "Barbar",
        walkingspeed: 30,
        armorClass: 17,
        hp: Hp(
          maxHp: 60,
          currentHp: 60,
          tempHp: 0
        ),
        stats: Stats(
          str: 16,
          strProfieciency: false,
          dex: 10,
          dexProfieciency: false,
          con: 16,
          conProfieciency: false,
          inte: 10,
          intProfieciency: false,
          wis: 16,
          wisProfieciency: false,
          cha: 10,
          chaProfieciency: false,
        )
      ),  
    ]
  )
];

Combat combat = Combat();

//Templateliste Momentan nur gegner
List<Character> chars = [
  Character(
    participate: false,
    dead: false,
    amount: 0,
    currentInit: 0,
    initModifier: 4,
    good: false,
    name: "Rathnu",
    level: 10, 
    race: "Gnom",
    characterclass: "Mage", 
    walkingspeed: 30,
    armorClass: 12, 
    hp: Hp(
      currentHp: 60,
      maxHp: 60,
      tempHp: 0
    ), 
    stats: Stats(
      str: 9,
      strProfieciency: false,
      dex: 12,
      dexProfieciency: false,
      con: 10,
      conProfieciency: false,
      inte: 18,
      intProfieciency: false,
      wis: 14,
      wisProfieciency: false,
      cha: 10,
      chaProfieciency: false,
      
    )
  )
];