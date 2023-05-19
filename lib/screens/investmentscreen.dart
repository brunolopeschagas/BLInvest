import 'package:flutter/material.dart';

import '../controllers/investmentcontroller.dart';
import '../models/investment.dart';

class InvestmentScreen extends StatefulWidget {
  @override
  _InvestmentScreenState createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen> {
  TextEditingController _tickerController = TextEditingController();
  TextEditingController _priceBuyController = TextEditingController();
  TextEditingController _priceSaleController = TextEditingController();
  InvestmentController _investmentController = InvestmentController();
  List<Investment> _investments = [];

  @override
  void initState() {
    super.initState();
    getInvestments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Investments'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    controller: _tickerController,
                    decoration: InputDecoration(labelText: 'Ticker'),
                  ),
                  TextFormField(
                    controller: _priceBuyController,
                    decoration: InputDecoration(labelText: 'Price Buy'),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: _priceSaleController,
                    decoration: InputDecoration(labelText: 'Price Sale'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      saveInvestment();
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _investments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_investments[index].ticker),
                  subtitle: Text('Price Buy: ${_investments[index].priceBuy}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          deleteInvestment(_investments[index].id);
                        },
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {
                          editInvestment(_investments[index]);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  saveInvestment() async {
    if (_tickerController.text.isNotEmpty &&
        _priceBuyController.text.isNotEmpty &&
        _priceSaleController.text.isNotEmpty) {
      await _investmentController.saveInvestment(
          _tickerController.text,
          double.parse(_priceBuyController.text),
          double.parse(_priceSaleController.text));
      clearForm();
      getInvestments();
    }
  }

  getInvestments() async {
    List<Investment> investments = await _investmentController.getInvestments();
    setState(() {
      _investments = investments;
    });
  }

  deleteInvestment(int id) async {
    await _investmentController.deleteInvestment(id);
    getInvestments();
  }

  editInvestment(Investment investment) async {
    _tickerController.text = investment.ticker;
    _priceBuyController.text = investment.priceBuy.toString();
    _priceSaleController.text = investment.priceSale.toString();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Investment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _tickerController,
              decoration: InputDecoration(labelText: 'Ticker'),
            ),
            TextFormField(
              controller: _priceBuyController,
              decoration: InputDecoration(labelText: 'Price Buy'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _priceSaleController,
              decoration: InputDecoration(labelText: 'Price Sale'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              investment.ticker = _tickerController.text;
              investment.priceBuy = double.parse(_priceBuyController.text);
              investment.priceSale = double.parse(_priceSaleController.text);
              await _investmentController.updateInvestment(investment);
              Navigator.pop(context);
              clearForm();
              getInvestments();
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              clearForm();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  clearForm() {
    _tickerController.clear();
    _priceBuyController.clear();
    _priceSaleController.clear();
  }
}
