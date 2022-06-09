// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import './divider_card.dart';
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
  
  final _amountFormKey = GlobalKey<FormState>(); // for amount form validation
  final _formKey = GlobalKey<FormState>();  // for divider form validation
  final bool _validateAmount = false;
  final bool _validateDivider =  false;

  double currentPercentTotal = 0; // to help with validating total percentage (up to 100 only)

  //used for validation of input
  List<MoneyDivider> moneyDividerList = [];
  
  //function to validate if string is a number
  bool f_isNumeric(String result) {
    return double.tryParse(result) != null;
  }

  Widget w_buildAmountTextField() {
    return TextFormField(
      controller: _totalAmount,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: 'Amount',
      errorText: _validateAmount ? 'Value can\'t be empty' : null),
      validator: (value) {
        
        //validates if value in controller/textfield is not empty
        if (value == null || value.isEmpty) {
          return 'Amount cannot be empty!';
        }

        //checks if input is integer (for amount)
        if (!f_isNumeric(value)) {
          return 'Only input numbers!';
        }
        return null;
      },

      // update the divided amounts (if there are any) if the amount changes
      onChanged: (textfieldValue) {
        if (f_isNumeric(_totalAmount.text) || _totalAmount.text.isEmpty) {

          setState(() {}); // call setstate to rebuild the divider list

        } else {

          // show scaffold warning
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enter a valid amount.'),
              duration: Duration(seconds: 2),
            ),
          );

        }
      },
    );
  }

  Widget w_buildDividerTitleTextField(String label) {
    return TextFormField(
      controller: _dividerTitle,
      textInputAction: TextInputAction.next,  // go to next input
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        errorText: _validateDivider ? 'Value can\'t be empty' : null
      ),
      validator: (value) {
        
        //validates if value in controller/textfield is not empty
        if (value == null || value.isEmpty) {
          return '$label cannot be empty!';
        }
        
        return null;
      },
    );
  }

  Widget w_buildDividerPercentTextField(String label) {
    return TextFormField(
      controller: _dividerPercent,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
      errorText: _validateDivider ? 'Value can\'t be empty' : null),
      validator: (value) {
        
        //validates if value in controller/textfield is not empty
        if (value == null || value.isEmpty) {
          return '$label cannot be empty!';
        }

        //checks if input is integer (for integer forms)
        if (!f_isNumeric(value)) {
          return 'Only input numbers!';
        }

        //if budgeting exceeded 100%
        if (currentPercentTotal + double.parse(value) > 100) {
          return 'Budgeting exceeded the 100%';
        }

        return null;
      },
    );
  }

  Widget w_addDividerButton() {
    return InkWell(
      
      child: Container(
        decoration: BoxDecoration(
          gradient: // display different gradient
            const LinearGradient(
              colors: [Colors.red, Colors.purple],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft
            ),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: const Text(
          'Save Divider',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),

      onTap: () {
        // check first if divider form is validated 
        if (_formKey.currentState!.validate()) {

          // create divider
          MoneyDivider moneyDivider = MoneyDivider(
            name: _dividerTitle.text + " (${_dividerPercent.text}%)",
            percentage: double.parse(_dividerPercent.text),
            //percentage: double.parse(_totalAmount.text) * (double.parse(_dividerPercent.text)/100)
          );
        
          setState(() {
            currentPercentTotal += double.parse(_dividerPercent.text);  // increase total percent
            moneyDividerList.add(moneyDivider); // add divider
            _dividerTitle.clear();  // clear the text buttons
            _dividerPercent.clear();
            Navigator.pop(context); // remove the sheet after adding
          });
        }
      },
    );
  }

  Widget w_clearDividerButton() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          gradient: // display different gradient
            const LinearGradient(
              colors: [Colors.red, Colors.purple],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft
            ),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: const Text(
          'Clear',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      onTap: () {
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

  Widget showAddDivider() {
    return InkWell(
      
      child: Container(
        decoration: BoxDecoration(
          gradient: // display different gradient
            const LinearGradient(
              colors: [Colors.red, Colors.purple],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft
            ),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: const Text(
          'Add Divider',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),

      onTap: () {
        // check first if amount is validated
        if (_amountFormKey.currentState!.validate()) {

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
                    child: w_buildDividerTitleTextField('Divider Title'),
                  ),
            
                  // GET DIVIDER PERCENTAGE
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: w_buildDividerPercentTextField('Divider Percent'),
                  ), 
            
                  // ADD BUTTON
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        
                        // SAVE DIVIDER BUTTON
                        w_addDividerButton(),

                        // CLOSE BUTTON
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: // display different gradient
                                const LinearGradient(
                                  colors: [Colors.red, Colors.purple],
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft
                                ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            child: const Text(
                              'Close',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),

                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),

                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          );
        }
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
                child: Form(
                  key: _amountFormKey,
                  child: w_buildAmountTextField(),
                ),
              ),
              
              // ROW OF BUTTONS
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    showAddDivider(),
                    w_clearDividerButton(),
                  ],
                ),
              ),

              // WILL SHOW THE DIVIDERS
              ...(moneyDividerList).map((divider) {
                return DividerCard(
                  totalAmount: _totalAmount.text,
                  divider: divider
                );
              }).toList(),
              
            ],
          ),
        ),
    );
  }
}

