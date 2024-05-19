import 'package:dmhelper/Tools/widget_templates.dart';
import 'package:flutter/material.dart';
import '/models/campaign.dart';
import 'models/mockup.dart';
import 'dart:developer';

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
  final List<Campaign> cam = campaigns;
  final List<Character>? chars = null; 
  CampaignSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
        body: Column(
          children: [
            const OverHeadMyCampaigns(),
            Expanded(
              child: Reload(),
            ),
            const NavBarMyCampaignsTemplate(
              templates: false,
              )
          ],
    ));
  }
}

class Reload extends StatefulWidget {
  const Reload({super.key});

  @override
  State<Reload> createState() => _ReloadState();
}

class _ReloadState extends State<Reload> {
  @override
  Widget build(BuildContext context) {
    return 
        ListView.builder(
                    scrollDirection: Axis.vertical,
                    primary: false,
                    itemCount: campaigns.length,
                    itemBuilder: (context, index) {
                      return CampaignOverviewCard(title: campaigns[index].name, characters: campaigns[index].characters.length);
                    }
                  );
    
  }
}

//CampaignOverviewCard(title: "hello", characters: ["a","b"])