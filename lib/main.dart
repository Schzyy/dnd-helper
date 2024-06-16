import 'package:flutter/material.dart';
import 'package:dmhelper/pages/campaigncreator.dart';
import 'package:dmhelper/pages/campaingview.dart';
import 'package:dmhelper/pages/templates.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Updater(),
      child: const CampaignStart(),
    ),
  );
}

class CampaignStart extends StatelessWidget {
  const CampaignStart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Space'
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 1;

  final List<Widget> pages = [
    TemplatePage(),
    const CampaignSelector(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Templates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Campaigns',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}

class CampaignSelector extends StatelessWidget {
  const CampaignSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TopbarCampaigns(),
        Expanded(
          child: CampaignsList(),
        ),
      ],
    );
  }
}

class TopbarCampaigns extends StatefulWidget {
  const TopbarCampaigns({super.key});

  @override
  State<TopbarCampaigns> createState() => _TopbarCampaignsState();
}

class _TopbarCampaignsState extends State<TopbarCampaigns> {
  void goToCampaignCreation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Campaigncreator()),
    );
    if (result != null) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "My Campaigns",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: goToCampaignCreation,
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class CampaignOverviewCard extends StatelessWidget {
  final String title;
  final int characters;
  const CampaignOverviewCard({
    super.key,
    required this.title,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 5,
              width: double.infinity,
              color: Colors.amber,
            ),
            const SizedBox(height: 8),
            Text(
              'Heroes: $characters',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.bottomRight,
              child: Icon(Icons.check_circle, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

class CampaignsList extends StatefulWidget {
  const CampaignsList({super.key});

  @override
  State<CampaignsList> createState() => _CampaignsListState();
}

class _CampaignsListState extends State<CampaignsList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Updater>(builder: (context, value, child) {
      return ListView.builder(
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CampaingViewPage(index: index),
                ),
              );
            },
            child: CampaignOverviewCard(
              title: campaigns[index].name,
              characters: campaigns[index].characters.length,
            ),
          );
        },
      );
    });
  }
}

class NavBarMyCampaignsTemplate extends StatefulWidget {
  final bool templates;

  const NavBarMyCampaignsTemplate({super.key, required this.templates});

  @override
  State<NavBarMyCampaignsTemplate> createState() =>
      _NavBarMyCampaignsTemplateState();
}

class _NavBarMyCampaignsTemplateState extends State<NavBarMyCampaignsTemplate> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TemplatePage()),
              );
            },
            child: Container(
              height: 50,
              color: widget.templates ? Colors.blueGrey : Colors.black,
              child: const Center(
                child: Text(
                  "TEMPLATES",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
            },
            child: Container(
              height: 50,
              color: widget.templates ? Colors.black : Colors.blueGrey,
              child: const Center(
                child: Text(
                  "MY CAMPAIGNS",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
