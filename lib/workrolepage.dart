import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:s_v/Classes/WorkRole.dart';

import 'AppCommon.dart';

// ignore: camel_case_types
class workRole extends StatefulWidget {
  const workRole({super.key});

  @override
  State<workRole> createState() => _workRoleState();
}

// ignore: camel_case_types
class _workRoleState extends State<workRole> {
  TextEditingController wrole = TextEditingController();
  final List<String> workrole = <String>[];
  final formKey = GlobalKey<FormState>();
  List<WorkRole> lstRoles = [];
  int counter = 200;

  int roleId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadWorkRoleList();
  }

  void LoadWorkRoleList() async {
    String encodedURl = AppCommon.hostName + "/List/GetWorkRoleList";

    http.Response response = await http
        .post(Uri.parse(encodedURl), headers: {"Accept": "application/json"});

    var data = json.decode(response.body);

    if (data["StatusVal"] == false) {
      AppCommon().showErrorAlertDialog(context, data["StatusMsg"]);
      return;
    } else {
      var parsedDept = data["Data"].cast<Map<String, dynamic>>();
      List<WorkRole> _LstRoles =
          parsedDept.map<WorkRole>((json) => WorkRole.fromJson(json)).toList();

      setState(() {
        lstRoles = _LstRoles;
        roleId = 0;
      });
    }
  }

  void addItemToList() async {
    String encodedURl = AppCommon.hostName +
        "/DataLoad/SaveWorkRole?wRoleID=" +
        roleId.toString() +
        "&wRoleName=" +
        wrole.text;

    http.Response response = await http
        .post(Uri.parse(encodedURl), headers: {"Accept": "application/json"});

    var data = json.decode(response.body);
    if (data["StatusVal"] == false) {
      AppCommon().showErrorAlertDialog(context, data["StatusMsg"]);
      return;
    }

    var parsedDept = data["Data"].cast<Map<String, dynamic>>();
    List<WorkRole> _LstRoles =
        parsedDept.map<WorkRole>((json) => WorkRole.fromJson(json)).toList();

    setState(() {
      roleId = 0;
      wrole.text = "";
      lstRoles = _LstRoles;
    });
    wrole.clear();
    FocusScope.of(context).unfocus();
  }

  void deleteItem(int WRole_ID) async {
    String encodedURl = AppCommon.hostName +
        "/List/DeleteWorkRole?wRoleID=" +
        WRole_ID.toString();

    http.Response response = await http
        .post(Uri.parse(encodedURl), headers: {"Accept": "application/json"});

    var data = json.decode(response.body);
    if (data["StatusVal"] == false) {
      AppCommon().showErrorAlertDialog(context, data["StatusMsg"]);
      return;
    }

    var parsedDept = data["Data"].cast<Map<String, dynamic>>();
    List<WorkRole> _LstRoles =
        parsedDept.map<WorkRole>((json) => WorkRole.fromJson(json)).toList();

    setState(() {
      // roleId = 0;
      // wrole.text = "";
      lstRoles = _LstRoles;
    });
    // setState(() {
    //   lstRoles.removeAt(index);
    //   // workrole.removeLast();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  LoadWorkRoleList();
                  wrole.clear();
                  FocusScope.of(context).unfocus();
                },
                icon: Icon(Icons.refresh_outlined)),
          )
        ],
        title: const Text('Work Role'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: TextFormField(
                            maxLength: 50,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return ;
                            //   }
                            //   return null;
                            // },
                            controller: wrole,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              
                              fillColor: Color.fromARGB(73, 96, 125, 139),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              suffixIcon: Icon(Icons.person),
                              hintText: 'Work role',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                            onPressed: () {
                              if (wrole.text == "" || wrole.text == null) {
                                return AppCommon().showAlertWithoutTitleDialog(
                                    context, 'Please enter role!!');
                              }
                              addItemToList();
                            },
                            child: Text(roleId > 0 ? 'Update' : 'Add')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15.0, right: 15),
            //   child: Row(
            //     children: [

            //       const Spacer(),
            //       if (roleId > 0)
            //         ElevatedButton(
            //             onPressed: () {
            //               setState(() {
            //                 roleId = 0;
            //                 wrole.text = "";
            //               });
            //             },
            //             child: const Text('Cancel')),
            //       // ElevatedButton(
            //       // onPressed: () {

            //       // },
            //       // child: const Text('Update')),
            //     ],
            //   ),
            // ),
            // const Padding(
            //   padding: EdgeInsets.all(8),
            //   child: Divider(
            //     color: Colors.blueGrey,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 6, bottom: 10),
              child: Row(
                children: [
                  Text(
                    'Total no. of roles :- ${lstRoles.length}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: lstRoles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height:MediaQuery.of(context).size.height*0.08,
                      
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.blueGrey,

                        //  margin: const EdgeInsets.all(1),
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.blueGrey,
                                      Colors.white,
                                      Colors.white,
                                      Colors.white,
                                      Colors.white,
                                      Colors.white,
                                    ]),
                                border: Border(
                                    left: BorderSide(
                                        color: Colors.blueGrey, width: 2))),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        roleId = lstRoles[index].WRole_ID;
                                        wrole.text =
                                            lstRoles[index].WorkRoleName;
                                      });
                                    },
                                    icon: const Icon(Icons.edit_outlined,
                                        color: Colors.blue)),
                                Text(
                                  lstRoles[index].WorkRoleName,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      deleteItem(lstRoles[index].WRole_ID);
                                    },
                                    icon: Icon(Icons.delete_outline,
                                        color:
                                            Color.fromARGB(255, 241, 119, 110)))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
