import 'dart:math';
import 'package:cinema_application/Screens/transition_screen.dart';
import 'package:cinema_application/components/default_button.dart';
import 'package:cinema_application/data/Selected%20Seats.dart';
import 'package:cinema_application/data/profileData.dart';
import 'package:cinema_application/models/movie_model.dart';
import 'package:cinema_application/models/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

int _value=1;
late int price;
late int initialPrice;
late int initialPoints;
bool check=false;

final cardNumKey = GlobalKey<FormFieldState>();
final cvvKey = GlobalKey<FormFieldState>();
final edKey = GlobalKey<FormFieldState>();
final chnKey = GlobalKey<FormFieldState>();

Widget paymentSheet({required MovieModel movie,required int countTickets,required String titleDateParty}) {
  initialPoints=points;
  price = 100 * countTickets;
  initialPrice = 100 * countTickets;

  return Scaffold(
    backgroundColor: Colors.grey[900],
    resizeToAvoidBottomInset: false,
    body: SafeArea(
      child: StatefulBuilder(builder: (context, setState) =>
          Padding(
            padding: const EdgeInsets.fromLTRB(
                20, 10, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment
                  .start,
              children: [
                const SizedBox(height: 80,),
                const Text(
                  "Payment", style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),),
                const SizedBox(height: 30,),
                const Text(
                    "Select a payment method",
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight
                            .w400,
                        color: Colors.white70)),
                const SizedBox(height: 20,),
                Row(children: [
                  Radio<int>(
                      fillColor: MaterialStateColor.resolveWith((states) =>
                      Colors.blueAccent),
                      value: 1,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                      }
                  ),
                  SizedBox(
                      height: 30, width: 90,
                      child: Image.asset(
                          'assets/image/Visa.png')
                  ),
                  const SizedBox(width: 20,),
                  Radio<int>(
                      fillColor: MaterialStateColor
                          .resolveWith((states) =>
                      Colors.blueAccent),
                      value: 2,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                      }),
                  SizedBox(
                      height: 45, width: 100,
                      child: Image.asset(
                          'assets/image/MC.png')),

                ],),
                const SizedBox(height: 20,),
                const Text("Card Number",
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight
                            .w400,
                        color: Colors.white70)),
                const SizedBox(height: 10,),
                TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CardNumberFormatter(),
                      LengthLimitingTextInputFormatter(19),
                    ],
                    key: cardNumKey,
                    validator: (value) {
                      if (value!.length != 19) {
                        return "16 Digits Must Be Inserted";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        color: Colors.white),
                    decoration: const InputDecoration(
                      fillColor: Color(
                          0xff302d2d),
                      filled: true,
                      prefixIcon: Icon(
                        Icons
                            .credit_card_outlined,
                        color: Colors
                            .orangeAccent,
                      ),
                    )
                ),
                const SizedBox(height: 20,),
                Row(
                  children: const [
                    Text("Valid Until",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight
                                .w400,
                            color: Colors
                                .white70)),
                    SizedBox(width: 120,),
                    Text("CVV", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight
                            .w400,
                        color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Field Cannot Be Empty";
                            }

                            if (value.length != 5) {
                              return "Invalid Input.";
                            }
                            String month = value[0] + value[1];

                            if (int.parse(month) < 1 || int.parse(month) > 12 ||
                                value[2] != '/') {
                              return "Invalid Input.";
                            }
                            return null;
                          },
                          key: edKey,
                          style: const TextStyle(
                              color: Colors
                                  .white),
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors
                                    .white70),
                            hintText: "MM/YY",
                            fillColor: Color(
                                0xff302d2d),
                            filled: true,)),
                    ),
                    const SizedBox(width: 10,),
                    SizedBox(
                      width: 160,
                      child: TextFormField(
                          key: cvvKey,
                          validator: (value) {
                            if (value!.length != 3) {
                              return "3 Digits Must Be Inserted";
                            }
                            return null;
                          },
                          obscureText: true,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: Colors
                                  .white),
                          decoration: const InputDecoration(
                            fillColor: Color(
                                0xff302d2d),
                            filled: true,)),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                const Text("Card Holder Name",
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight
                            .w400,
                        color: Colors.white70)),
                const SizedBox(height: 10,),
                TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field Cannot Be Empty";
                      }
                      else {
                        for (int i = 0; i < value.length; i++) {
                          if (value[i] != ' ' && !RegExp(r'^[a-zA-Z]').hasMatch(
                              value[i])) {
                            return "Invalid Input";
                          }
                        }
                        return null;
                      }
                    },
                    key: chnKey,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      fillColor: Color(0xff302d2d), filled: true,)
                ),
                const SizedBox(height: 30,),
                points > 0 ?
                CheckboxListTile(

                    side: const BorderSide(color: Colors.white),
                    value: check,
                    title: Text("Apply a discount of " +
                        (min(initialPoints, initialPrice)).toString() +
                        " using points.",
                      style: const TextStyle(color: Colors.white),),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.blueAccent,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          price = (100 * countTickets) - min(initialPoints, initialPrice);
                        }
                        else {
                          price = initialPrice;
                          points = initialPoints;
                        }
                        check = value!;
                      });
                    }) : const SizedBox(),
                const SizedBox(height: 30,),
                Center(
                    child: defaultButton(
                        text: "\$" + price.toString(),
                        textColor: Colors.white,
                        background: Colors.orangeAccent,
                        radius: 30,
                        width: 200,
                        function: () {
                          final isValidCardNum = cardNumKey.currentState!.validate();
                          final isValidCvv = cvvKey.currentState!.validate();
                          final isValidEd = edKey.currentState!.validate();
                          final isValidChn = chnKey.currentState!.validate();
                          if (isValidCardNum && isValidCvv && isValidEd && isValidChn) {

                            createTicket(movie: movie, countTickets: countTickets);

                            for (int i=0;i<selectedSeats.length;i++){
                              FirebaseFirestore.instance.collection(titleDateParty).doc(selectedSeats[i]).update({"status":"taken"});
                            }

                            selectedSeats.clear();

                            Navigator.push(context, MaterialPageRoute(builder: (context) => TransitionScreen()));

                            final snackBar1 = SnackBar(
                              backgroundColor: Colors.green,
                              content: SizedBox(
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.check, color: Colors.white),
                                    Text("Payment was successful", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                  ],
                                ),
                              ),
                            );

                            final snackBar2 = SnackBar(
                              backgroundColor: Colors.green,
                              content: SizedBox(
                                height: 30,
                                child: Center(
                                  child: Text("You Earned "+ (countTickets*10).toString()+" Points!", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                                ),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                            ScaffoldMessenger.of(context).showSnackBar(snackBar2);

                            points -= min(initialPoints, initialPrice);
                            points+=countTickets*10;

                            FirebaseFirestore.instance.collection("Points").doc(emailAddress).update({"points":points});

                          }
                        })
                ),
              ],
            ),
          ),
      ),
    ),
  );
}

Future createTicket({required MovieModel movie,required int countTickets}) async{
  final docRev=FirebaseFirestore.instance.collection(emailAddress+" Tickets").doc();
  DateTime today = DateTime.now();
  String dateStr = "${today.day}-${today.month}-${today.year}";
  final ticket=Ticket(image: movie.image!,title: movie.title,dateOfBooking: dateStr ,seatCount: countTickets);
  final jason=ticket.toJason();
  docRev.set(jason);
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}