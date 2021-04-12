import 'dart:convert';
import 'package:http/http.dart';
import 'dart:math';

class QuoteServices {
  List quotesList = [];
  Future<void> getQuotables() async {
    // GET A RANDOM QUOTE FROM QUOTABLE
    for (var i = 0; i < 10; i++) {
      Response responseQuotable =
          await get(Uri.parse("https://api.quotable.io/random"));
      dynamic responseQuotableJSON = jsonDecode(responseQuotable.body);
      quotesList.add(["QUOTABLE", responseQuotableJSON]);
    }
    // GET A RANDOM QUOTE FROM TYPE.FIT
    Response responseTypeFit =
        await get(Uri.parse("https://type.fit/api/quotes"));
    dynamic responseTypeFitJSON = jsonDecode(responseTypeFit.body);
    Random random = Random();
    int randomNum = random.nextInt(80) + 1;
    for (int i = randomNum; i < randomNum + 20; i++) {
      quotesList.add(["TYPE.FIT", responseTypeFitJSON[i]]);
    }
    // GET A RANDOM QUOTE FROM ADVICE SLIP
    for (var i = 0; i < 20; i++) {
      Response responseAdviceSlip =
          await get(Uri.parse("https://api.adviceslip.com/advice"));
      dynamic responseAdviceSlipJSON = jsonDecode(responseAdviceSlip.body);
      quotesList.add(["ADVICE SLIP", responseAdviceSlipJSON["slip"]]);
    }
    // GET A RANDOM QUOTE FROM AFFIRMATIONS
    for (var i = 0; i < 20; i++) {
      Response responseAffirmations =
          await get(Uri.parse("https://www.affirmations.dev"));
      dynamic responseAffirmationsJSON = jsonDecode(responseAffirmations.body);
      quotesList.add(["AFFIRMATIONS", responseAffirmationsJSON]);
    }

    quotesList.shuffle();
  }
}
