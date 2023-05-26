class Fii {
  String name;
  double value = 0;
  double liquidity = 0;
  double lastYeld = 0;
  double dividendYeld = 0;
  double netWorth = 0;
  double bookValue = 0;
  double pVP = 0;
  double profitabilityMonth = 0;

  Fii(
      {required this.name,
      required this.value,
      required this.liquidity,
      required this.lastYeld,
      required this.dividendYeld,
      required this.netWorth,
      required this.bookValue,
      required this.pVP,
      required this.profitabilityMonth});

  Fii.liquid(
      {required this.name,
      required this.liquidity,
      required this.lastYeld,
      required this.dividendYeld,
      required this.netWorth,
      required this.bookValue,
      required this.pVP,
      required this.profitabilityMonth});
}
