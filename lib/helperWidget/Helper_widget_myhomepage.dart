import 'package:aq/QuranData/Data.dart';
import 'package:flutter/material.dart';
import 'package:aq/ShowContant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Costam_card extends StatefulWidget {
  final String title;
  final int index;
  final int sura____index;

  Costam_card({this.title, this.index, int this.sura____index});

  @override
  Costam_cardState createState() {
    return new Costam_cardState();
  }
}

class Costam_cardState extends State<Costam_card> {
  @override
  Widget build(BuildContext context) {
    stars(index) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.getStringList('stars').contains('$index')) {
        return true;
      } else {
        return false;
      }
    }

    setstars(int index) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!prefs.getStringList('stars').contains('$index')) {
        // add stars
        String newValue = '$index';
        List<String> oldStars = prefs.getStringList('stars');
        oldStars.add(newValue);
        List<String> stars = oldStars;
        prefs.setStringList('stars', stars);
        setState(() {});
      } else {
        // remove stars
        String newValue = '$index';
        List<String> oldStars = prefs.getStringList('stars');
        oldStars.remove(newValue);
        List<String> stars = oldStars;
        prefs.setStringList('stars', stars);
        setState(() {});
      }
    }

    Future getTheme() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var lang = prefs.getString('ThemeDark');

      lang = lang.runtimeType == Null ? 'false' : lang;
      return lang;
    }

    return FutureBuilder(
      future: getTheme(),
      builder: (BuildContext context, AsyncSnapshot darktheme) {
        return Center(
          child: InkWell(
            onTap: () {
              print(widget.index);
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return Showcontant(
                    index: widget.index - 1,
                    sura____index: widget.sura____index);
              }));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setstars(widget.index);
                  },
                  child: Container(
                    child: FutureBuilder(
                      future: stars(widget.index),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return Icon(
                          Icons.star,
                          color: snapshot.data == true
                              ? Colors.green
                              : Colors.grey,
                        );
                      },
                    ),
                    width: MediaQuery.of(context).size.width * .25,
                    height: 50,
                  ),
                ),
                Card(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            stops: [0.0, 1.0],
                            end: Alignment(0.8,
                                0.0), // 10% of the width, so there are ten blinds.
                            colors: darktheme.data == 'false'
                                ? [
                                    const Color(0xFFADD98D),
                                    const Color(0xFF88C759)
                                  ]
                                : [
                                    Color(0xff6C8559),
                                    Color(0xff699845),
                                  ], // whitish to gray
                            tileMode: TileMode
                                .clamp, // repeats the gradient over the canvas
                          ),
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width * .7,
                        padding: EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Stack(
                                fit: StackFit.loose,
                                // alignment:AlignmentDirectional. ,
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Positioned(
                                      left: -35,
                                      top: -5,
                                      child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: Color(0xff707070)
                                                    .withOpacity(.06)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(.1))
                                            ],
                                          ),
                                          child: ClipOval(
                                            child: Image(
                                              fit: BoxFit.scaleDown,
                                              image: (sure_type[widget
                                                          .sura____index] ==
                                                      1)
                                                  ? AssetImage('assets/1.png')
                                                  : AssetImage(
                                                      'assets/2.png',
                                                    ),
                                            ),
                                          ))),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    widget.title,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: darktheme.data == 'true'
                                            ? Colors.white
                                            : Color(0xff4E4E4E)),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
