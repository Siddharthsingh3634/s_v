import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class addItems extends StatefulWidget {
  const addItems({super.key});

  @override
  State<addItems> createState() => _addItemsState();
}

class _addItemsState extends State<addItems> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add'),
      ),
      body: ElevatedButton(
          onPressed: () {
            
          },
          child: Text('Show')),
    );
  }
}
