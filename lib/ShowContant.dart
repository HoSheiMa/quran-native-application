import 'package:aq/Myhome.dart';
import 'package:aq/QuranData/Data.dart';
import 'package:aq/main.dart';
import 'package:flutter/material.dart';
import 'package:aq/Contant.dart';
import 'package:aq/aq.simple.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:launch_review/launch_review.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'QuranData/Data.dart';

class Showcontant extends StatefulWidget {
  final int index;
  final int sura____index;
  Showcontant({this.index, this.sura____index});
  @override
  _ShowcontantState createState() => _ShowcontantState();
}

class _ShowcontantState extends State<Showcontant>
    with TickerProviderStateMixin {
  AnimationController an_c;
  AnimationController scale_size;

  int focas_index;
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: quran_imgs.length, vsync: this);
    // for start from 0 to 114
    _tabController.animateTo(widget.index);
    // _tabController.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    an_c.dispose();
    super.dispose();
  }

  Future getapplang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var lang = prefs.getString('lang');
    return lang;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    Future getTheme() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var lang = prefs.getString('ThemeDark');

      lang = lang.runtimeType == Null ? 'false' : lang;
      return lang;
    }

    Future getdark() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var lang = prefs.getString('dark');

      lang = lang.runtimeType == Null ? 'false' : lang;
      return lang;
    }

    // Future setTheme(String state) async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   Navigator.pop(_scaffoldKey.currentState.context);
    //   setState(() {
    //     prefs.setString('ThemeDark', state);
    //   });
    // }
    Future setTheme(String state) async {
      String state_ = state;
      if (state == 'dark') state_ = 'true';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Navigator.pop(_scaffoldKey.currentState.context);
      setState(() {
        if (state == 'dark') {
          prefs.setString('dark', 'true');
          print('1');
        } else {
          print('2');

          prefs.setString('dark', 'false');
        }
        prefs.setString('ThemeDark', state_);
        print(state_);
      });
    }

    return Scaffold(
      
      resizeToAvoidBottomPadding: false,
      // appBar: AppBar(
      //   leading: InkWell(
      //       onTap: () {
      //         Navigator.pop(context);
      //       },
      //       child: Icon(Icons.arrow_back)),
      //   title: Center(
      //       child: AutoSizeText(
      //     aq['quran']['sura'][_tabController.index]['name'],
      //     stepGranularity: 10.0,
      //     // maxLines: 4,
      //     overflow: TextOverflow.ellipsis,
      //   )),
      // ),
      floatingActionButton: FutureBuilder(
        future: getapplang(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) return Container();
          var focus_lang = snapshot.data;
          return SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(size: 22.0),
            // this is ignored if animatedIcon is non null
            // child: Icon(Icons.add),
            visible: true,
            curve: Curves.bounceIn,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            onOpen: () {},
            onClose: () {},
            tooltip: 'Speed Dial',
            heroTag: 'speed-dial-hero-tag',
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 8.0,
            shape: CircleBorder(),
            children: [
              SpeedDialChild(
                  child: Icon(Icons.settings),
                  backgroundColor: Colors.blueGrey,
                  label: focus_lang == 'en'
                      ? 'setting'
                      : focus_lang == 'ar'
                          ? 'ضبط '
                          : focus_lang == 'id'
                              ? 'pengaturan'
                              : focus_lang == 'fr'
                                  ? 'réglage'
                                  : focus_lang == 'es'
                                      ? 'agordo '
                                      : focus_lang == 'ur'
                                          ? 'ترتیب دیں'
                                          : 'सेटिंग',
                  // labelStyle: TextTheme(fontSize: 18.0),
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  }),
              SpeedDialChild(
                  child: Icon(Icons.book),
                  backgroundColor: Colors.green,
                  label: focus_lang == 'en'
                      ? 'index'
                      : focus_lang == 'ar'
                          ? 'فهرس '
                          : focus_lang == 'id'
                              ? 'Indeks'
                              : focus_lang == 'fr'
                                  ? 'Index'
                                  : focus_lang == 'es'
                                      ? 'Indekso'
                                      : focus_lang == 'ur' ? 'انڈیکس' : 'सूची',
                  // labelStyle: TextTheme(fontSize: 18.0),
                  onTap: () {
                    _scaffoldKey.currentState.openEndDrawer();
                  }),
              SpeedDialChild(
                child: Icon(Icons.library_books),
                backgroundColor: Colors.blue,
                label: focus_lang == 'en'
                    ? 'Read / interpret'
                    : focus_lang == 'ar'
                        ? 'قراءة /تفسير'
                        : focus_lang == 'id'
                            ? 'Baca / interpretasikan'
                            : focus_lang == 'fr'
                                ? 'Lire / interpréter'
                                : focus_lang == 'es'
                                    ? 'Legu / interpreti'
                                    : focus_lang == 'ur'
                                        ? 'پڑھنے / تشریح'
                                        : 'पढ़ें / व्याख्या',
                // labelStyle: TextTheme(fontSize: 18.0),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  if (prefs.getString('read_mood') == "false") {
                    prefs.setString('read_mood', 'true');
                    print('read_mood true');
                  } else {
                    prefs.setString('read_mood', 'false');
                    print('read_mood false');
                  }

                  setState(() {});
                },
              ),
              SpeedDialChild(
                child: Icon(Icons.bookmark),
                backgroundColor: Colors.red,
                label: focus_lang == 'en'
                    ? 'Go to bookmarked'
                    : focus_lang == 'ar'
                        ? 'انتقل إلى إشارة مرجعية '
                        : focus_lang == 'id'
                            ? 'Buka bookmark'
                            : focus_lang == 'fr'
                                ? 'Aller aux favoris'
                                : focus_lang == 'es'
                                    ? 'Iru al legosigno'
                                    : focus_lang == 'ur'
                                        ? 'بک مارک پر جائیں'
                                        : 'बुकमार्क करने के लिए जाओ',
                // labelStyle: TextTheme(fontSize: 18.0),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var bookmark = prefs.getString('bookmark');

                  if (bookmark.runtimeType != Null && bookmark.isNotEmpty) {
                    // print(bookmark);
                    List bookmarkjson = jsonDecode(bookmark);
                    var s = bookmarkjson[0];
                    var a = bookmarkjson[1];
                    int p = int.parse(bookmarkjson[2]);

                    _tabController.animateTo(p - 1);
                  } else {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6)),
                            child: AlertDialog(
                              title: Text(
                                focus_lang == 'en'
                                    ? 'No bookmarked'
                                    : focus_lang == 'ar'
                                        ? 'لا إشارة مرجعية '
                                        : focus_lang == 'id'
                                            ? 'Tidak ada bookmark'
                                            : focus_lang == 'fr'
                                                ? 'Pas de marque page'
                                                : focus_lang == 'es'
                                                    ? 'Neniu markita'
                                                    : focus_lang == 'ur'
                                                        ? 'بک مارک نہیں'
                                                        : 'कोई बुकमार्क नहीं किया गया',
                              ),
                              actions: <Widget>[
                                new FlatButton(
                                  child: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                  },
                                )
                              ],
                            ),
                          );
                        });
                  }
                },
              ),
            ],
          );
        },
      ),
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(
              padding: EdgeInsets.zero,
              children: aq['quran']['sura'].map((item) {
                int index = tabpagenum[int.parse(item['index']) - 1];

                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(item['name']),
                    ],
                  ),
                  onTap: () {
                    print(int.parse(item['index']) - 1);
                    int animtevalue = index - 1;
                    print(animtevalue);
                    _tabController.animateTo(animtevalue);
                  },
                );
              }).toList()),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/logo_.jpg'),
              ),
            ),
            ListTile(
              title: FutureBuilder(
                future: getapplang(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData == false) return Container();
                  var focus_lang = snapshot.data;
                  return Text(focus_lang == 'en'
                      ? 'Night lighting'
                      : focus_lang == 'ar'
                          ? 'اضاءة ليلية'
                          : focus_lang == 'id'
                              ? 'Pencahayaan malam'
                              : focus_lang == 'fr'
                                  ? 'Éclairage de nuit'
                                  : focus_lang == 'es'
                                      ? 'Nokta lumigado'
                                      : focus_lang == 'ur'
                                          ? 'رات کی روشنی'
                                          : 'रात्रि प्रकाश');
                },
              ),
              trailing: FutureBuilder(
                future: getTheme(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData == false) return Container();

                  return FutureBuilder(
                    future: getdark(),
                    builder: (BuildContext context, AsyncSnapshot dark) {
                      if (dark.hasData == false) return Container();

                      return FutureBuilder(
                        future: getapplang(),
                        builder: (BuildContext context, AsyncSnapshot lang) {
                          if (lang.hasData == false) return Container();
                          var focus_lang = lang.data;
                          var lightText = Text(focus_lang == 'en'
                              ? 'Light'
                              : focus_lang == 'ar'
                                  ? 'فاتح'
                                  : focus_lang == 'id'
                                      ? 'Ringan'
                                      : focus_lang == 'fr'
                                          ? 'Lumière'
                                          : focus_lang == 'es'
                                              ? 'Lumo'
                                              : focus_lang == 'ur'
                                                  ? 'روشنی'
                                                  : 'प्रकाश');
                          var smoothlight = Text(focus_lang == 'en'
                              ? 'Smooth light'
                              : focus_lang == 'ar'
                                  ? 'ضوء على نحو سلس'
                                  : focus_lang == 'id'
                                      ? 'Cahaya yang halus'
                                      : focus_lang == 'fr'
                                          ? 'Lumière douce'
                                          : focus_lang == 'es'
                                              ? 'Glata lumo'
                                              : focus_lang == 'ur'
                                                  ? 'ہموار روشنی'
                                                  : 'चिकना प्रकाश');

                          var darkth = Text(focus_lang == 'en'
                              ? 'Dark'
                              : focus_lang == 'ar'
                                  ? 'داكن'
                                  : focus_lang == 'id'
                                      ? 'Gelap'
                                      : focus_lang == 'fr'
                                          ? 'Foncée'
                                          : focus_lang == 'es'
                                              ? 'Malluma'
                                              : focus_lang == 'ur'
                                                  ? 'اندھیرے'
                                                  : 'अंधेरा');
                          return DropdownButton(
                            elevation: 0,
                            hint: (snapshot.data == 'false')
                                ? lightText
                                : (dark.data == 'false') ? smoothlight : darkth,
                            items: <DropdownMenuItem>[
                              DropdownMenuItem(
                                child: lightText,
                                value: 'false',
                              ),
                              DropdownMenuItem(
                                child: smoothlight,
                                value: 'true',
                              ),
                              DropdownMenuItem(
                                child: darkth,
                                value: 'dark',
                              )
                            ],
                            onChanged: (value) {
                              if (value == 'false') {
                                setTheme('false');
                              } else {
                                if (value == 'true') {
                                  setTheme('true');
                                } else {
                                  setTheme('dark');
                                }
                              }
                            },
                          );
                        },
                      );
                    },
                  );

                  //  Switch(
                  //   onChanged: (bool value) {
                  //     print(value);
                  //     if (value == true) {
                  //       setTheme('true');
                  //     } else {
                  //       setTheme('false');
                  //     }
                  //   },
                  //   value: (snapshot.data == 'false') ? false : true,
                  // );
                },
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: FutureBuilder(
                future: getapplang(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData == false) return Container();
                  var focus_lang = snapshot.data;
                  return Text(focus_lang == 'en'
                      ? 'review application'
                      : focus_lang == 'ar'
                          ? 'مراجعة التطبيق'
                          : focus_lang == 'id'
                              ? 'ulasan aplikasi'
                              : focus_lang == 'fr'
                                  ? 'demande de révision'
                                  : focus_lang == 'es'
                                      ? 'Revizia apliko'
                                      : focus_lang == 'ur'
                                          ? 'جائزہ لینے کی درخواست'
                                          : 'आवेदन की समीक्षा करें');
                },
              ),
              onTap: () {
                Navigator.pop(context);
                LaunchReview.launch();
              },
            ),
            ListTile(
              title: FutureBuilder(
                future: getapplang(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData == false) return Container();
                  var focus_lang = snapshot.data;
                  return Text(focus_lang == 'en'
                      ? 'change the language'
                      : focus_lang == 'ar'
                          ? 'تغيير اللغة'
                          : focus_lang == 'id'
                              ? 'Ubah bahasanya'
                              : focus_lang == 'fr'
                                  ? 'Changer la langue'
                                  : focus_lang == 'es'
                                      ? 'Ŝanĝi la lingvon'
                                      : focus_lang == 'ur'
                                          ? 'زبان تبدیل کریں'
                                          : 'भाषा बदलें');
                },
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return SetLang();
                }));
              },
            ),
            ListTile(
              title: FutureBuilder(
                future: getapplang(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData == false) return Container();
                  var focus_lang = snapshot.data;
                  return Text(focus_lang == 'en'
                      ? 'About'
                      : focus_lang == 'ar'
                          ? 'حول'
                          : focus_lang == 'id'
                              ? 'tentang'
                              : focus_lang == 'fr'
                                  ? 'sur'
                                  : focus_lang == 'es'
                                      ? 'pri'
                                      : focus_lang == 'ur'
                                          ? 'کے بارے میں'
                                          : 'के बारे में');
                },
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return About();
                }));
              },
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        child: TabBarView(
          controller: _tabController,
          children: quran_imgs.map((item) {
            return Contant(
              tab: _tabController,
              img: item,
              index: quran_imgs.indexOf(item).toInt() + 1,
              sura_____index: widget.sura____index,
              conttt: context,
            );
          }).toList(),
        ),
        length: quran_imgs.length,
      ),
    );
  }
}
