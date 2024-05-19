import 'package:dmhelper/Tools/widget_templates.dart';
import 'package:flutter/material.dart';
import '/models/campaign.dart';

void main() {
  runApp(const CampaignStart());
}

class CampaignStart extends StatelessWidget {
  const CampaignStart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CampaignSelector(),
    );
  }
}

class CampaignSelector extends StatelessWidget {
  final List<Campaign> campaigns = [
    Campaign(
      name: 'Campaign One',
      characters: ['Character A', 'Character B', 'Character C'],
    ),
    Campaign(
      name: 'Campaign Two',
      characters: ['Character D', 'Character E'],
    ),
    Campaign(
      name: 'Campaign Three',
      characters: ['Character F', 'Character G', 'Character H', 'Character I'],
    ),
  ];

  CampaignSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
        body: Column(
          children: [
            const OverHeadMyCampaigns(),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                primary: false,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const CampaignOverviewCard(title: "hello", characters: ["a","b"]);
                }
              ),
            ),
            const NavBarMyCampaignsTemplate(
              templates: false,
              )
          ],
    ));
  }
}

//CampaignOverviewCard(title: "hello", characters: ["a","b"])