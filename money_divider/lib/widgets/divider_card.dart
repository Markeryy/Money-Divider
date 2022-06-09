import 'package:flutter/material.dart';
import '../models/money_divider.dart';

class DividerCard extends StatefulWidget {

  final String totalAmount;
  final MoneyDivider divider;

  const DividerCard({
    Key? key,
    required this.totalAmount,
    required this.divider,
  }) : super(key: key);

  @override
  State<DividerCard> createState() => _DividerCardState();
}

class _DividerCardState extends State<DividerCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      color: //const Color.fromRGBO(115, 70, 86, 1), 
      //const Color.fromRGBO(242, 149, 68, 0.6),
      const Color.fromRGBO(166, 78, 70, 0.6),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(8),
            child: Text(widget.divider.name ?? ""),
          ),

          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.totalAmount.isEmpty
              ? '0'
              : (double.parse(widget.totalAmount) * widget.divider.percentage/100).toString()
            ),
          )

        ],
      ),
    );
  }
}