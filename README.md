# dmhelper

Flutter Projekt für Mobile Anwendungen

21.05.

Aktueller Stand:
    Base exisitert ist sehr Unpolished aber das wird später verbessert

Probleme die ich bis jetzz gefunden habe oder schwierigkeiten welche mir begegnet sind:
    -beim aktuallisieren vom Mockup wird nichts verändert in der Darstellung

    Pages: 
        main
        campaingCreator
        templates
        characterCreator
    Models:
        Campaing, Character Modelle
        Mockup fürs testen ohne Datenbank

Funktionen oder Ideen die man sich anschauen kann:
    Dismissable Widget um Charaktere oder Campaigns zu entfernen


Recap Character Object
    -name: String
    -level: int
    -race: String
    -characterClass: String
    -initModifier: int
    -armorclass: int
    -hp: Hp(
        maxHp: int
        currentHp: int?
        tempHp: int?
    )
    -stats: Stats(
        str: int
        strProficiency: bool
        dex: int
        dexProficiency: bool
        con: int
        conProficiency: bool
        inte: int
        intProficiency: bool
        wis: int
        wisProficiency: bool
        cha: int
        chaProficiency: bool
    )

21.05.2024 
    Template -> AddCharacter Prototype
    Template -> CharacterPage Prototype

    Lil Prio List:
        was ist gerade nicht so wichtig:   
            Was sollte unser erster Prototyp können:
                -> Spieler(keine Npc) vs Templates(Npcs)
                -> Combat log