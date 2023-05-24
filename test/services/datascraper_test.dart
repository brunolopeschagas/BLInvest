import 'dart:convert';

import 'package:blinvest/services/datascraper.dart';
import 'package:test/test.dart';

void main() {
  test('get data from web', () async {
    DataScraper dataScraper = DataScraper(
        websiteUrl: 'http://localhost:8080/http/foundsexplorerlocal.html',
        websSiteSelector: '#table-ranking > tbody > tr');
    var data = await dataScraper.scrapeData();
    var result = const LineSplitter().convert(data.first);

    expect(result.elementAt(4), 12.292);
  });
}
