import 'package:dmhelper/pages/templates.dart';
import 'package:flutter/material.dart';
import '/models/mockup.dart';
import 'pages/campaigncreator.dart';

//Startpage
//Appbar mit add funktion um auf eine seperate Seite zu kommen um Campagnes zu erstellen
//Mainfunktion ist die Campaignliste
//Bottombar zum navigieren zwischen Template und Campaigns

void main() {
  runApp(const CampaignStart());
}

class CampaignStart extends StatelessWidget {
  const CampaignStart({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CampaignSelector(),
    );
  }
}

class CampaignSelector extends StatelessWidget {
  const CampaignSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
        body: Column(
          children: [
            TopbarCampaings(),
            Expanded(
              child: Campaingslist(),
            ),
            NavBarMyCampaignsTemplate(
              templates: false,
              )
          ],
    ));
  }
}

class TopbarCampaings extends StatefulWidget {
  const TopbarCampaings({super.key});

  @override
  State<TopbarCampaings> createState() => _TopbarCampaingsState();
}

class _TopbarCampaingsState extends State<TopbarCampaings> {
  void goToCampaingCreation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Campaigncreator())
    );
    if(result != null) {
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15,10,15,30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10,30,10,0),
            child: Text(
              "My Campaigns",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              goToCampaingCreation();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Container(
                height: 50,
                width: 50,
                color: Colors.white,
                child: const Icon(Icons.add)
              ),
            ),
            ),
        ],)
    );
  }
}



class CampaignOverviewCard extends StatelessWidget {
  final String title;
  final int characters;
  const CampaignOverviewCard({super.key, required this.title, required this.characters});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )
                  ),
                ],
              ),
              Container(
                color: Colors.amber,
                height: 5
              ),
              Text(
                'Heroes: $characters',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                )
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.check_circle, color: Colors.blue),
                  SizedBox(height: 5),
                ],
              ),
            const SizedBox(height: 10),
            ],
          )
        )
      ),
    );
  }
}

class Campaingslist extends StatefulWidget {
  const Campaingslist({super.key});

  @override
  State<Campaingslist> createState() => _ReloadState();
}

class _ReloadState extends State<Campaingslist> {
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
 // Assuming TemplatePage is defined in template_page.dart

class NavBarMyCampaignsTemplate extends StatefulWidget {
  final bool templates;

  const NavBarMyCampaignsTemplate({super.key, required this.templates});

  @override
  State<NavBarMyCampaignsTemplate> createState() => _NavBarMyCampaignsTemplateState();
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
                MaterialPageRoute(builder: (context) => const TemplatePage()),
              );
            },
            child: Container(
              height: 50,
              color: widget.templates ? Colors.blueGrey : Colors.black,
              child: const Center(
                child: Text("TEMPLATES", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
              });
            },
            child: Container(
              height: 50,
              color: widget.templates ? Colors.black : Colors.blueGrey,
              child: const Center(
                child: Text("MY CAMPAIGNS", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
//CampaignOverviewCard(title: "hello", characters: ["a","b"])