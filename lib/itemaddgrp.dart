import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:s_v/itemgrpsrch.dart';

class itemAdd extends StatefulWidget {
  const itemAdd({super.key});

  @override
  State<itemAdd> createState() => _itemAddState();
}

class _itemAddState extends State<itemAdd> {
  TextEditingController gn = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 6,
                    child: Text(
                      'Group Name: ',
                      style: TextStyle(fontSize: 16),
                    )),
                Expanded(
                  flex: 12,
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      // maxLength: 50,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return ;
                      //   }
                      //   return null;
                      // },
                      controller: gn,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Color.fromARGB(73, 96, 125, 139),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3)),
                        // suffixIcon: Icon(Icons.),
                        hintText: 'Work role',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(
                        40), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const igis()));
                  },
                  child: Text('Add Item')),
            )
          ],
        ),
      ),
    );
  }
}
