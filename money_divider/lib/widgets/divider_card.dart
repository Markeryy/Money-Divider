import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  late Color _randomColor;

  @override
  void initState() {
    super.initState();
    _randomColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _randomColor,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.divider.name ?? "",
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.totalAmount.isEmpty
              ? '0'
              : (double.parse(widget.totalAmount) * widget.divider.percentage/100).toString(),

              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),

            ),
          )

        ],
      ),
    );
  }
}