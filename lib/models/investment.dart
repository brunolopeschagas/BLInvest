class Investment {
  late int id;
  late String ticker;
  late double priceBuy;
  late double priceSale;

  Investment(
      {required this.ticker, required this.priceBuy, required this.priceSale}) {
    id = id;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'ticker': ticker,
      'priceBuy': priceBuy,
      'priceSale': priceSale
    };
    return map;
  }

  Investment.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    ticker = map['ticker'];
    priceBuy = map['priceBuy'];
    priceSale = map['priceSale'];
  }
}
