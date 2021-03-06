import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herzinsuffizienz/faq/faq.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ConnectionCode extends StatelessWidget {
  final String _title = "Visitencode";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fragezeichen unten rechts, bewegt sich bei scrollen mit
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.lightGreen[500],
            tooltip:'Increment',
            child:
            Icon(Icons.help_outline,size: 50,),
            onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=> FAQ()));} //Bei Klick wechsel zu FAQ
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar( //Kopfzeile mit Titel
        title: Text(_title
        ),
        backgroundColor: Colors.lightGreen[500],
      ),
      body: ListView (
        children:<Widget> [
          Column(
        children: <Widget> [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text("Bitte zeigen Sie Ihrem behandelnden Arzt den unten stehenden QR-Code oder nennen Sie ihm die unten stehende Webadresse. Mit dem Scan des Codes erlauben Sie den Zugriff auf Ihre persönlichen Gesundheitsdaten."),
          ),
      Center(
          child:
              Column( children: <Widget> [
          Container(
        padding: EdgeInsets.all(10.0),
        child: QrImage( //QR-Code mit verlinkter Internetseite (kann beliegig angepasst werden)
        data: "https://www.figma.com/proto/6gqEgzGl8CyR9CjCn1NpWE/Untitled?node-id=30%3A20&scaling=min-zoom", //Aktuell beispielhaft mit Webseite verbunden.
        version: QrVersions.auto,
      ),
      ),
                Container(
                  padding:EdgeInsets.all(10.0),
                  child:
                      Card(
                        child:
                            ListTile (
                            title: Text("Web-Adresse:") ,
                            subtitle: Text("https://www.figma.com/proto/6gqEgzGl8CyR9CjCn1NpWE/Untitled?node-id=30%3A20&scaling=min-zoom "),
    )
                ))
              ]))])])
    );
  }
}
