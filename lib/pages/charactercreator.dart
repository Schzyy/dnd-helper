import 'package:flutter/material.dart';
import 'campainglist.dart';

class CharactercreatorPage extends StatelessWidget {
  const CharactercreatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          const CharacterCreatorTopBar(),
          const CharacterConfirm(),
          Container(
            margin:const EdgeInsets.fromLTRB(20, 20, 20, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 55, 55, 55)
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(5,10,0,0),
                  child: Text("Name"),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5,0,10,5),
                  child: TextField(
                    controller: nameController,
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        )
                      )
                    ),
                    style: const TextStyle(
                      color: Colors.red
                    ),
                  ),
                )
              ],
            )
          ),
          Card(),
          Card(),
        ],
      )
    );
  }
}

class CharacterCreatorTopBar extends StatefulWidget {
  const CharacterCreatorTopBar({super.key});

  @override
  State<CharacterCreatorTopBar> createState() => _CharacterCreatorTopBarState();
}

class _CharacterCreatorTopBarState extends State<CharacterCreatorTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              height: 40,
              width: 40,
              child: GestureDetector(
                child:const Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
                onTap: () {},
              ),
            )
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 10, 0),
            child: Text(
              "Create Enemy",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CharacterConfirm extends StatefulWidget {
  const CharacterConfirm({super.key});

  @override
  State<CharacterConfirm> createState() => _CharacterConfirmState();
}

class _CharacterConfirmState extends State<CharacterConfirm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 30, 0, 0),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.redAccent,
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.motion_photos_pause_rounded,
                        size: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,0,0),
                        child: Text(
                          "Enemy",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  height: 60,
                  width: 60,
                  child: GestureDetector(
                    child:const Icon(
                      Icons.add,
                      size: 40,
                    ),
                    onTap: () {},
                  ),
                )
              ),
          ),
        ],
      ),
    );
  }
}