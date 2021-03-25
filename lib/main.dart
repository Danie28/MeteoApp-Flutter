import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: "Meteo Limoges",
  //home: MeteoApp(),
  routes: {
    '/':(context) => MeteoApp(),
    '/secondpage':(context) => MeteoDemain(),
  },
  initialRoute: '/'
));


class MeteoApp extends StatefulWidget {
  @override
  _MeteoAppState createState() => _MeteoAppState();
}

class _MeteoAppState extends State<MeteoApp> {
  var name;
  var temp;
  var tmp;
  var tmps;
  var tmin, tmax;
  var pression;
  var humidite;
  var vent;
  var hprecipt;

  Future getMeteo () async{
    http.Response response = await http.get("https://api.meteo-concept.com/api/forecast/nextHours?token=52adde826f82ff814bdde735e60a01b7d4c8a49895e1f42d8ad385c7f2d320f8&insee=87085");
    http.Response respons = await http.get("https://api.meteo-concept.com/api/forecast/daily/0?token=52adde826f82ff814bdde735e60a01b7d4c8a49895e1f42d8ad385c7f2d320f8&insee=87085");
    var results = jsonDecode(response.body);
    var result = jsonDecode(respons.body);
    setState(() {
      this.name = results["city"]["name"];
      this.temp = results["forecast"][0]["temp2m"];
      this.tmp = result["forecast"]["weather"];
      this.tmin = result["forecast"]["tmin"];
      this.tmax = result["forecast"]["tmax"];
      this.pression = result['city']['altitude']*75;
      this.humidite = results["forecast"][0]["rh2m"];
      this.vent = results["forecast"][0]["wind10m"];
      this.hprecipt = results["forecast"][0]["rr10"];
      tmps = this.tmp;

      if(this.tmp == 0){
        return tmps = "Soleil";
      }
      else if(this.tmp == 1){
        return tmps = "Peu nuageux";
      }
      else if(this.tmp == 2){
        return tmps = "Ciel voilé";
      }
      else if(this.tmp == 3){
        return tmps = "Nuageux";
      }
      else if(this.tmp == 4){
        return tmps = "Très nuageux";
      }
      else if(this.tmp == 5){
        return tmps = "Couvert";
      }
      else if(this.tmp == 6){
        return tmps = "Brouillard";
      }
      else if(tmp == 7){
        return tmps = "Brouillard givrant";
      }
      else if(this.tmp == 10){
        return tmps = "Pluie faible";
      }
      else if(tmp == 11){
        return tmps = "Pluie modérée";
      }
      else if(tmp == 12){
        return tmps = "Pluie forte";
      }
      else if(tmp == 13){
        return tmps = "Pluie faible verglaçante";
      }
      else if(tmp == 14){
        return tmps = "Pluie modérée verglaçante";
      }
      else if(tmp == 15){
        return tmps = "Pluie forte verglaçante";
      }
      else if(tmp == 16){
        return tmps = "Bruine";
      }
      else if(tmp == 20){
        return tmps = "Neige faible";
      }
      else if(tmp == 21){
        return tmps = "Neige modérée";
      }
      else if(tmp == 22){
        return tmps = "Neige forte";
      }
      else if(tmp == 30){
        return tmps = "Pluie et neige mêlées faibles";
      }
      else if(tmp == 31){
        return tmps = "Pluie et neige mêlées modérées";
      }
      else if(tmp == 32){
        return tmps = "Pluie et neige mêlées fortes";
      }
      else if(tmp == 40){
        return tmps = "Averses de pluie locales et faibles";
      }
      else if(tmp == 41){
        return tmps = "Averses de pluie locales";
      }
      else if(tmp == 42){
        return tmps = "Averses locales et fortes";
      }
      else if(tmp == 43){
        return tmps = "Averses de pluie faibles";
      }
      else if(tmp == 44){
        return tmps = "Averses de pluie";
      }
      else if(tmp == 45){
        return tmps = "Averses de pluie fortes";
      }
      else if(tmp == 60){
        return tmps = "Averses de neige localisées et faibles";
      }
      else if(tmp == 61){
        return tmps = "Averses de neige localisées";
      }
      else if(tmp == 62){
        return tmps = "Averses de neige localisées et fortes";
      }
      else if(tmp == 63){
        return tmps = "Averses de neige faibles";
      }
      else if(tmp == 64){
        return tmps = "Averses de neige";
      }
      else if(tmp == 65){
        return tmps = "Averses de neige fortes";
      }
      else if(tmp == 66){
        return tmps = "Averses de neige faibles et fréquentes";
      }
      else if(tmp == 67){
        return tmps = "Averses de neige fréquentes";
      }
      else if(tmp == 70){
        return tmps = "Averses de pluie et neige mêlées localisées et faibles";
      }
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getMeteo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meteo Limoges',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width,
            //color: Colors.blue,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("Assets/bg.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  //Ajoutons un filtre noir pour rendre le texte plus lisible
                  colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    name != null ? name.toString() : "Loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Text(
                  tmps != null ? tmps.toString() : "Loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Text(
                  "Max " + tmax.toString() + "\u00B0 Min " + tmin.toString() + "\u00B0" ,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom : 15.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.compress),
                    title: Text("Pression "),
                    trailing: Text(
                        pression != null ? pression.toString() + "hpa" : "Loading"),
                  ),
                  /* ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Temps"),
                    trailing: Text("Temps"),
                  ), */
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidité"),
                    //tileColor: Colors.blue,
                    trailing: Text(humidite != null ? humidite.toString() + "%" : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Vent moyen"),
                    trailing: Text(vent != null ? vent.toString() + "km/h" : "Loading"),
                  ),
                  /* ListTile(
                    leading: FaIcon(FontAwesomeIcons.windows),
                    title: Text("Pression"),
                    trailing: Text(pre != null ? temp.toString() + "\u00B0" : "Loading",),
                  ),*/
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.windows),
                    title: Text("Precipitation"),
                    //tileColor: Colors.blue,
                    trailing: Text(hprecipt != null ? hprecipt.toString() + "mm" : "Loading",),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(
            width: 300.0,
            height: 75.0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: FlatButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MeteoDemain()));
                },
                child: Text(
                  'Previsions sous 24h',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                color: Colors.blue,
                height: 20,

              ) ,
            ),

          )
        ],
      ),
    );
  }
}


class MeteoDemain extends StatefulWidget {
  @override
  _MeteoDemainState createState() => _MeteoDemainState();
}

class _MeteoDemainState extends State<MeteoDemain> {
  var name;
  var temp;
  var tmp;
  var pres;
  var tmps;
  var tmin, tmax;
  var vent;
  var hprecipt;

  Future getMeteo () async{
    http.Response response = await http.get("https://api.meteo-concept.com/api/forecast/nextHours?token=52adde826f82ff814bdde735e60a01b7d4c8a49895e1f42d8ad385c7f2d320f8&insee=87085");
    http.Response respons = await http.get("https://api.meteo-concept.com/api/forecast/daily/1?token=52adde826f82ff814bdde735e60a01b7d4c8a49895e1f42d8ad385c7f2d320f8&insee=87085");
    var results = jsonDecode(response.body);
    var result = jsonDecode(respons.body);
    setState(() {
      this.name = results["city"]["name"];
      this.temp = results["forecast"][2]["temp2m"];
      this.tmp = result["forecast"]["weather"];
      this.tmin = result["forecast"]["tmin"];
      this.tmax = result["forecast"]["tmax"];
      this.vent = results["forecast"][2]["wind10m"];
      this.hprecipt = results["forecast"][2]["rr10"];
      tmps = this.tmp;

      if(this.tmp == 0){
        return tmps = "Soleil";
      }
      else if(this.tmp == 1){
        return tmps = "Peu nuageux";
      }
      else if(this.tmp == 2){
        return tmps = "Ciel voilé";
      }
      else if(this.tmp == 3){
        return tmps = "Nuageux";
      }
      else if(this.tmp == 4){
        return tmps = "Très nuageux";
      }
      else if(this.tmp == 5){
        return tmps = "Couvert";
      }
      else if(this.tmp == 6){
        return tmps = "Brouillard";
      }
      else if(tmp == 7){
        return tmps = "Brouillard givrant";
      }
      else if(this.tmp == 10){
        return tmps = "Pluie faible";
      }
      else if(tmp == 11){
        return tmps = "Pluie modérée";
      }
      else if(tmp == 12){
        return tmps = "Pluie forte";
      }
      else if(tmp == 13){
        return tmps = "Pluie faible verglaçante";
      }
      else if(tmp == 14){
        return tmps = "Pluie modérée verglaçante";
      }
      else if(tmp == 15){
        return tmps = "Pluie forte verglaçante";
      }
      else if(tmp == 16){
        return tmps = "Bruine";
      }
      else if(tmp == 20){
        return tmps = "Neige faible";
      }
      else if(tmp == 21){
        return tmps = "Neige modérée";
      }
      else if(tmp == 22){
        return tmps = "Neige forte";
      }
      else if(tmp == 30){
        return tmps = "Pluie et neige mêlées faibles";
      }
      else if(tmp == 31){
        return tmps = "Pluie et neige mêlées modérées";
      }
      else if(tmp == 32){
        return tmps = "Pluie et neige mêlées fortes";
      }
      else if(tmp == 40){
        return tmps = "Averses de pluie locales et faibles";
      }
      else if(tmp == 41){
        return tmps = "Averses de pluie locales";
      }
      else if(tmp == 42){
        return tmps = "Averses locales et fortes";
      }
      else if(tmp == 43){
        return tmps = "Averses de pluie faibles";
      }
      else if(tmp == 44){
        return tmps = "Averses de pluie";
      }
      else if(tmp == 45){
        return tmps = "Averses de pluie fortes";
      }
      else if(tmp == 60){
        return tmps = "Averses de neige localisées et faibles";
      }
      else if(tmp == 61){
        return tmps = "Averses de neige localisées";
      }
      else if(tmp == 62){
        return tmps = "Averses de neige localisées et fortes";
      }
      else if(tmp == 63){
        return tmps = "Averses de neige faibles";
      }
      else if(tmp == 64){
        return tmps = "Averses de neige";
      }
      else if(tmp == 65){
        return tmps = "Averses de neige fortes";
      }
      else if(tmp == 66){
        return tmps = "Averses de neige faibles et fréquentes";
      }
      else if(tmp == 67){
        return tmps = "Averses de neige fréquentes";
      }
      else if(tmp == 70){
        return tmps = "Averses de pluie et neige mêlées localisées et faibles";
      }
      else if(tmp == 210){
        return tmps = "Pluie faible intermittente";
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getMeteo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prévision Météo de demain',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            //color: Colors.blue,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("Assets/bg.WEBP"),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  //Ajoutons un filtre noir pour rendre le texte plus lisible
                  colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    name != null ? name.toString() : "Loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Text(
                  tmps != null ? tmps.toString() : "Loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Text(
                  "Max " + tmax.toString() + "\u00B0 Min " + tmin.toString() + "\u00B0" ,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom : 15.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Vent moyen"),
                    trailing: Text(vent != null ? vent.toString() + "km/h" : "Loading"),
                  ),
                  /* ListTile(
                    leading: FaIcon(FontAwesomeIcons.windows),
                    title: Text("Pression"),
                    trailing: Text(pre != null ? temp.toString() + "\u00B0" : "Loading",),
                  ),*/
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.windows),
                    title: Text("Precipitation"),
                    //tileColor: Colors.blue,
                    trailing: Text(hprecipt != null ? hprecipt.toString() + "mm" : "Loading",),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(
            width: 300.0,
            height: 75.0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: FlatButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MeteoApp()));
                },
                child: Text(
                  'Retour',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                color: Colors.blue,
                height: 20,

              ) ,
            ),

          )
        ],
      ),
    );
  }
}



