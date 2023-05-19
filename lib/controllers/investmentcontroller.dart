import '../models/investment.dart';
import '../services/databasehelper.dart';

class InvestmentController {
  DatabaseHelper dbHelper = DatabaseHelper();

  InvestmentController() {
    dbHelper.initDb();
  }

  saveInvestment(String ticker, double priceBuy, double priceSale) async {
    Investment investment =
        Investment(ticker: ticker, priceBuy: priceBuy, priceSale: priceSale);
    await dbHelper.save(investment);
  }

  Future<List<Investment>> getInvestments() async {
    List<Investment> investments = await dbHelper.getInvestments();
    return investments;
  }

  deleteInvestment(int id) async {
    await dbHelper.delete(id);
  }

  updateInvestment(Investment investment) async {
    await dbHelper.update(investment);
  }
}
