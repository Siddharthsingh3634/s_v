import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:s_v/add.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'Check-out'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          size: 30,
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: const Text(
                        "Event Date: ",
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
                        //     return 'Please insert date';
                        //   }
                        //   return null;
                        // },
                        controller: sed, //editing controller of this TextField
                        decoration: InputDecoration(
                            filled: true,
                            hoverColor: Colors.blue.shade100,
                            border: const OutlineInputBorder(),
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
                          hoverColor: Colors.blue.shade100,
                          border: const OutlineInputBorder(),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
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
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: const Text(
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
                          hoverColor: Colors.blue.shade100,
                          border: const OutlineInputBorder(),
                          suffixIcon: PopupMenuButton<String>(
                            icon: const Icon(Icons.arrow_drop_down),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.brown,
              ),
            )
            
          ],
        ),
      ),
    );
  }
}
