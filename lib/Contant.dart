import 'package:aq/helperWidget/Dialog.dart';
import 'package:aq/translate/translate.dart';
import 'package:async/async.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:aq/aq.simple.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'dart:convert';
import 'QuranData/Controlling_pages.dart';
// import 'package:aq/Controlling_pages.dart';
import 'package:page_transition/page_transition.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Contant extends StatefulWidget {
  TabController tab;
  final int index;
  final String img;
  final int sura_____index;
  final BuildContext conttt;
  Contant({this.tab, this.img, this.index, this.conttt, this.sura_____index});
  @override
  _ContantState createState() => _ContantState();
}

Future getloveaya() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var love_aya = prefs.getStringList('love_aya');
  return love_aya;
}

class _ContantState extends State<Contant> with TickerProviderStateMixin {
  List<TextSpan> aq_text_show = [];
  List<Widget> aq_text_show_false_mood = [];

  Future getapplang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var lang = prefs.getString('lang');
    return lang;
  }

  Future getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var lang = prefs.getString('ThemeDark');

    lang = lang.runtimeType == Null ? 'false' : lang;
    return lang;
  }

  add_love_aya(BuildContext context, suro_index, index) async {
    print(suro_index.toString() + " () " + index.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List lovely_ayas = prefs.getStringList('love_aya');
    for (int o = 0; o < lovely_ayas.length; o++) {
      List aya_love_data = lovely_ayas[o].split(',');
      var sura_1 = aya_love_data[0].toString();
      var sura_2 = suro_index.toString();
      var aya_1 = aya_love_data[1].toString();
      if (sura_1 == sura_2 && aya_1 == index.toString()) {
        lovely_ayas.removeAt(o);

        prefs.setStringList('love_aya', lovely_ayas);
        print('Done! remove [0] ');
        setState(() {});
        return;
      }
    }

    lovely_ayas.add('$suro_index,$index');
    prefs.setStringList('love_aya', lovely_ayas);
    print('Done! added [00]');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future getPage__() async {
      return getPageItems(widget.index, widget.sura_____index);
    }

    Future showTranslatdailg(contextc, suro_index, index) async {
      index = index - 1;
      List focus_aya = aq['quran']['sura'][suro_index]['aya'];
      var width_7 = MediaQuery.of(context).size.width * .7;
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (contxt) {
            return FutureBuilder(
                future: getTheme(),
                builder: (ctx, darktheme) {
                  if (darktheme.hasData == false) return Container();

                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      child: ConstrainedBox(
                        child: Container(
                          width: width_7,
                          height: 300.0,
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: darktheme.data == 'false'
                                        ? Colors.green
                                        : Color(0xff343a40),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                    )),
                                height: 60,
                                width: double.infinity,
                                // width: width_7,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      AutoSizeText.rich(
                                        TextSpan(
                                            text: focus_aya[index]['text'],
                                            style:
                                                TextStyle(color: Colors.white)),
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  width: width_7,
                                  child: Column(
                                    children: <Widget>[
                                      FutureBuilder(
                                        future: getapplang(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          var focus_lang =
                                              snapshot.data.toString();
                                          var langSource = focus_lang == 'en'
                                              ? translate_en
                                              : focus_lang == 'ar'
                                                  ? translate_ar
                                                  : focus_lang == 'id'
                                                      ? translate_id
                                                      : focus_lang == 'fr'
                                                          ? translate_fr
                                                          : focus_lang == 'es'
                                                              ? translate_es
                                                              : focus_lang ==
                                                                      'ur'
                                                                  ? translate_ur
                                                                  : translate_hi;

                                          var focus_trans_lang_source =
                                              langSource;
                                          var focus_trans_aya =
                                              focus_trans_lang_source['quran'];
                                          List f = focus_trans_aya['sura']
                                              [suro_index]['aya'];
                                          return Container(
                                            height: 230,
                                            child: SingleChildScrollView(
                                              child: Container(
                                                padding: EdgeInsets.all(4),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      f[index]['_text'],
                                                      style: TextStyle(
                                                          fontSize: 21),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                          // return Container(
                                          // child: Text.rich(AutoSizeText()),
                                          // f[index]['_text']
                                          // );
                                        },
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        constraints: new BoxConstraints(
                          minHeight: 300.0,
                          // maxHeight: 60.0,
                        ),
                      ));
                });
          });
    }

    Future showTransBox(
        contextc, int suro_index_, int index, int pagenum___) async {
      List aya = aq['quran']['sura'][suro_index_]['aya'];
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (contxt) {
            return FutureBuilder(
              future: getTheme(),
              builder: (ctx, themestate) {
                if (themestate.hasData == false) return Container();
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  child: ConstrainedBox(
                    constraints: new BoxConstraints(
                      minHeight: 360.0,
                      // maxHeight: 60.0,
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        height: 360.0,
                        width: MediaQuery.of(context).size.width * .7,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: themestate.data == 'false'
                                        ? Colors.green
                                        : Color(0xff343a40),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                    )),
                                height: 60,
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      AutoSizeText.rich(
                                        TextSpan(
                                          text: aya[index - 1]['text'],
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          // style: TextStyle(),
                                        ),
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    child: Column(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            showTranslatdailg(
                                                context, suro_index_, index);
                                          },
                                          child: Card(
                                            elevation: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(14),
                                              child: FutureBuilder(
                                                future: getapplang(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  var focus_lang =
                                                      snapshot.data;

                                                  return Row(
                                                    mainAxisAlignment:
                                                        (snapshot.data != 'ar')
                                                            ? MainAxisAlignment
                                                                .start
                                                            : MainAxisAlignment
                                                                .end,
                                                    children: <Widget>[
                                                      (snapshot.data != 'ar')
                                                          ? Icon(
                                                              Icons.translate,
                                                              color: Color(
                                                                  0xFF17a2b8),
                                                            )
                                                          : Container(),
                                                      Text(focus_lang == 'en'
                                                          ? 'Explanation'
                                                          : focus_lang == 'ar'
                                                              ? 'تفسير'
                                                              : focus_lang ==
                                                                      'id'
                                                                  ? 'Interpretasi'
                                                                  : focus_lang ==
                                                                          'fr'
                                                                      ? "D'interprétation"
                                                                      : focus_lang ==
                                                                              'es'
                                                                          ? 'Lego'
                                                                          : focus_lang == 'ur'
                                                                              ? 'تشریح'
                                                                              : 'व्याख्या'),
                                                      (snapshot.data == 'ar')
                                                          ? Icon(
                                                              Icons.translate,
                                                              color: Color(
                                                                  0xFF17a2b8),
                                                            )
                                                          : Container(),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    child: Column(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            // becaouse array start from 1;
                                            var rule_sura = suro_index_++;
                                            var rule_index = index;
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            String oldBookmark =
                                                prefs.getString('bookmark');
                                            if (oldBookmark.runtimeType ==
                                                Null) {
                                                  print('state 1');
                                              prefs.setString('bookmark',
                                                  '["$rule_sura", "$rule_index", "$pagenum___"]');
                                                  setState(() {
                                              // print(prefs.getString('bookmark'));
                                            });
                                                  return;
                                            }
                                            // prefs.setString('bookmark', '');

                                            if (oldBookmark.isEmpty) {
                                                  print('state 2');

                                              prefs.setString('bookmark',
                                                  '["$rule_sura", "$rule_index", "$pagenum___"]');
                                                  setState(() {
                                              // print(prefs.getString('bookmark'));
                                            });
                                            return ;
                                            } else {
                                                  print('state 3');

                                              List oldBookmarkarr =
                                                  jsonDecode(oldBookmark);

                                              if (oldBookmarkarr[0] ==
                                                      rule_sura.toString() &&
                                                  oldBookmarkarr[1] ==
                                                      rule_index.toString()) {
                                                prefs.setString('bookmark', '');
                                              } else {
                                                prefs.setString('bookmark',
                                                    '["$rule_sura", "$rule_index", "$pagenum___"]');
                                                    setState(() {
                                              // print(prefs.getString('bookmark'));
                                            });
                                            return;
                                              }
                                            }
                                                  print('state end');

                                            // setState(() {
                                            //   // print(prefs.getString('bookmark'));
                                            // });
                                          },
                                          child: Card(
                                            elevation: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(14),
                                              child: FutureBuilder(
                                                future: getapplang(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  var focus_lang =
                                                      snapshot.data;
                                                  return Row(
                                                    mainAxisAlignment:
                                                        (snapshot.data != 'ar')
                                                            ? MainAxisAlignment
                                                                .start
                                                            : MainAxisAlignment
                                                                .end,
                                                    children: <Widget>[
                                                      (snapshot.data != 'ar')
                                                          ? Icon(
                                                              Icons.bookmark,
                                                              color: Color(
                                                                  0xFFdc3545),
                                                            )
                                                          : Container(),
                                                      Text(focus_lang == 'en'
                                                          ? 'bookmark'
                                                          : focus_lang == 'ar'
                                                              ? 'الفاصل'
                                                              : focus_lang ==
                                                                      'id'
                                                                  ? 'bookmark'
                                                                  : focus_lang ==
                                                                          'fr'
                                                                      ? 'signet'
                                                                      : focus_lang ==
                                                                              'es'
                                                                          ? 'legosigno'
                                                                          : focus_lang == 'ur'
                                                                              ? 'بک مارک'
                                                                              : 'बुकमार्क'),
                                                      (snapshot.data == 'ar')
                                                          ? Icon(
                                                              Icons.bookmark,
                                                              color: Color(
                                                                  0xFFdc3545),
                                                            )
                                                          : Container(),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    child: Column(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            add_love_aya(
                                                context, suro_index_, index);
                                          },
                                          child: Card(
                                            elevation: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(14),
                                              child: FutureBuilder(
                                                future: getapplang(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  var focus_lang =
                                                      snapshot.data;

                                                  return Row(
                                                    mainAxisAlignment:
                                                        (snapshot.data != 'ar')
                                                            ? MainAxisAlignment
                                                                .start
                                                            : MainAxisAlignment
                                                                .end,
                                                    children: <Widget>[
                                                      (snapshot.data != 'ar')
                                                          ? Icon(
                                                              Icons.favorite,
                                                              color: Color(
                                                                  0xFFdc3545),
                                                            )
                                                          : Container(),
                                                      Text(focus_lang == 'en'
                                                          ? 'Favorite'
                                                          : focus_lang == 'ar'
                                                              ? 'مفضلة'
                                                              : focus_lang ==
                                                                      'id'
                                                                  ? 'Favorit'
                                                                  : focus_lang ==
                                                                          'fr'
                                                                      ? 'Favori'
                                                                      : focus_lang ==
                                                                              'es'
                                                                          ? 'Plej ŝatata'
                                                                          : focus_lang == 'ur'
                                                                              ? 'پسندیدہ'
                                                                              : 'विशेष रुप से प्रदर्शित'),
                                                      (snapshot.data == 'ar')
                                                          ? Icon(
                                                              Icons.favorite,
                                                              color: Color(
                                                                  0xFFdc3545),
                                                            )
                                                          : Container(),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    child: Column(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);

                                            write_note_aya(suro_index_, index);
                                          },
                                          child: Card(
                                            elevation: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(14),
                                              child: FutureBuilder(
                                                future: getapplang(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  var focus_lang =
                                                      snapshot.data;
                                                  return Row(
                                                    mainAxisAlignment:
                                                        (snapshot.data != 'ar')
                                                            ? MainAxisAlignment
                                                                .start
                                                            : MainAxisAlignment
                                                                .end,
                                                    children: <Widget>[
                                                      (snapshot.data != 'ar')
                                                          ? Icon(
                                                              Icons.edit,
                                                              color: Color(
                                                                  0xFFDB5461),
                                                            )
                                                          : Container(),
                                                      Text(focus_lang == 'en'
                                                          ? 'Note'
                                                          : focus_lang == 'ar'
                                                              ? 'ملاحظة'
                                                              : focus_lang ==
                                                                      'id'
                                                                  ? 'Catatan'
                                                                  : focus_lang ==
                                                                          'fr'
                                                                      ? 'Note'
                                                                      : focus_lang ==
                                                                              'es'
                                                                          ? 'Noto'
                                                                          : focus_lang == 'ur'
                                                                              ? 'نوٹ'
                                                                              : 'नोटिस'),
                                                      (snapshot.data == 'ar')
                                                          ? Icon(
                                                              Icons.edit,
                                                              color: Color(
                                                                  0xFFDB5461),
                                                            )
                                                          : Container(),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    child: Column(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);

                                            List focus_sura = aq['quran']
                                                ['sura'][suro_index_]['aya'];
                                            // print(focus_sura[index]);
                                            // print(contr.text);
                                            Share.share(
                                                focus_sura[index - 1]['text']);
                                          },
                                          child: Card(
                                            elevation: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(14),
                                              child: FutureBuilder(
                                                future: getapplang(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  var focus_lang =
                                                      snapshot.data;
                                                  return Row(
                                                    mainAxisAlignment:
                                                        (snapshot.data != 'ar')
                                                            ? MainAxisAlignment
                                                                .start
                                                            : MainAxisAlignment
                                                                .end,
                                                    children: <Widget>[
                                                      (snapshot.data != 'ar')
                                                          ? Icon(
                                                              Icons.share,
                                                              color: Color(
                                                                  0xFF6f42c1),
                                                            )
                                                          : Container(),
                                                      Text(focus_lang == 'en'
                                                          ? 'share'
                                                          : focus_lang == 'ar'
                                                              ? 'شارك'
                                                              : focus_lang ==
                                                                      'id'
                                                                  ? 'Bagikan'
                                                                  : focus_lang ==
                                                                          'fr'
                                                                      ? 'partager'
                                                                      : focus_lang ==
                                                                              'es'
                                                                          ? 'kunhavigi'
                                                                          : focus_lang == 'ur'
                                                                              ? 'بانٹیں'
                                                                              : 'शेयर'),
                                                      (snapshot.data == 'ar')
                                                          ? Icon(
                                                              Icons.share,
                                                              color: Color(
                                                                  0xFFDB5461),
                                                            )
                                                          : Container(),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          });
    }

    // Future getTheme() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();

    //   var lang = prefs.getString('ThemeDark');

    //   lang = lang.runtimeType == Null ? 'false' : lang;
    //   return lang;
    // }
    Future getdark() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var lang = prefs.getString('dark');

      lang = lang.runtimeType == Null ? 'false' : lang;
      return lang;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getdark(),
            builder: (xtcc, darktheme_dark) {
              if (darktheme_dark.hasData == false) return Container();

              return FutureBuilder(
                future: getTheme(),
                builder: (ctx, darkThemeState) {
                  if (darkThemeState.hasData == false) return Container();

                  return Container(
                    color: darkThemeState.data == 'false'
                        ? Color(0xFFfcf4e9)
                        : (darktheme_dark.data == 'false')
                            ? Colors.black.withOpacity(.8)
                            : Colors.black,
                    child: FutureBuilder(
                      future: getloveaya(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        // print(snapshot.data);
                        if (snapshot.hasData == false) {
                          return Container();
                        }
                        // print(snapshot.data.runtimeType);

                        Future get_read_mood_state() async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          return prefs.getString('read_mood');
                        }

                        return FutureBuilder(
                          future: get_read_mood_state(),
                          builder:
                              (BuildContext context2, AsyncSnapshot snapshot2) {
                            if (snapshot2.hasData == false) {
                              return Container();
                            }

                            List<Widget> page_txt_ = [];

/*    
                          
                        ],*/

                            aq_text_show_false_mood = [];
                            if (snapshot2.data == "true") {
                              var focus_img = 'assets/quran/' + widget.img;
                              aq_text_show_false_mood.add(
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: PhotoView(
                                    minScale:
                                        PhotoViewComputedScale.contained * 1.2,
                                    imageProvider: AssetImage(
                                      focus_img,
                                    ),
                                    initialScale:
                                        PhotoViewComputedScale.contained * 1.2,
                                  ),
                                ),
                              );
                            } else {
                              bookMark() async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                if (prefs.getString('bookmark').runtimeType ==
                                    Null) return Null;
                                if (prefs.getString('bookmark').isEmpty)
                                  return Null;
                                return prefs.getString('bookmark');
                              }

                              aq_text_show_false_mood.add(
                                Container(
                                  child: FutureBuilder(
                                    future: bookMark(),
                                    builder: (BuildContext context5,
                                        AsyncSnapshot bookmark) {
                                      // print(bookmark.error);

                                      if (bookmark.hasData == false)
                                        return Container();
                                      bool nobookmark = false;
                                      List arrBookmarkdata = [];
                                      if (bookmark.data == Null) {
                                        nobookmark = true;
                                      } else {
                                        arrBookmarkdata =
                                            jsonDecode(bookmark.data);
                                      }

                                      return FutureBuilder(
                                        future: getapplang(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot lang) {
                                          var focus_lang = lang.data.toString();
                                          var langSource = focus_lang == 'en'
                                              ? translate_en
                                              : focus_lang == 'ar'
                                                  ? translate_ar
                                                  : focus_lang == 'id'
                                                      ? translate_id
                                                      : focus_lang == 'fr'
                                                          ? translate_fr
                                                          : focus_lang == 'es'
                                                              ? translate_es
                                                              : focus_lang ==
                                                                      'ur'
                                                                  ? translate_ur
                                                                  : translate_hi;

                                          var focus_trans_lang_source =
                                              langSource['quran'];
                                          return FutureBuilder(
                                            future: getPage__(),
                                            builder: (BuildContext context4,
                                                AsyncSnapshot snapshot3) {
                                              if (snapshot3.hasError == true) {
                                                print('error to get page ayas' +
                                                    snapshot3.error.toString());
                                                return Container();
                                              }
                                              if (snapshot3.hasData == false)
                                                return Container();

                                              List t = focus_trans_lang_source[
                                                          'sura']
                                                      [snapshot3.data[1] - 1]
                                                  ['aya'];
                                              // print(snapshot3.data[1]);

                                              List<Widget> returner_widgets =
                                                  [];

                                              // return Container();
                                              List results_trans =
                                                  snapshot3.data[0];
                                              // for (int uuu in results_trans) {
                                              for (int uuu = 0;
                                                  uuu < results_trans.length;
                                                  uuu++) {
                                                if (results_trans[uuu]['key']
                                                        .runtimeType ==
                                                    int) {
                                                  t = focus_trans_lang_source[
                                                          'sura'][
                                                      results_trans[uuu]
                                                          ['key']]['aya'];
                                                  continue;
                                                }
                                                var focus_aya_in_sura =
                                                    results_trans[uuu];
                                                // check if aya have star ?:
                                                Color aya_focus_Color =
                                                    Color(0xFF1d2129);
                                                bool lovemarkstate = false;
                                                var lovely_ayas = snapshot.data;

                                                for (int o = 0;
                                                    o < lovely_ayas.length;
                                                    o++) {
                                                  List aya_love_data =
                                                      lovely_ayas[o].split(',');
                                                  var sura_1 = aya_love_data[0]
                                                      .toString();
                                                  var sura_2 =
                                                      (snapshot3.data[1] - 1)
                                                          .toString();
                                                  var aya_1 = aya_love_data[1]
                                                      .toString();
                                                  if (sura_1 == sura_2 &&
                                                      aya_1 ==
                                                          focus_aya_in_sura[
                                                                  'index']
                                                              .toString()) {
                                                    aya_focus_Color =
                                                        Colors.deepOrange;
                                                    lovemarkstate = true;
                                                  }
                                                }
                                                bool bookmarkstate = false;

                                                if (!nobookmark) {
                                                  if (arrBookmarkdata.length !=
                                                      0) {
                                                    // print(snapshot3.data[1].toString() +
                                                    //     " == " +
                                                    //     arrBookmarkdata[0].toString());
                                                    // print(focus_aya_in_sura['index']
                                                    //         .toString() +
                                                    //     " == " +
                                                    //     arrBookmarkdata[1].toString());

                                                    int bookmarksure = int
                                                            .parse(
                                                                arrBookmarkdata[
                                                                    0]) +
                                                        1; // for replace num to starting from 0 index

                                                    if (snapshot3.data[1]
                                                                .toString() ==
                                                            bookmarksure
                                                                .toString() &&
                                                        focus_aya_in_sura[
                                                                    'index']
                                                                .toString() ==
                                                            arrBookmarkdata[1]
                                                                .toString()) {
                                                      bookmarkstate = true;
                                                      // print('here1');
                                                    } else {
                                                      // print('here2');

                                                      bookmarkstate = false;
                                                    }
                                                  }

                                                  // print(focus_aya_in_sura['index']);
                                                }

                                                returner_widgets
                                                    .add(GestureDetector(
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .92,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            color: (darktheme_dark
                                                                        .data ==
                                                                    'false')
                                                                ? Color(0xFF2BA84A)
                                                                    .withOpacity(
                                                                        .1)
                                                                : Colors.green
                                                                    .withOpacity(
                                                                        0.05),
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 25,
                                                            bottom: 5,
                                                          ),
                                                          child: Column(
                                                            // mainAxisAlignment:
                                                            //     MainAxisAlignment.end,
                                                            children: <Widget>[
                                                              Container(
                                                                  height: 10,
                                                                  child: Stack(
                                                                    overflow:
                                                                        Overflow
                                                                            .visible,
                                                                    children: <
                                                                        Widget>[
                                                                      Positioned(
                                                                        top:
                                                                            -20,
                                                                        child: (bookmarkstate ==
                                                                                true)
                                                                            ? Container(
                                                                                // height: 10,
                                                                                child: Icon(
                                                                                  Icons.bookmark,
                                                                                  size: 32,
                                                                                  color: Color(0xffdc3545),
                                                                                ),
                                                                              )
                                                                            : Container(),
                                                                      ),
                                                                      (lovemarkstate ==
                                                                              true)
                                                                          ? Positioned(
                                                                              top: -20,
                                                                              left: (bookmarkstate == true) ? 32 : 0,
                                                                              child: Container(
                                                                                // height: 10,
                                                                                child: Icon(
                                                                                  Icons.favorite,
                                                                                  size: 32,
                                                                                  color: Color(0xffdc3545),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                    ],
                                                                  )),
                                                              RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                text: TextSpan(
                                                                  text: (focus_aya_in_sura[
                                                                      'text']),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                    color: (darktheme_dark.data ==
                                                                            'false')
                                                                        ? aya_focus_Color
                                                                        : Color(
                                                                            0xFFBABABA),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    .1),
                                                          ),
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .92,
                                                          padding:
                                                              EdgeInsets.all(6),
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text(
                                                                t[int.parse(focus_aya_in_sura[
                                                                        'index']) -
                                                                    1]['_text'],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 21,
                                                                  color: (darktheme_dark
                                                                              .data ==
                                                                          'false')
                                                                      ? Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              .6)
                                                                      : Color(
                                                                          0xFFBABABA),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onLongPress: () =>
                                                      showTransBox(
                                                          context,
                                                          snapshot3.data[1] - 1,
                                                          int.parse(
                                                              focus_aya_in_sura[
                                                                  'index']),
                                                          widget.index),
                                                ));
                                              }
                                              return Column(
                                                  children: returner_widgets);
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                            // print(aq_text_show_false_mood);
                            return Container(
                              child: Column(
                                children: aq_text_show_false_mood,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  write_note_aya(suro_index_, index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List json_ = prefs.getStringList('note_aya');
    // List test = jsonDecode(json_[0]);
    // print(test[2]);
    TextEditingController contr = TextEditingController();
    bool exist = false;
    int json_index;

    for (int i = 0; i < json_.length; i++) {
      List json = jsonDecode(json_[i]);
      if (suro_index_.toString() == json[0] && index.toString() == json[1]) {
        exist = true;
        String inittext = json[2];
        contr.text = inittext.replaceAll('[end(-)line]', '\n');
        json_index = i;
        break;
      }
    }
    String info;
    await showDialog<String>(
      context: widget.conttt,
      child: FutureBuilder(
        future: getTheme(),
        builder: (ctx, themestate) {
          if (themestate.hasData == false) return Container();
          return new Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * .8,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                //themestate == 'false' ? Colors.green : Color(0xff343a40),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(4),
                    height: 50,
                    decoration: BoxDecoration(
                      color: themestate.data == 'false'
                          ? Colors.green
                          : Color(0xff343a40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                child: Icon(
                                  Icons.close,
                                  color: Color(0xffdc3545),
                                ),
                                onPressed: () =>
                                    Navigator.pop(widget.conttt),
                              ),
                              width: 60,
                            ),
                            Container(
                              child: FlatButton(
                                child: Icon(
                                  Icons.share,
                                  color: Color(0xff6f42c1),
                                ),
                                onPressed: () {
                                  Share.share(info);
                                },
                              ),
                              width: 60,
                            ),
                            Container(
                              child: FlatButton(
                                child: Icon(
                                  Icons.done,
                                  color: Color(0xff17a2b8),
                                ),
                                onPressed: () {
                                  if (exist == false) {
                                    if (info.isNotEmpty) {
                                      info = info.replaceAll(
                                          '\n', '[end(-)line]');
                                      json_.add(
                                          "[\"$suro_index_\", \"$index\", \"$info\"]");

                                      prefs.setStringList(
                                          'note_aya', json_);
                                    }
                                    Navigator.pop(widget.conttt);
                                  } else {
                                    if (info.isNotEmpty) {
                                      info = info.replaceAll(
                                          '\n', '[end(-)line]');
                                      json_[json_index] =
                                          "[\"$suro_index_\", \"$index\", \"$info\"]";
                                      prefs.setStringList(
                                          'note_aya', json_);
                                      Navigator.pop(widget.conttt);
                                    }
                                  }
                                },
                              ),
                              width: 60,
                            ),
                            Container(
                              child: FlatButton(
                                child: Icon(
                                  Icons.add_to_photos,
                                  color: Color(0xff20c997),
                                ),
                                onPressed: () {
                                  List focus_sura = aq['quran']['sura']
                                      [suro_index_]['aya'];
                                  // print(focus_sura[index]);
                                  // print(contr.text);
                                  contr.text = contr.text +
                                      focus_sura[index - 1]['text'];
                                },
                              ),
                              width: 60,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(aq['quran']['sura'][suro_index_]['name'],
                                style: TextStyle(
                                  fontSize: 19,
                                  color: themestate == 'false'
                                      ? Colors.black
                                      : Colors.white,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    padding: EdgeInsets.only(left: 2, right: 2),
                    color: Colors.white,
                    child: new TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: contr,
                      onChanged: (d) {
                        info = d;
                      },
                      maxLines: 999,
                      autofocus: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
