import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
  ScrollController _lvb = ScrollController();

  var sites = [
    "Workstation 1",
    "Workstation 2",
    "Workstation 3",
    "Workstation 4"
  ];
  final List<String> list = <String>[];

  void addItemToList() {
    setState(() {
      list.insert(0, _sku.text);
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
            keyboardType: TextInputType.text,

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
            keyboardType: TextInputType.number,

            decoration: InputDecoration(
              filled: true,
              border: const OutlineInputBorder(),
              suffixIcon: PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
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
                  },
                  child: const Text('Add')),
              ElevatedButton(onPressed: () {}, child: const Text('cancel')),
            ],
          ),
          ListView.builder(
              controller: _lvb,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.all(2),
                  child: Center(
                      child: Text(
                    '${list[index]} ',
                    style: TextStyle(fontSize: 18),
                  )),
                );
              })
        ]),
      ),
    );
  }
}
