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
      });
    }
  }

  void addItemToList() async {
    String encodedURl = AppCommon.hostName +
        "/DataLoad/SaveWorkRole?wRoleID="+ roleId.toString() +"&wRoleName=" +
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
      roleId=0;
      wrole.text = "";
      lstRoles = _LstRoles;
    });
  }

  void deleteItem(int index) {
    setState(() {
      lstRoles.removeAt(index);
      // workrole.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.save)],
        title: const Text('Work Role'),
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
                      return 'Please enter work role!';
                    }
                    return null;
                  },
                  controller: wrole,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.person),
                    hintText: 'Work role',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            addItemToList();
                          }
                        },
                        child: const Text('Add')),
                        Spacer(),
                        
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                  ],
                ),
              ),
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
                  itemCount: lstRoles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 60,
                      child: Card(
                        elevation: 10,

                        //  margin: const EdgeInsets.all(10),
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3))),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: Colors.brown, width: 5))),
                            child: Row(
                              children: [
                                Text(
                                  lstRoles[index].WorkRoleName,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        roleId= lstRoles[index].WRole_ID;
                                        wrole.text =
                                            lstRoles[index].WorkRoleName;
                                      });
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      deleteItem(index);
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            ),
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
