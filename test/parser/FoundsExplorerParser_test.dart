import 'package:blinvest/models/fii.dart';
import 'package:blinvest/parsers/FoundsExplorerParser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parse data from foundsexplorer pattern', () {
    String foundsExplorerData = simulateData();
    FoundsExplorerParser foundsExplorerParser = FoundsExplorerParser();
    Fii financialIndicator = foundsExplorerParser.convert(foundsExplorerData);
    double expectedLiquidity = 6.738;
    double expectedLastYeld = 1;
    double dividendYeld = 1.2;
    double netWorth = 366.4;
    double bookValue = 98.28;
    double profitabilityMonth = 3.27;
    double pVP = 0.88;

    expect(financialIndicator.liquidity, expectedLiquidity);
    expect(financialIndicator.lastYeld, expectedLastYeld);
    expect(financialIndicator.dividendYeld, dividendYeld);
    expect(financialIndicator.netWorth, netWorth);
    expect(financialIndicator.bookValue, bookValue);
    expect(financialIndicator.profitabilityMonth, profitabilityMonth);
    expect(financialIndicator.pVP, pVP);
  });
}

String simulateData() {
  return """

            
              Liquidez Diária
              
                6.738
              
              negociações
            
            
              Último Rendimento
              
                R\$ 1,00
              
            
            
              Dividend Yield
              
                1,20%
              
            
            
              Patrimônio Líquido
              
                R\$ 366,4 mi
              
            
            
              Valor Patrimonial
              
                R\$ 98,28
              
            
            
              Rentab. no mês
              
                3,27%
              
            
            
              P/VP
              
                0,88
              
            
          """;
}
