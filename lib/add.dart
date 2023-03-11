import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:s_v/main.dart';

class addItems extends StatefulWidget {
  const addItems({super.key});

  @override
  State<addItems> createState() => _addItemsState();
}

class _addItemsState extends State<addItems> {
  TextEditingController _sku = TextEditingController();
  TextEditingController _cs = TextEditingController();
  TextEditingController _itn = TextEditingController();
  TextEditingController _site = TextEditingController();
  TextEditingController _qty = TextEditingController();
  

  var sites = [
    "Workstation 1",
    "Workstation 2",
    "Workstation 3",
    "Workstation 4"
  ];
  final List<String> sku = <String>[];
  final List<String> cs = <String>[];
  final List<String> iname = <String>[];

  void addItemToList() {
    setState(() {
      sku.insert(0, _sku.text);
      cs.insert(0, _cs.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select item'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          TextFormField(
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Please enter contact';
            //   }
            //   return null;
            // },
            controller: _sku,
            keyboardType: TextInputType.number,

            decoration: const InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
              hintText: 'SKU No.',
            ),
          ),
          TextFormField(
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Please enter contact';
            //   }
            //   return null;
            // },
            controller: _cs,
            keyboardType: TextInputType.text,

            decoration: const InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.assignment),
              hintText: 'Current stock',
            ),
          ),
          TextFormField(
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Please enter contact';
            //   }
            //   return null;
            // },
            controller: _itn,
            keyboardType: TextInputType.text,

            decoration: const InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.checkroom),
              hintText: 'Item name',
            ),
          ),
          TextFormField(
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Please enter contact';
            //   }
            //   return null;
            // },
            controller: _site,
            keyboardType: TextInputType.text,

            decoration: InputDecoration(
              filled: true,
              border: const OutlineInputBorder(),
              suffixIcon: PopupMenuButton<String>(
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                onSelected: (String value) {
                  _site.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return sites.map<PopupMenuItem<String>>((String value) {
                    return PopupMenuItem(value: value, child: Text(value));
                  }).toList();
                },
              ),
              hintText: 'Work site',
            ),
            readOnly: true,
          ),
          TextFormField(
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Please enter contact';
            //   }
            //   return null;
            // },
            controller: _qty,
            keyboardType: TextInputType.number,

            decoration: const InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.numbers),
              hintText: 'Qty',
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    addItemToList();
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage(sku: _sku.text, cs: _cs.text, iname: _itn.text, wsite: _site.text, qty: _qty.text)));
                  },
                  child: const Text('Add')),
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
              }, child: const Text('cancel')),
            ],
          ),
          ListView.builder(
              
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: sku.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.all(2),
                  child: ClipPath(
                    clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3))),
                    child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(color: Colors.brown, width: 5))),
                  child: Text(
                    'SKU : ${sku[index]}' ,
                    style: TextStyle(fontSize: 18),
                  ),
                    ),
                  ),
                );
              }),
          // Card(
          //     elevation: 10,
          //     child: ClipPath(
          //       clipper: ShapeBorderClipper(
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(3))),
          //       child: Container(
          //         padding: const EdgeInsets.all(16),
          //         decoration: const BoxDecoration(
          //             border: Border(
          //                 left: BorderSide(color: Colors.teal, width: 5))),
          //         child: const Text("hi"),
          //       ),
          //     ),
          //   ),
        ]),
      ),
    );
  }
}
