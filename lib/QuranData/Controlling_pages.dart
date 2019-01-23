import 'package:aq/aq.simple.dart';

import 'Data.dart';

getPageItems(int page_num, sura_____index) {
  // print(sura_____index);
  var focus_page_ayas = quranData['Page'][page_num];
  // print(quranData['Page'].length);
  // print(page_num);
  var focus_page_ayas_next = quranData['Page'][page_num + 1];

  // print(focus_page_ayas);
  // print(focus_page_ayas_next);

  var num_sura_ = focus_page_ayas[0];
  var num_sura_aya = focus_page_ayas[1];

  var num_sura_next = focus_page_ayas_next[0];
  var num_sura_aya_next = focus_page_ayas_next[1];

  bool fullSuraInPage = false;

  if (num_sura_aya == num_sura_aya_next && num_sura_ == num_sura_next + 1)
    fullSuraInPage = true;

  if (fullSuraInPage) {
    // print('state 1');

    // this for get full ayas of sura in one page like fatha;

    var ayas = aq['quran']['sura'][page_num - 1]['aya'];

    return [ayas, num_sura_];
  } else {
// this for get some ayas of sura to complete a sura;
    if (num_sura_ == num_sura_next) {
      // print('state 2');
      List ayasArrays = [];
      List ayas = aq['quran']['sura'][num_sura_ - 1]['aya'];

      for (int i = 0; i < ayas.length; i++) {
        List aya__ = aq['quran']['sura'][num_sura_ - 1]['aya'];
        if (i >= (num_sura_aya - 1) && i < (num_sura_aya_next - 1)) {
          ayasArrays.add(aya__[i]);
          // print(aya__);
        }
      }
      return [ayasArrays, num_sura_];
    } else {
      if (num_sura_aya == num_sura_aya_next && num_sura_ != num_sura_next) {
        // print('state 3');

        List arrsuras = [];
        var from = num_sura_;
        var to = num_sura_next;

        // for geting a number of sura mixed in same page;
        for (int o = from; o < to; o++) {
          arrsuras.add(o - 1);
        }
        // print(arrsuras);
        // end
        List fullpageayas = [];

        for (var i in arrsuras) {
          // print(i);
          // print(aq['quran']['sura'][i]['aya']);

          fullpageayas.add({'key': i});
          fullpageayas.addAll(aq['quran']['sura'][i]['aya']);

          continue;
        }

        return [fullpageayas, arrsuras[0] + 1];
      }
    }
  }

  if (num_sura_aya_next == 1 && num_sura_ != num_sura_next) {
    // print('state 4');
    List ayasArrays = [];
    List ayas = aq['quran']['sura'][num_sura_ - 1]['aya'];

    for (int i = 0; i < ayas.length; i++) {
      List aya__ = aq['quran']['sura'][num_sura_ - 1]['aya'];
      if (i < num_sura_aya) {
        ayasArrays.add(aya__[i]);
        // print(aya__);
      }
    }
    return [ayasArrays, num_sura_];
  }
  if (num_sura_aya_next != num_sura_aya && num_sura_ != num_sura_next) {
    // print('state 5');
    List arrsuras = [];
    var from = num_sura_;
    var to = num_sura_aya;

    var form_ = num_sura_next;
    var to_ = num_sura_aya_next;

    // for geting a number of sura mixed in same page;
    for (int o = from; o <= form_; o++) {
      // print('$o == $num_sura_');
      if (o == num_sura_) {
        arrsuras.add([o - 1, (to == 1) ? 'full' : to]);
        continue;
      }
      // print('$o == $num_sura_next');

      if (o == num_sura_next && to_ != 1) {
        arrsuras.add([o - 1, to_]);
        continue;
      }

      arrsuras.add([o - 1, 'full']);
    }
    // print(arrsuras);

    // add aq;
    List ayasArrays = [];

    for (var i in arrsuras) {
      // print(i);
      if (i[1] == 'full') {
        // print('full');

        List aya__ = aq['quran']['sura'][i[0]]['aya'];
        ayasArrays.addAll(aya__);
      } else {
        List ayas = aq['quran']['sura'][num_sura_ - 1]['aya'];

        for (int c = 0; c < ayas.length; c++) {
          List aya__ = aq['quran']['sura'][i[0]]['aya'];
          if (c < i[1]) {
            ayasArrays.add(aya__[c]);
            // print(aya__[c]);
          }
        }
      }
    }

    // print(ayasArrays);
    return [ayasArrays, arrsuras[0][0] + 1];
    // end

  }
}
