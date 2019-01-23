import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aq/Myhome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/time.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Intro(),
    );
  }
}

//  new MyHomePage()
class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

Future setlang(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getString('lang').runtimeType != Null) {
    RestartableTimer _timer =
        new RestartableTimer(new Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return MyHomePage();
      }));
    });
  } else {
    prefs.setStringList('note_aya', []);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return SetLang();
    }));
  }
}

class SetLang extends StatefulWidget {
  @override
  _SetLangState createState() => _SetLangState();
}

List langs = [
  'English',
  'Arabic',
  'French',
  'Hindi',
  'Filipino',
  'Urdu',
  'Spanish'
];
int selected = 0;

class _SetLangState extends State<SetLang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg-one.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height * .1),
              child: Text(
                'Choose your language',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 300,
                child: Choose_lang_widget(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () async {
          List shortcutlang = ['en', 'ar', 'fr', 'hi', 'id', 'ur', 'es'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('lang', shortcutlang[selected]).then((d) {
            prefs.setString('read_mood', 'true').then((s) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return MyHomePage();
              }));
            });
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class Choose_lang_widget extends StatefulWidget {
  @override
  _Choose_lang_widgetState createState() => _Choose_lang_widgetState();
}

class _Choose_lang_widgetState extends State<Choose_lang_widget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      backgroundColor: Colors.green.withOpacity(0),
      children: langs.map((d) {
        return Container(
          margin: EdgeInsets.all(5),
          child: Center(
            child: Text('$d',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                )),
          ),
        );
      }).toList(),
      itemExtent: 120.0,
      onSelectedItemChanged: (int value) {
        selected = value;
      },
    );
  }
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    setlang(context);
    return Center(
      child: Image.asset('assets/logo_.jpg'),
    );
  }
}
