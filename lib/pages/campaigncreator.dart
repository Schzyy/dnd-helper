import 'package:flutter/material.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/models/campaign.dart';
import 'dart:developer';

class Campaigncreator extends StatefulWidget {
  const Campaigncreator({super.key});

  @override
  State<Campaigncreator> createState() => _CampaigncreatorState();
}

class _CampaigncreatorState extends State<Campaigncreator> {
  
  final TextEditingController _controller = TextEditingController();
  void _saveText() {
    String text = _controller.text;
    addCampaing(text);
    Navigator.pop(context);
  }

  void addCampaing(String name) {
    name = _controller.text;
    campaigns.add(Campaign(name:name, characters: []));
  }
  void disposeTextEditingController() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Container(
            color: Colors.grey[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0,0,0,20),
                  child: Text(
                    "Create a Campaing",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Insert your Campaignname'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ElevatedButton(
                    onPressed: _saveText, 
                    child: const Text("Save"),
                  )
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

class CampaignName extends StatefulWidget {
  const CampaignName({super.key});

  @override
  State<CampaignName> createState() => _CampaignNameState();
}

class _CampaignNameState extends State<CampaignName> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}