import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  bool _isEnabled = false;
  bool _editI = false;

  Cicn() {
    _isEnabled = !_isEnabled;

    // Icon(Icons.alarm_add_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListTile(
          title: TextField(
            enabled: _isEnabled,
            decoration: InputDecoration(
                hintText: 'Enter a text',
                ),
          ),
      
          // The icon button which will notify list item to change
          trailing: GestureDetector(
            child:  Icon(
              Icons.edit,
              color: Colors.black,
              
            ),
            onTap: () {
              setState((){
                 Cicn();
              });
            },
          ),
        ),
      ),
    );
  }
}
