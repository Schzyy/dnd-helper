import 'package:dmhelper/models/mockup.dart';
import 'package:flutter/material.dart';

class CombatPage extends StatefulWidget {
  const CombatPage({super.key});

  @override
  State<CombatPage> createState() => _CombatPageState();
}

class _CombatPageState extends State<CombatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 160,
        width: 160,
        child: Text(combat.partake[0].currentInit.toString() + " " + (combat.partake[1].currentInit.toString()),
      )),
    );
  }
}