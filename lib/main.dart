import 'package:flutter/material.dart';
import 'package:dmhelper/pages/campainglist.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:dmhelper/models/campaign.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';


void main() async {
  await Hive.initFlutter();
  runApp(
    ChangeNotifierProvider(
      create: (context) => Updater(),
      child: const CampaignStart(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CampaignStart();
  }
}