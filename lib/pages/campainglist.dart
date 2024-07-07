// ignore_for_file: library_private_types_in_public_api

import 'package:dmhelper/models/campaign.dart';
import 'package:flutter/material.dart';
import 'package:dmhelper/models/updater.dart';
import 'package:dmhelper/pages/campaingview.dart';
import 'package:dmhelper/pages/templates.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:provider/provider.dart';
import 'package:dmhelper/models/pallete.dart';

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
    const TemplatePage(),
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
  final newCampaingNameController = TextEditingController();

  void save() {
    if(newCampaingNameController.text.isNotEmpty) {
      campaigns.add(Campaign(name:newCampaingNameController.text, characters: []));
      newCampaingNameController.text = "";
      Provider.of<Updater>(context, listen: false).refresh();
      Navigator.pop(context);
    }
  }
  void cancel() {
    if(newCampaingNameController.text.isNotEmpty) {
      newCampaingNameController.text = "";
    } 
    Provider.of<Updater>(context, listen: false).refresh();
    Navigator.pop(context);
  }

  void goToCampaignCreation() {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Create your Campaing!",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,10,0,10),
              child: TextField(
                controller: newCampaingNameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,10.0,0,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: cancel,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppProperties.bRadius),
                          color: Colors.white,
                        ),
                        height: 50,
                        width: 60,
        
                        child: const Icon(
                            Icons.remove,
                          )
                      ),
              
                  ),
                  GestureDetector(
                    onTap: save,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppProperties.bRadius),
                          color: Colors.white,
                        ),
                        height: 50,
                        width: 60,
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
              
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 10, 0),
            child: SizedBox(
              width: AppProperties.screenWidth(context)*0.6,
              child: FittedBox(
                child: Text(
                  "My Campaigns",
                  style: TextStyle(
                    fontSize: AppProperties.screenWidth(context)*0.15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 5, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppProperties.bRadius),
                color: Colors.white
              ),
              height: AppProperties.screenHeight(context)*0.15,
              width: AppProperties.screenWidth(context)*0.15,
              child: GestureDetector(
                child: const Icon(
                  Icons.add,
                  size: 30,
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
  final int index;

  const CampaignOverviewCard({
    super.key,
    required this.title,
    required this.characters, 
    required this.index,
  });




  @override
  Widget build(BuildContext context) {
    List<Color> rotatingColorTop = [
      AppProperties.allyYellow,
      AppProperties.heroPurple,
      AppProperties.enemyRed,
    ];
    List<Color> rotatingColorFont = [
      AppProperties.enemyRedDark,
      AppProperties.allyYellow,
      AppProperties.herpPurpleDark
    ];

    return SizedBox(
      height: AppProperties.screenHeight(context)*0.5,
      child: Card(
        color: const Color.fromARGB(255, 55, 55, 55),
        margin: const EdgeInsets.fromLTRB(10,10,10,5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppProperties.cardRadius)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: rotatingColorTop[index%3],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppProperties.cardRadius),
                  topRight: Radius.circular(AppProperties.cardRadius)
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,5.0,15.0,5),
                    child: Icon(
                      Icons.door_sliding,
                      size: 40,
                      color: rotatingColorFont[index%3],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,0,15.0,0),
                    child: Text(
                      "Campaign",
                      style: TextStyle(
                        color: rotatingColorFont[index%3],
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,15.0,15.0,0),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
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
                  builder: (context) => CampaignViewPage(
                    index: index
                  ),
                ),
              );
            },
            child: CampaignOverviewCard(
              title: campaigns[index].name,
              characters: campaigns[index].characters.length,
              index: index,
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