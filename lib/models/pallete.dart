import 'package:dmhelper/models/mockup.dart';
import 'package:dmhelper/pages/combatparticipants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

class AppProperties {
  static const Color screenColor = Color.fromARGB(255, 0, 0, 0);
  static const Color cardColor = Color.fromARGB(255, 37, 37, 37);
  static const Color cardColor2 = Color.fromARGB(255, 67, 67, 67);
  static const Color cardColor3 = Color.fromARGB(255,123,123,123);

  static const Color enemyRed = Color.fromARGB(255, 223, 54, 77);
  static const Color enemyRedDark = Color.fromARGB(255, 124, 21, 35);

  static const Color allyYellow = Color.fromARGB(255, 225, 173, 39);
  static const Color allyYellowDark = Color.fromARGB(255, 135, 107, 35);

  static const Color heroPurple = Color.fromARGB(255, 132, 91, 245);
  static const Color herpPurpleDark = Color.fromARGB(255, 73, 39, 160);

  static double cardRadius = 20.0;
  static double bRadius = 20;
  
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}

class HelperFunctions {
  static void showParticipants(BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.fromLTRB(17.5, 30, 12.5, 30),
          padding: EdgeInsets.all(12.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppProperties.bRadius),
            color: AppProperties.cardColor
          ),
          child: Column(
            children: [
              Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                  'lib/assets/combatIcon.svg',
                  height: 24,
                 ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(5,0,0,0),
                  child: Text(
                    "PARTICIPANTS",
                    style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Icon(FontAwesomeIcons.x,
                            color: Colors.white, 
                            size: 30,
                            ),
                      ),
                    ),
                  ),
                ],
              ),  
            ],
          ),
        ),
              Expanded(
                child: Participant(),
              ),
            ],
          )
        );
      },
    );
  }
  static void cancelCombat(BuildContext context, int howFar) {
    showDialog(context: 
    context, 
    builder: (context) => AlertDialog(
      backgroundColor: AppProperties.cardColor2,
      content: Container(
        height: 180,
        width: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppProperties.bRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.center,
              height: 100,
              width: 220,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 45),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      maxLines: 2,
                      "Do you want to end the combat?",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 230,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      combat.partake.clear();
                      combat.heroes.clear();
                      combat.opponentes.clear();
                      for(int i = 0; i < howFar; i++) {
                        Navigator.pop(context);
                      }
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 50, 0),
                      width: 115,
                      decoration: const BoxDecoration(
                        color: AppProperties.cardColor2
                      ),
                      child: const Text(
                        "yes",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 20, 0),
                      width: 115,
                      decoration: const BoxDecoration(
                        color: AppProperties.cardColor2
                      ),
                      child: const Text(
                        "no",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
      )
    );
  }
}
