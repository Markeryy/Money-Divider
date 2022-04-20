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

  double currentPercentTotal = 0; // to help with validating total percentage (up to 100 only)

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
          return '$label cannot be empty!';
        }

        //checks if input is integer (for integer forms)
        if ((_controller == _totalAmount || _controller == _dividerPercent) && !_isNumeric(value)) {
          return 'Only input numbers!';
        }

        //if budgeting exceeded 100%
        if (_controller == _dividerPercent && (currentPercentTotal + double.parse(value) > 100)) {
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
            currentPercentTotal += double.parse(_dividerPercent.text);  // increase total percent
            moneyDividerList.add(moneyDivider); // add divider
            _dividerTitle.clear();  // clear the text buttons
            _dividerPercent.clear();
          });
        }
      },
    );
  }

  Widget showAddDivider() {
    return ElevatedButton(
      child: const Text('Add Divider'),
      onPressed: () {
        
        // VALIDATOR FOR ENTERING AMOUNT
        if (!_isNumeric(_totalAmount.text)) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enter a valid amount.'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }

        // BOTTOM SHEET
        showModalBottomSheet(
          context: context,
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              children: [
          
                // GET DIVIDER TITLE
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                  child: buildTextField('Divider Title', _dividerTitle),
                ),
          
                // GET DIVIDER PERCENTAGE
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: buildTextField('Divider Percent', _dividerPercent)
                ), 
          
                // ADD BUTTON
                
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      addDividerButton(),
                      ElevatedButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                
              ]
            ),
          ),
        );

      },
    );
  }

  Widget clearDividerButton() {
    return ElevatedButton(
      child: const Text('Clear'),
      onPressed: () {
        setState(() {
          currentPercentTotal = 0;
          moneyDividerList.clear(); // clear the percentage
          _totalAmount.clear();     // clear the text fields
          _dividerTitle.clear();    
          _dividerPercent.clear();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),

        child: SingleChildScrollView(
          child: Column(
            children: [
        
              // GET AMOUNT
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: const Text(
                  'Enter amount to be divided',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30
                  ),
                )
              ),

              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: buildTextField('Amount', _totalAmount),
              ),
              
              // ROW OF BUTTONS
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showAddDivider(),
                    clearDividerButton(),
                  ],
                ),
              ),

              // WILL SHOW THE DIVIDERS
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
              
            ],
          ),
        ),
    );
  }
}

