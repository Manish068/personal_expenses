import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalAmount;
  final double totalSpendPctAmount;

  ChartBar(this.label, this.totalAmount, this.totalSpendPctAmount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            //to show zero decimal places and make the amount roundOff
            SizedBox(height:constraints.maxHeight*0.15,child: FittedBox(child: Text("\₹${totalAmount.toStringAsFixed(0)}"))),
             SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            SizedBox(
              width: 10,
              height: constraints.maxHeight * 0.6,
              child: Stack(
                children: [
                  //Empty bar
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  //filled bar according to totalSpending
                  FractionallySizedBox(
                    alignment: Alignment.bottomRight,
                    heightFactor: totalSpendPctAmount,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
             SizedBox(
              height:  constraints.maxHeight * 0.05,
            ),
            //day label
            SizedBox(height:constraints.maxHeight * 0.15,child: FittedBox(child: Text(label)))
          ],
        );
      },
    );
  }
}
