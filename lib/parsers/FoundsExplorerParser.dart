import 'dart:convert';

import 'package:blinvest/models/financial_indicator.dart';
import 'package:blinvest/parsers/SiteDataParser.dart';

class FoundsExplorerParser implements SiteDataParser {
  @override
  FinancialIndicator convert(String dataSite) {
    var data = const LineSplitter().convert(dataSite);
    FinancialIndicator financialsIndicators = FinancialIndicator.liquid(
      liquidity: double.parse(data[4].trim()),
    );

    return financialsIndicators;
  }
}
