import 'package:flutter/material.dart';

import '../models/money_divider.dart';

class GetAmount extends StatefulWidget {
  GetAmount({Key? key}) : super(key: key); 

  @override
  State<GetAmount> createState() => _GetAmountState();
}

class _GetAmountState extends State<GetAmount> {
  final TextEditingController _totalAmount = TextEditingController();
  final TextEditingController _dividerTitle = TextEditingController();
  final TextEditingController _dividerPercent = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();  // to help with validation
  final bool _validate = false;

  double currentPercentTotal = 0;

//used for validation of input
  List<MoneyDivider> moneyDividerList = [];

  //function to validate if string is a number
  bool _isNumeric(String result) {
    return double.tryParse(result) != null;
  }

  Widget buildTextField(String label, TextEditingController _controller) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
      errorText: _validate ? 'Value can\'t be empty' : null),
      validator: (value) {

        //validates if value in controller/textfield is not empty
        if (value == null || value.isEmpty) {
          return '$label, it cannot be empty!';
        }

        //checks if input is integer (for integer forms)
        if ((_controller == _totalAmount || _controller == _dividerPercent) && !_isNumeric(value)) {
          return 'Only input numbers!';
        }

        //if budgeting exceeded 100%
        if (_controller == _dividerPercent && currentPercentTotal + double.parse(value) > 100) {
          return 'Budgeting exceeded the 100%';
        }

        return null;
      },
    );
  }

  Widget addDividerButton() {
    return ElevatedButton(
      child: const Text('Save divider'),
      onPressed: () {

        // if form is validated 
        if (_formKey.currentState!.validate()) {

          // create divider
          MoneyDivider moneyDivider = MoneyDivider(
            name: _dividerTitle.text + " (${_dividerPercent.text}%)",
            percentage: double.parse(_totalAmount.text) * (double.parse(_dividerPercent.text)/100)
          );

          setState(() {
            moneyDividerList.add(moneyDivider); // add divider
            _dividerTitle.clear();  // clear the text buttons
            _dividerPercent.clear();
          });
        }
      },
    );
  }

  Widget clearDividerButton() {
    return ElevatedButton(
      child: const Text('Clear'),
      onPressed: () {
        setState(() {
          moneyDividerList.clear(); // clear the percentage
          _dividerTitle.clear();    // clear the text fields
          _dividerPercent.clear();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
        
              // GET AMOUNT
              const Text('Enter amount to be divided'),
              buildTextField('Amount', _totalAmount),
              
              //moneyDividerList.isEmpty ? const Text('No dividers yet!') 
              //:
              ...(moneyDividerList).map((divider) {
                return Container(
                child: Column(
                  children: [
                    Text(divider.name),
                    Text(divider.percentage.toString())
                  ],
                ),
                );
              }).toList(),
      
              buildTextField('Divider Title', _dividerTitle),     // GET DIVIDER TITLE
              buildTextField('Divider Percent', _dividerPercent), // GET DIVIDER PERCENTAGE
              addDividerButton(),  
              clearDividerButton(),
            ],
          ),
        ),
      ),
    );
  }
}

