import 'package:flutter/material.dart';
import 'package:dmhelper/pages/campaigncreator.dart';
import 'package:dmhelper/pages/campaingview.dart';
import 'package:dmhelper/pages/templates.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:flutter/widgets.dart';
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
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Space',
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.white),
          displaySmall: TextStyle(color: Colors.white),
          headlineLarge: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white),
          labelMedium: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: Colors.white),
        ),
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
        iconSize: 40,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: const Color.fromARGB(255, 55, 55, 55),
        currentIndex: currentPageIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
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
  void goToCampaignCreation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Campaigncreator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              "My Campaigns",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 15, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white
              ),
              height: 50,
              width: 50,
              child: GestureDetector(
                child: const Icon(
                  Icons.add,
                  size: 40,
                ),
                onTap: () {
                  goToCampaignCreation();
                },
              ),
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
      color: const Color.fromARGB(255, 55, 55, 55),
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0,5.0,15.0,5),
                  child: Icon(
                    Icons.house,
                    size: 40,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0,0,15.0,0),
                  child: Text("Campaign"),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0,15.0,15.0,0),
                child: Container(
                  width: 300,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0,15.0,15.0,0),
                child: GestureDetector(
                  child: const Icon(
                    Icons.three_p_sharp,
                    size: 40,
                  ),
                  onTap: () {}
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Text(
                  '$characters Heroes',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          )
        ],
      )
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


//TO-DO 
// Color Variations to the CampaingCard
// Add Functionality to remove a Campaing
// Make a Pop up for Campaign creation