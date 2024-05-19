import 'package:flutter/material.dart';

class Campaigncreator extends StatefulWidget {
  const Campaigncreator({super.key});

  @override
  State<Campaigncreator> createState() => _CampaigncreatorState();
}

class _CampaigncreatorState extends State<Campaigncreator> {
  
  final TextEditingController _controller = TextEditingController();
  void _saveText() {
    String text = _controller.text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Saved Text'),
          content: Text(text),
          actions: <Widget> [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }, 
              child: Text("OK"),
            )
          ]
        );
      }
    );
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