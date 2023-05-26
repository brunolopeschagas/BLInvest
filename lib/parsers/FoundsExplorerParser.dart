import 'dart:convert';

import 'package:blinvest/models/fii.dart';
import 'package:blinvest/parsers/SiteDataParser.dart';
import 'package:blinvest/parsers/sanitize.dart';

class FoundsExplorerParser implements SiteDataParser {
  @override
  Fii convert(String dataSite) {
    Sanitize sanitize = Sanitize();
    var data = const LineSplitter().convert(dataSite);
    double liquidity = double.parse(sanitize.removeSpaces(data[4]));
    double lastYeld = double.parse(sanitize.sanitizeToNumericOnly(data[11]));
    double dividendYeld =
        double.parse(sanitize.sanitizeToNumericOnly(data[17]));
    double netWorth = double.parse(sanitize.sanitizeToNumericOnly(data[23]));
    double bookValue = double.parse(sanitize.sanitizeToNumericOnly(data[29]));
    double profitabilityMonth =
        double.parse(sanitize.sanitizeToNumericOnly(data[35]));
    double pVP = double.parse(sanitize.sanitizeToNumericOnly(data[41]));
    Fii financialsIndicators = Fii.liquid(
        name: 'random_name',
        liquidity: liquidity,
        lastYeld: lastYeld,
        dividendYeld: dividendYeld,
        netWorth: netWorth,
        bookValue: bookValue,
        pVP: pVP,
        profitabilityMonth: profitabilityMonth);

    return financialsIndicators;
  }
}
