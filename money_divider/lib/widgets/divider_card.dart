import 'dart:math';

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
      child: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(8),
            child: Text(widget.divider.name ?? "None"),
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