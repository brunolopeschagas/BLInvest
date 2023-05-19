import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class DataScraper {
  final String websiteUrl;
  final String websSiteSelector;

  DataScraper({required this.websiteUrl, required this.websSiteSelector});

  Future<List<String>> scrapeData() async {
    final response = await http.get(Uri.parse(websiteUrl));
    final document = parser.parse(response.body);
    final elements = document.querySelectorAll(websSiteSelector);
    final data = elements.map((element) => element.text).toList();
    return data;
  }
}
