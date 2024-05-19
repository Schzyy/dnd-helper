import 'package:flutter/material.dart';
import 'package:dmhelper/pages/campaigncreator.dart';

//Das ist Die Appbar auf der ersten Seite
class OverHeadMyCampaigns extends StatelessWidget {
  const OverHeadMyCampaigns({super.key});

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
          Padding(
            padding: const EdgeInsets.fromLTRB(0,30,30,0),
            child: Container(
              color: Colors.white,
              height: 50,
              width: 50,
              child: GestureDetector(
                child: const Icon(Icons.add),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Campaigncreator())
                  );
                }
              )
            ),
          )
        ],)
    );
  }
}

//Die Campaignkarte welche auf der MyCampaignseite angezeigt wird
class CampaignOverviewCard extends StatelessWidget {
  final String title;
  final List<String> characters;
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bold Text',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )
                  ),
                  Text("hello")
                ],
              ),
              Container(
                color: Colors.amber,
                height: 5
              ),
              const Text(
                'smaller Text',
                style: TextStyle(
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
          child: Container(
            height: 50,
            color: widget.templates ? Colors.blueGrey : Colors.black,
            child: GestureDetector(
              child: const Center(
                child: Text("TEMPLATES", style: TextStyle(color: Colors.white)),
              ),
              onTap: () {
                setState(() {
                  // Update state if needed
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 50,
            color: widget.templates ? Colors.black : Colors.blueGrey,
            child: GestureDetector(
              child: const Center(
                child: Text("MY CAMPAIGNS", style: TextStyle(color: Colors.white)),
              ),
              onTap: () {
                setState(() {
                  // Update state if needed
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}