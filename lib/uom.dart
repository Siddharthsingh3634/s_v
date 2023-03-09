import 'package:flutter/material.dart';

// ignore: camel_case_types
class uom extends StatefulWidget {
  const uom({super.key});

  @override
  State<uom> createState() => _uomState();
}

// ignore: camel_case_types
class _uomState extends State<uom> {
  TextEditingController wrole = TextEditingController();
  final List<String> uom = <String>[];
  final formKey = GlobalKey<FormState>();
  

  void addItemToList() {
    setState(() {
      uom.insert(0, wrole.text);
      // uom.removeLast();
    });
  }
  void deleteItem(int index) {
    setState(() {
      uom.removeAt(index);
      // uom.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit of measurement'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this!';
                    }
                    return null;
                  },
                  controller: wrole,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.person),
                    hintText: 'Unit',
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      addItemToList();
                    }
                  },
                  child: const Text('Add')),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.blueGrey,
                ),
              ),
              ListView.builder(
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: uom.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 10,
                      margin: const EdgeInsets.all(2),
                      child: ClipPath(
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3))),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: Colors.blueGrey, width: 5))),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    uom[index],
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Spacer(),
                                  IconButton(onPressed: (){
                                    deleteItem(index);
                                  }, icon: const Icon(Icons.delete))
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
