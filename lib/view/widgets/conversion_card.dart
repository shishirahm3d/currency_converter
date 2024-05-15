import 'package:flutter/material.dart';
import 'package:currency_convertor/utils/utils.dart';
import 'package:currency_convertor/view/widgets/dropdown_row.dart';
import 'package:currency_convertor/view/conversion_history.dart'; // Import conversion_history.dart

class ConversionCard extends StatefulWidget {
  final dynamic rates;
  final Map currencies;

  const ConversionCard({
    Key? key,
    required this.rates,
    required this.currencies,
  }) : super(key: key);

  @override
  State<ConversionCard> createState() => _ConversionCardState();
}

class _ConversionCardState extends State<ConversionCard> {
  TextEditingController amountController = TextEditingController();
  final GlobalKey<FormFieldState> formFieldKey = GlobalKey();
  String dropdownValue1 = 'USD';
  String dropdownValue2 = 'BDT';
  String conversion = '';
  bool isLoading = false;

  void startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  String sanitizeInput(String input) {
    return input.replaceAll(RegExp(r'[,\s]'), '');
  }

  void convertAndDisplay() {
    String sanitizedAmount = sanitizeInput(amountController.text);
    String conversionResult = '$sanitizedAmount $dropdownValue1 = ${Utils.convert(widget.rates, sanitizedAmount, dropdownValue1, dropdownValue2)} $dropdownValue2';
    setState(() {
      conversion = conversionResult;
    });
    addToConversionHistory(conversionResult); // Add to conversion history
    stopLoading();
  }

  void swapCurrencies() {
    setState(() {
      String temp = dropdownValue1;
      dropdownValue1 = dropdownValue2;
      dropdownValue2 = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 50, 25, 25),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: TextFormField(
              key: formFieldKey,
              controller: amountController,
              decoration: InputDecoration(
                hintText: 'Enter Amount',
                hintStyle: TextStyle(color: Colors.black26, fontSize: 25),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an amount';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          DropdownRow(
            label: 'From:',
            labelStyle: TextStyle(color: Colors.white, fontSize: 20),
            value: dropdownValue1,
            currencies: widget.currencies,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue1 = newValue!;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.swap_vert_outlined),
            color: Colors.white,
            iconSize: 40,
            onPressed: () {
              if (amountController.text.isEmpty) {
                swapCurrencies();
              } else {
                swapCurrencies();
                convertAndDisplay();
              }
            },
          ),
          DropdownRow(
            label: 'To:',
            labelStyle: TextStyle(color: Colors.white, fontSize: 20),
            value: dropdownValue2,
            currencies: widget.currencies,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue2 = newValue!;
              });
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (formFieldKey.currentState!.validate()) {
                      startLoading();
                      conversion = '';
                      convertAndDisplay();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF72585)),
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 20)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(7)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                    'Convert',
                    style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 50, height: 20),
          Text(
            conversion,
            style: const TextStyle(color: Colors.white, fontSize: 26),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
