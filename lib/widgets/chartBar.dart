import "package:flutter/material.dart";

class ChartBar extends StatelessWidget {
  final String _label;
  final double _spendingAmount;
  final double _ratioToTotalSpending;

  ChartBar(this._label, this._spendingAmount, this._ratioToTotalSpending);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints){
        return Column(
      children: <Widget>[
        Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                "₹ ${_spendingAmount.toStringAsFixed(0)}"
              ),
            ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        Container(
          height: constraints.maxHeight * 0.6,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 220, 220, 1),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: _ratioToTotalSpending,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        Container(
          height: constraints.maxHeight * 0.15,
          child: FittedBox(child: Text(_label)),
        ),
      ],
    );
      },
    );
    
  }
}
