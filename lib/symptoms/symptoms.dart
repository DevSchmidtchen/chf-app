import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:herzinsuffizienz/symptoms/weeklyquestsymptoms.dart';

class Symptoms extends StatelessWidget {
  final String _title = "Symptome";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w800,
            fontFamily: "Arial",
          ),
        ),
        backgroundColor: Colors.lightGreen[500],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 15),
          Card(
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                    image: AssetImage('assets/Neuseeland_Panorama.JPG'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: InkWell(
                  splashColor: Colors.lightGreen[200],
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=> WeeklyQuestSymptoms())
                    );
                  },
                  child:
                  ListTile(
                    title: Text("Fragebogen: Symptome",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22.0,
                      ),),
                    subtitle: Text("Bitte machen Sie in diesem Fragebogen einmal alle 2 Wochen Angaben zu Ihren Symptomen!",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        color: Colors.black,
                      ),),
                  ),
                ),
              )
          ),
          Card(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: AssetImage('assets/Neuseeland_Steine.png'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
            child: InkWell(
              splashColor: Colors.lightGreen[200],
              onTap: (){

              },
              child:
              ListTile(
              title: Text("Fragebogen: Gesundheit",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontFamily: "Roboto",
                  fontSize: 22.0,
                ),),
              subtitle: Text("Bitte machen Sie in deisem Fragebogen einmal alle 2 Wochen Angaben zu psychischen Gesundheit!",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto",
                  fontSize: 16.0,
                  color: Colors.black,
                ),),
            ),
            ),
            )
          ),

          ]
      ),
    );
  }
}