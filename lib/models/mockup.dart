import 'campaign.dart';

//Beispielwerte zum testen solange die Datenbank nicht sitzt

//Mockup für Campainglist
List<Campaign> campaigns = [
  Campaign(
    name: 'Azeroth',
    characters: [
      Character(
        good: true,
        name: "Hugo",
        level: 13,
        race: "Altersheim",
        characterclass: "Barbar",
        initModifier: 4,
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
        good: true,
        name: "Lakschuh",
        level: 13,
        race: "Gamer",
        characterclass: "Barbar",
        initModifier: 4,
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
        good: true,
        name: "Bando",
        level: 13,
        race: "Balkan",
        characterclass: "Barbar",
        initModifier: 4,
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
        good: true,
        name: "Hugo",
        level: 13,
        race: "unknown",
        characterclass: "Barbar",
        initModifier: 4,
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
        good: true,
        name: "Lakschuh",
        level: 13,
        race: "Mensch",
        characterclass: "Barbar",
        initModifier: 4,
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
    good: false,
    name: "Gomme",
    level: 10, 
    race: "Gnom",
    characterclass: "Mage", 
    initModifier: 6, 
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