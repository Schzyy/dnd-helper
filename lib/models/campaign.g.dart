// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CampaignAdapter extends TypeAdapter<Campaign> {
  @override
  final int typeId = 0;

  @override
  Campaign read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Campaign(
      name: fields[0] as String,
      characters: (fields[1] as List).cast<Character>(),
    );
  }

  @override
  void write(BinaryWriter writer, Campaign obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.characters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CampaignAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final int typeId = 1;

  @override
  Character read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Character(
      participate: fields[0] as bool,
      dead: fields[1] as bool,
      amount: fields[2] as int,
      initModifier: fields[3] as int,
      currentInit: fields[4] as int,
      good: fields[5] as bool,
      name: fields[6] as String,
      race: fields[8] as String,
      level: fields[7] as int,
      characterclass: fields[9] as String,
      armorClass: fields[10] as int,
      walkingspeed: fields[11] as int,
      hp: fields[12] as Hp,
      stats: fields[13] as Stats,
    );
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.participate)
      ..writeByte(1)
      ..write(obj.dead)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.initModifier)
      ..writeByte(4)
      ..write(obj.currentInit)
      ..writeByte(5)
      ..write(obj.good)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.level)
      ..writeByte(8)
      ..write(obj.race)
      ..writeByte(9)
      ..write(obj.characterclass)
      ..writeByte(10)
      ..write(obj.armorClass)
      ..writeByte(11)
      ..write(obj.walkingspeed)
      ..writeByte(12)
      ..write(obj.hp)
      ..writeByte(13)
      ..write(obj.stats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HpAdapter extends TypeAdapter<Hp> {
  @override
  final int typeId = 2;

  @override
  Hp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hp(
      maxHp: fields[0] as int,
      currentHp: fields[1] as int?,
      tempHp: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Hp obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.maxHp)
      ..writeByte(1)
      ..write(obj.currentHp)
      ..writeByte(2)
      ..write(obj.tempHp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HpAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatAdapter extends TypeAdapter<Stats> {
  @override
  final int typeId = 3;

  @override
  Stats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stats(
      str: fields[0] as int,
      strProfieciency: fields[1] as bool,
      dex: fields[2] as int,
      dexProfieciency: fields[3] as bool,
      con: fields[4] as int,
      conProfieciency: fields[5] as bool,
      inte: fields[6] as int,
      intProfieciency: fields[7] as bool,
      wis: fields[8] as int,
      wisProfieciency: fields[9] as bool,
      cha: fields[10] as int,
      chaProfieciency: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Stats obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.str)
      ..writeByte(1)
      ..write(obj.strProfieciency)
      ..writeByte(2)
      ..write(obj.dex)
      ..writeByte(3)
      ..write(obj.dexProfieciency)
      ..writeByte(4)
      ..write(obj.con)
      ..writeByte(5)
      ..write(obj.conProfieciency)
      ..writeByte(6)
      ..write(obj.inte)
      ..writeByte(7)
      ..write(obj.intProfieciency)
      ..writeByte(8)
      ..write(obj.wis)
      ..writeByte(9)
      ..write(obj.wisProfieciency)
      ..writeByte(10)
      ..write(obj.cha)
      ..writeByte(11)
      ..write(obj.chaProfieciency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
