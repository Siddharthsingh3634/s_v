
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:s_v/itemaddgrp.dart';

class itemG extends StatefulWidget {
  const itemG({super.key});

  @override
  State<itemG> createState() => _itemGState();
}

class _itemGState extends State<itemG> {
List<String> lstIG = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const itemAdd()),
          );
        },
        focusElevation: 100,
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
      appBar: AppBar(title: Text('Item Group'),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Expanded(
            //     child: ListView.builder(
            //         physics: const ScrollPhysics(),
            //         scrollDirection: Axis.vertical,
            //         shrinkWrap: true,
            //         padding: const EdgeInsets.all(8),
            //         itemCount: lstIG.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           return SizedBox(
            //             height:MediaQuery.of(context).size.height*0.08,
                        
            //             child: Card(
            //               elevation: 10,
            //               shadowColor: Colors.blueGrey,
      
            //               //  margin: const EdgeInsets.all(1),
            //               child: ClipPath(
            //                 clipper: ShapeBorderClipper(
            //                     shape: RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(5))),
            //                 child: Container(
            //                   padding: const EdgeInsets.all(5),
            //                   decoration: const BoxDecoration(
            //                       gradient: LinearGradient(
            //                           begin: Alignment.centerLeft,
            //                           end: Alignment.centerRight,
            //                           colors: [
            //                             Colors.blueGrey,
            //                             Colors.white,
            //                             Colors.white,
            //                             Colors.white,
            //                             Colors.white,
            //                             Colors.white,
            //                              Color.fromARGB(160, 248, 166, 166),
            //                           ]),
            //                       border: Border(
            //                           left: BorderSide(
            //                               color: Colors.blueGrey, width: 2))),
            //                   child: Row(
            //                     children: [
            //                       IconButton(
            //                           onPressed: () {
            //                             // setState(() {
            //                               // roleId = lstIG[index].WRole_ID;
            //                               // wrole.text =
            //                               //     lstRoles[index].WorkRoleName;
            //                             // });
            //                           },
            //                           icon: const Icon(Icons.edit_outlined,
            //                               color: Colors.blue)),
            //                       // Text(
            //                       //   lstIG[index].WorkRoleName,
            //                       //   style: const TextStyle(fontSize: 18),
            //                       // ),
            //                       Spacer(),
            //                       IconButton(
            //                           onPressed: () {
            //                             // deleteItem(lstRoles[index].WRole_ID);
            //                           },
            //                           icon: Icon(Icons.delete_outline,
            //                               color:
            //                                   Color.fromARGB(255, 241, 119, 110)))
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           );
            //         }),
            //   ),
        ]),
      ),
    );
  }
}