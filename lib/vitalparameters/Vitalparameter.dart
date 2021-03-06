import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:herzinsuffizienz/faq/faq.dart';
import 'package:herzinsuffizienz/vitalparameters/activeEnergy.dart';
import 'package:herzinsuffizienz/vitalparameters/bodyfat.dart';
import 'package:herzinsuffizienz/vitalparameters/bpm.dart';
import 'package:herzinsuffizienz/vitalparameters/createSparkline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:herzinsuffizienz/vitalparameters/steps.dart';
import 'package:herzinsuffizienz/vitalparameters/weight.dart';
//Übersichtsseite zu Vitalparametern -> viele Karten mit einzelnen Diagrammen zu den Vitalparametern
class Vitalparameter extends StatefulWidget {
  @override
  _VitalparameterState createState() => _VitalparameterState();
}

class _VitalparameterState extends State<Vitalparameter> {
  final String _title = "Vitalparameter";
  var _healthDataList = List<HealthDataPoint>();
  bool _isAuthorized = false;
  //Einzelne Listen für jeden abgefragten Vitalparametertyp
  List<double> weight = List<double>();
  List<double> height = List<double>();
  List<double> steps = List<double>();
  List<double> bmi = List<double>();
  List<double> bodyFat = List<double>();
  List<double> activeEnergy = List<double>();
  List<double> _bpm = List<double>();
  List<double> bpSystolic = List<double>();
  List<double> bpDiastolic = List<double>();
  List<double> restingHR = List<double>();
  List<double> glucose = List<double>();
  List<double> oxygen = List<double>();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    DateTime startDate =
        DateTime.utc(2020, DateTime.now().month - 1, DateTime.now().day); //Zeitraum für Abfrage = 1 Monat
    DateTime endDate = DateTime.now();

    Future.delayed(Duration(seconds: 2), () async {
      _isAuthorized = await Health.requestAuthorization(); //Autorisierungsabfrage
      if (_isAuthorized) {
        List<HealthDataType> types = [
          HealthDataType.WEIGHT,
          HealthDataType.HEIGHT,
          HealthDataType.STEPS,
          HealthDataType.BODY_MASS_INDEX,
          HealthDataType.BODY_FAT_PERCENTAGE,
          HealthDataType.ACTIVE_ENERGY_BURNED,
          HealthDataType.HEART_RATE,
          HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
          HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
          HealthDataType.RESTING_HEART_RATE,
          HealthDataType.BLOOD_GLUCOSE,
          HealthDataType.BLOOD_OXYGEN,
        ];
        //Speicherung aller Datenpunkte in Liste
        for (HealthDataType type in types) {
          try {
            if (Health.isDataTypeAvailable(type)) {
              List<HealthDataPoint> healthData =
                  await Health.getHealthDataFromType(startDate, endDate, type);
              _healthDataList.addAll(healthData);
            }
          } catch (exception) {
            print(exception.toString());
          }
        }
        setState(() {});
      } else {
        print("Keine Authorisierung vorliegend");
      }
//Befüllen der einzelnen Listen je Datentyp mit Double-Werten
      for (HealthDataPoint point in _healthDataList) {
        switch (point.dataType) {
          case "WEIGHT":
            {
              weight.add(point.value);
            }
            break;
          case "HEIGHT":
            {
              height.add(point.value);
            }
            break;
          case "STEPS":
            {
              steps.add(point.value.toDouble());
            }
            break;
          case "BODY_MASS_INDEX":
            {
              bmi.add(point.value);
              print(bmi);
            }
            break;
          case "BODY_FAT_PERCENTAGE":
            {
              bodyFat.add(point.value);
            }
            break;
          case "ACTIVE_ENERGY_BURNED":
            {
              activeEnergy.add(point.value.toDouble());
            }
            break;
          case "HEART_RATE":
            {
              _bpm.add(point.value.toDouble());
            }
            break;
          case "BLOOD_PRESSURE_SYSTOLIC":
            {
              bpSystolic.add(point.value);
            }
            break;
          case "BLOOD_PRESSURE_DIASTOLIC":
            {
              bpDiastolic.add(point.value);
            }
            break;
          case "RESTING_HEART_RATE":
            {
              restingHR.add(point.value.toDouble());
            }
            break;
          case "BLOOD_GLUCOSE":
            {
              glucose.add(point.value);
            }
            break;
          case "BLOOD_OXYGEN":
            {
              oxygen.add(point.value);
            }
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //FAQ-Button unten rechts
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreen[500],
          tooltip:'Increment',
          child:
          Icon(Icons.help_outline,size: 50,),
          onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=> FAQ()));}
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar( //Kopfzeile mit Titel
        title: Text(
          _title
        ),
        backgroundColor: Colors.lightGreen[500],
      ),
      body:(_bpm.isEmpty && weight.isEmpty && steps.isEmpty && activeEnergy.isEmpty && bodyFat.isEmpty) ? Center(child: Container(
          child: SpinKitPumpingHeart(color: Colors.red[300], size: 100,))) :
      //Body der Seite: pro Vitalparameter eine Karte mit Diagramm über Werte des letzten Monats-> bei Klick auf Karte wechsel zu Detailansicht des jeweiligen Typs
      //LAden die Daten noch oder sind keine daten verfügbar wird ein Ladebildschirm angezeigt
      Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              InkWell(
                splashColor: Colors.lightGreen[100],
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BPM()));
                },
                child: Card(
                  shadowColor: Colors.grey,
                  child: Column(children: <Widget>[
                    ListTile(
                      //leading: Icon(Icons.trending_up),
                      title: Text('Herzfrequenz (bpm)'),
                      subtitle: Text("letzte Messung: " +
                          (_bpm.isEmpty ? " " : _bpm.last.round().toString())),
                    ),
                    _bpm.isEmpty
                        ? Container(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: SpinKitWave(color: Theme.of(context).accentColor))
                        : CreateSparkline(
                      data: _bpm,
                    ),
                  ]),
                ),
              ),
              InkWell(
                splashColor: Colors.lightGreen[100],
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Weight()));
                },
                child: Card(
                  shadowColor: Colors.grey,
                  child: Column(children: <Widget>[
                    ListTile(
                      //leading: Icon(Icons.trending_up),
                      title: Text('Gewicht (kg)'),
                      subtitle: Text("letzte Messung: " +
                          (weight.isEmpty
                              ? " "
                              : weight.last.toStringAsFixed(2))),
                    ),
                    weight.isEmpty
                        ? Container(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child:SpinKitWave(color: Theme.of(context).accentColor))
                        : CreateSparkline(
                      data: weight,
                    ),
                  ]),
                ),
              ),
              InkWell(
                splashColor: Colors.lightGreen[100],
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Steps()));
                },
                child: Card(
                  shadowColor: Colors.grey,
                  child: Column(children: <Widget>[
                    ListTile(
                      title: Text('Schritte'),
                      subtitle: Text("letzte Messung: " +
                          (steps.isEmpty ? " " : steps.last.round().toString())),
                    ),
                    steps.isEmpty
                        ? Container(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: SpinKitWave(color: Theme.of(context).accentColor))
                        : CreateSparkline(data: steps),
                  ]),
                ),
              ),
              InkWell(
                splashColor: Colors.lightGreen[100],
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ActiveEnergy()));
                },
                child: Card(
                  shadowColor: Colors.grey,
                  child: Column(children: <Widget>[
                    ListTile(
                      //leading: Icon(Icons.trending_up),
                      title: Text('Aktivitätskalorien'),
                      subtitle: Text("letzte Messung: " +
                          (activeEnergy.isEmpty
                              ? " "
                              : activeEnergy.last.round().toString())),
                    ),
                    activeEnergy.isEmpty
                        ? Container(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: SpinKitWave(color: Theme.of(context).accentColor))
                        : CreateSparkline(
                      data: activeEnergy,
                    ),
                  ]),
                ),
              ),
              InkWell(
                splashColor: Colors.lightGreen[100],
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Bodyfat()));
                },
                child: Card(
                  shadowColor: Colors.grey,
                  child: Column(children: <Widget>[
                    ListTile(
                      //leading: Icon(Icons.trending_up),
                      title: Text('Körperfett'),
                      subtitle: Text("letzte Messung: " +
                          (bodyFat.isEmpty
                              ? " "
                              : bodyFat.last.round().toString())),
                    ),
                    bodyFat.isEmpty
                        ? Container(
                        padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                        child: SpinKitWave(color: Theme.of(context).accentColor))
                        : CreateSparkline(
                      data: bodyFat,
                    ),
                  ]),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
