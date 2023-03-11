import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:s_v/uom.dart';
import 'package:s_v/workrolepage.dart';

import 'add.dart';
import 'itemgrplst.dart';

class checkOut extends StatefulWidget {
  



  @override
  State<checkOut> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<checkOut> {
  TextEditingController sed = TextEditingController();
  TextEditingController bor = TextEditingController();
  TextEditingController req = TextEditingController();
  bool check1 = false;
  var items = [
    "Neha",
    "Jeni",
    "Siddharth",
    "Tithi",
    "Rishita",
    "Sagar",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const addItems()),
          );
        },
        focusElevation: 100,
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
      appBar: AppBar(
        title: Text('Check-out'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // ignore: prefer_const_constructors
                  Expanded(
                    flex: 1,
                    child: const Text(
                      "Event Date:",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please insert date';
                        //   }
                        //   return null;
                        // },
                        controller: sed, //editing controller of this TextField
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(73, 96, 125, 139),
                            hoverColor: Colors.blue.shade100,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3)),
                            // icon: Icon(Icons.calenda), //icon of text field
                            hintText: "Select date",
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime
                                          .now(), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));

                                  if (pickedDate != null) {
                                    //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('dd-MM-yyy')
                                            .format(pickedDate);
                                    Colors.black;
                                    //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      sed.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                                icon: const Icon(
                                    Icons.calendar_month)) //label text of field
                            ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: const Text(
                        "Borrower: ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter contact';
                        //   }
                        //   return null;
                        // },
                        controller: bor,
                        keyboardType: TextInputType.text,

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(73, 96, 125, 139),
                          hoverColor: Colors.blue.shade100,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
                          suffixIcon: PopupMenuButton<String>(
                            icon: const Icon(Icons.arrow_drop_down),
                            onSelected: (String value) {
                              bor.text = value;
                            },
                            itemBuilder: (BuildContext context) {
                              return items
                                  .map<PopupMenuItem<String>>((String value) {
                                return PopupMenuItem(
                                    value: value, child: Text(value));
                              }).toList();
                            },
                          ),
                          hintText: 'Borrower name',
                        ),
                        readOnly: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: check1,
                    onChanged: (bool? isChecked) {
                      //value returned when checkbox is clicked
                      setState(() {
                        check1 = isChecked!;
                        req.text = bor.text;
                      });
                    },
                  ),
                  const Text(
                    'Requester is same as borrower',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Requester: ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: req,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(73, 96, 125, 139),
                          hoverColor: Colors.blue.shade100,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
                          suffixIcon: PopupMenuButton<String>(
                            icon: Icon(Icons.arrow_drop_down),
                            onSelected: (String value) {
                              req.text = value;
                            },
                            itemBuilder: (BuildContext context) {
                              return items
                                  .map<PopupMenuItem<String>>((String value) {
                                return PopupMenuItem(
                                    value: value, child: Text(value));
                              }).toList();
                            },
                          ),
                          hintText: 'Requester name',
                        ),
                        readOnly: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const workRole()),
                  );
                },
                child: Text('Workrole')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const uom()),
                  );
                },
                child: Text('UOM')),
                ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const itemG()),
                  );
                },
                child: Text('ItemGroup')),
            // Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Divider(
            //     color: Colors.blueGrey,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       SizedBox(
            //         width: MediaQuery.of(context).size.width * 0.9,
            //         child: Card(
            //           elevation: 40,
            //           margin: EdgeInsets.all(2),
            //           child: ClipPath(
            //             clipper: ShapeBorderClipper(
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(3))),
            //             child: Container(
            //               padding: const EdgeInsets.all(16),
            //               decoration: const BoxDecoration(
            //                   border: Border(
            //                       left: BorderSide(
            //                           color: Colors.blueGrey, width: 5))),
            //               child: Column(
            //                 children: [
                              
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
