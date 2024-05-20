import 'package:flutter/material.dart';
import 'package:dmhelper/models/campaign.dart';


class CharactercreatorPage extends StatelessWidget {
  const CharactercreatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            TextFormField(
              
            ),
            TextFormField(

            )
          ],
        ),
      )
    );
  }
}

class CharacterCreator extends StatefulWidget {
  const CharacterCreator({super.key});

  @override
  State<CharacterCreator> createState() => _CharacterCreatorState();
}

class _CharacterCreatorState extends State<CharacterCreator> {
  late final Character createCharacter;
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Character Creation!"),
      ],
    );
  }
}

class CharacterFields extends StatefulWidget {
  
  final String desc;
  final Character char;
  const CharacterFields({super.key, required this.desc, required this.char});

  @override
  State<CharacterFields> createState() => _CharacterFieldsState();
}
class _CharacterFieldsState extends State<CharacterFields> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.desc),
        TextField(

        )
      ],
    );
  }
}