import 'package:blinvest/models/financial_indicator.dart';

abstract class SiteDataParser {
  FinancialIndicator convert(String dataSite);
}
