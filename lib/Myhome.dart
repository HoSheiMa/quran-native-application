// import 'package:aq//Data.dart';
import 'QuranData/Data.dart';
import 'package:aq/main.dart';
import 'package:flutter/material.dart';
import 'package:aq/helperWidget/Helper_widget_myhomepage.dart';
import 'aq.simple.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:launch_review/launch_review.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future getapplang() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var lang = prefs.getString('lang');
  return lang;
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    setsetting() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getStringList('stars').runtimeType == Null ||
          prefs.getString('bookMark').runtimeType == Null ||
          prefs.getStringList('love_aya').runtimeType == Null ||
          prefs.getString('bookMark').runtimeType == Null) {
        setState(() {
          prefs.getStringList('stars').runtimeType == Null
              ? prefs.setStringList('stars', [])
              : '';
          prefs.getString('bookmark').runtimeType == Null
              ? prefs.setString('bookmark', '')
              : '';
          prefs.getString('ThemeDark').runtimeType == Null
              ? prefs.setString('ThemeDark', 'false')
              : '';
          // prefs.getString('lang').runtimeType == Null ?  prefs.setString('lang', ''): '';
          prefs.getStringList('love_aya').runtimeType == Null
              ? prefs.setStringList('love_aya', [])
              : '';
        });
      }
    }

    setsetting();

    final GlobalKey<ScaffoldState> dkey = new GlobalKey<ScaffoldState>();
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

    Future setTheme(String state) async {
      String state_ = state;
      if (state == 'dark') state_ = 'true';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Navigator.pop(dkey.currentState.context);
      setState(() {
        if (state == 'dark') {
          prefs.setString('dark', 'true');
        } else {
          prefs.setString('dark', 'false');
        }
        prefs.setString('ThemeDark', state_);
      });
    }

    // _test('ar');
    return Scaffold(
      key: dkey,

      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('title'),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 15.0),
            child: Column(
                children: aq['quran']['sura'].map((item) {
              int index = int.parse(item['index']);

              return Costam_card(
                title: item['name'],
                index: tabpagenum[index - 1],
                sura____index: index,
              );
            }).toList()),
          ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.apps,
          color: Colors.black,
        ),
        onPressed: () {
          dkey.currentState.openDrawer();
        },
      ),
    );
  }
}

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 500,
                  child: Image(
                    image: AssetImage('assets/logo_.jpg'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  child: FutureBuilder(
                    future: getapplang(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData == false) return Container();
                      var focus_lang = snapshot.data;
                      return Row(
                        mainAxisAlignment:
                            focus_lang == 'ar' || focus_lang == 'ur'
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              focus_lang == 'en'
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
                                                      : 'के बारे में',
                              style: TextStyle(fontSize: 21)),
                        ],
                      );
                    },
                  ),
                ),
                FutureBuilder(
                  future: getapplang(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData == false) return Container();
                    var focus_lang = snapshot.data;

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.green.withOpacity(.1),
                      ),
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.all(12),
                      child: Text.rich(
                        TextSpan(
                            text: focus_lang == 'en'
                                ? 'Contains the interpretation of the Koran in several languages are Arabic, English, French, Hindi, Hindi, Spanish and Urdu. The application contains easy interpretation of the Koran, the application is easy to handle and smooth you can read from the application with a variety of methods and can enlarge the image to read more clearly And share your friends easily through the reference button for the word and can write your comments and share with everyone also wish you a good experience'
                                : focus_lang == 'ar'
                                    ? ' يحتوي على تفسير القرآن بعدة لغات هم اللغة  العربية واللغة الانجليزية و الفرنسية واللغة الاندنوسية و اللغة الهندية واللغة  الاسبانية  واللغة الأردية و يحتوي التطبيق علي التفسير الميسر للقرءان الكريم ، التطبيق سهل في التعامل و سلس يمكنك القراءة من التطبيق بعددة اساليب و يمكن تكبير الصورة لقراءة واضحة اكثر و مشاركة اصدقاءك بسهولة من خلال زر المشاره للاية و يمكن ان تكتب ملاحظاتك و تشاركة مع الجميع ايضا نتمني لك تجربة طيبة '
                                    : focus_lang == 'id'
                                        ? 'Berisi interpretasi Alquran dalam beberapa bahasa yaitu Arab, Inggris, Perancis, Hindi, Hindi, Spanyol dan Urdu. Aplikasi ini berisi interpretasi yang mudah dari Alquran, aplikasi ini mudah ditangani dan halus Anda dapat membaca dari aplikasi dengan berbagai metode dan dapat memperbesar gambar untuk membaca lebih jelas. Dan bagikan teman-teman Anda dengan mudah melalui tombol referensi untuk kata tersebut dan dapat menulis komentar dan berbagi dengan semua orang juga berharap Anda mendapatkan pengalaman yang baik'
                                        : focus_lang == 'fr'
                                            ? "Comprend l'interprétation du Coran en plusieurs langues (arabe, anglais, français, hindi, hindi, espagnol et ourdou) .L'application contient une interprétation facile du Coran, elle est facile à manipuler et lisse. Et partagez facilement vos amis grâce au bouton de référence du mot. Vous pouvez écrire vos commentaires et les partager avec tout le monde. Nous vous souhaitons également une bonne expérience."
                                            : focus_lang == 'es'
                                                ? 'Ĝi enhavas la leĝon de la Korano en pluraj lingvoj estas araba, angla, franca, hinda, hinda, hispana kaj urda. La apliko enhavas facilan legon de Korano, la apliko estas facile manipuli kaj glata, kiun vi povas legi de la apliko per diversaj metodoj kaj povas pligrandigi la bildon por legi pli klare Kaj dividu viajn amikojn facile per la referenca butono por la vorto kaj povas skribi viajn komentojn kaj dividi kun ĉiuj ankaŭ deziras bonan sperton'
                                                : focus_lang == 'ur'
                                                    ? 'قرآن کریم کی تشریح پر مشتمل عربی زبان، انگریزی، فرانسیسی، ہندی، ہندی، ہسپانوی اور اردو ہیں. اس درخواست میں قران کی آسان تفسیر ہے، درخواست آپ کو سنبھالنے میں آسان اور آسانی سے مختلف طریقوں سے درخواست سے پڑھ سکتے ہیں اور زیادہ واضح طور پر پڑھنے کے لئے تصویر کو بڑھا سکتے ہیں. اور اپنے دوستوں کو لفظ کے لئے ریفرنس کے بٹن کے ذریعہ آسانی سے اشتراک کریں اور اپنے تبصرے لکھ سکتے ہیں اور سب کے ساتھ اشتراک کرسکتے ہیں اور آپ کو بھی اچھا تجربہ ہے'
                                                    : 'कई भाषाओं में कुरान की व्याख्या शामिल है अरबी, अंग्रेजी, फ्रेंच, हिंदी, हिंदी, स्पेनिश और उर्दू हैं। आवेदन में कुरान की आसान व्याख्या है, आवेदन को संभालना आसान है और आप विभिन्न तरीकों से आवेदन से पढ़ सकते हैं और आसानी से पढ़ने के लिए छवि को बड़ा कर सकते हैं। और शब्द के लिए संदर्भ बटन के माध्यम से अपने दोस्तों को आसानी से साझा करें और अपनी टिप्पणी लिख सकते हैं और सभी के साथ साझा कर सकते हैं आप एक अच्छा अनुभव भी चाहते हैं'),
                        textAlign: focus_lang == 'ar' || focus_lang == 'ur'
                            ? TextAlign.end
                            : TextAlign.start,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
