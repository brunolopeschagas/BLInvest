import 'package:blinvest/models/fii.dart';

abstract class SiteDataParser {
  Fii convert(String dataSite);
}
