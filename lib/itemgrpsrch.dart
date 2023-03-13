import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class igis extends StatefulWidget {
  const igis({super.key});

  @override
  State<igis> createState() => _igisState();
}

class _igisState extends State<igis> {
TextEditingController tsku = TextEditingController();
TextEditingController tpc = TextEditingController();
TextEditingController sbin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Item'),
      actions: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.assignment_outlined)),
      )],),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SizedBox(
                  height: 55,
                  child: TextFormField(
                    
                    controller: tsku,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: Color.fromARGB(73, 96, 125, 139),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3)),
                      // suffixIcon: Icon(Icons.person),
                      hintText: 'Type SKU',
                    ),
                  ),
                ),
              ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: SizedBox(
                      height: 55,
                      child: TextFormField(
                       
                        controller: tpc,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Color.fromARGB(73, 96, 125, 139),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
                          // suffixIcon: Icon(Icons.person),
                          hintText: 'Type Product Code',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      height: 55,
                      child: TextFormField(
                        controller: sbin,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Color.fromARGB(73, 96, 125, 139),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
                          

                          hintText: 'Search by Item Name',
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),

    );
  }
}