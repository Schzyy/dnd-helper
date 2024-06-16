import 'package:dmhelper/models/updater.dart';
import 'package:dmhelper/pages/charactercreator.dart';
import 'package:flutter/material.dart';
import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/pages/characterview.dart';
import 'package:provider/provider.dart';

class TemplatePage extends StatelessWidget {
  TemplatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
        children: [
          TopbarTemplates(),
          Expanded(
            child: TemplatesDisplay(),
          ),
        ],
    );
  }
}

class TopbarTemplates extends StatefulWidget {
  const TopbarTemplates({super.key});

  @override
  State<TopbarTemplates> createState() => _TopbarTemplatesState();
}

class _TopbarTemplatesState extends State<TopbarTemplates> {
  void _navigateAndRefresh(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CharactercreatorPage(template: true, index: 0)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              "My Characters",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 15, 0),
            child: Container(
              color: Colors.white,
              height: 50,
              width: 50,
              child: GestureDetector(
                child: const Icon(Icons.add),
                onTap: () {
                  _navigateAndRefresh(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TemplateCard extends StatelessWidget {
  final String name;
  final String rasse;
  final String characterclass;

  const TemplateCard({
    super.key,
    required this.name,
    required this.rasse,
    required this.characterclass,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
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
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.amber,
                height: 5,
              ),
              Text(
                'Race: $rasse',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Class: $characterclass',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
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
          ),
        ),
      ),
    );
  }
}

class TemplatesDisplay extends StatefulWidget {
  const TemplatesDisplay({super.key});

  @override
  State<TemplatesDisplay> createState() => _TemplatesDisplayState();
}

class _TemplatesDisplayState extends State<TemplatesDisplay> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Updater>(builder: (context, value, child) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        primary: false,
        itemCount: chars.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CharacterPage(char: chars[index]))),
            child: TemplateCard(
              name: chars[index].name,
              rasse: chars[index].race,
              characterclass: chars[index].characterclass,
            ),
          );
        },
      );
    });
  }
}

/*class NavBarTemplates extends StatefulWidget {
  final bool templates;

  const NavBarTemplates({super.key, required this.templates});

  @override
  State<NavBarTemplates> createState() => _NavBarMyTemplateState();
}

class _NavBarMyTemplateState extends State<NavBarTemplates> {
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
              onTap: () {},
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
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}*/