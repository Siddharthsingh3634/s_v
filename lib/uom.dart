// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:s_v/Classes/UnitofMeasurement.dart';

import 'AppCommon.dart';

// ignore: camel_case_types
class uom extends StatefulWidget {
  const uom({super.key});

  @override
  State<uom> createState() => _uomState();
}

// ignore: camel_case_types
class _uomState extends State<uom> {
  TextEditingController _uom = TextEditingController();
  final List<String> uom = <String>[];
  List<Uom> lstUom = [];
  final formKey = GlobalKey<FormState>();

  int uomId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadUomList();
  }

  void LoadUomList() async {
    String encodedURl = AppCommon.hostName + "/List/GetUOMList";

    http.Response response = await http
        .post(Uri.parse(encodedURl), headers: {"Accept": "application/json"});

    var data = json.decode(response.body);

    if (data["StatusVal"] == false) {
      AppCommon().showErrorAlertDialog(context, data["StatusMsg"]);
      return;
    } else {
      var parsedDept = data["Data"].cast<Map<String, dynamic>>();
      List<Uom> _LstUom =
          parsedDept.map<Uom>((json) => Uom.fromJson(json)).toList();

      setState(() {
        lstUom = _LstUom;
      });
    }
  }

  void addUomList() async {
    String encodedURl = AppCommon.hostName +
        "/DataLoad/SaveUOM?UomCode=" +
        uomId.toString() +
        "&UomName=" +
        uomId.toString() +
        "&oldUomCode=" +
        _uom.text;

    // "/DataLoad/SaveUOM?wRoleID=" +
    // roleId.toString() +
    // "&wRoleName=" +
    // _uom.text;

    http.Response response = await http
        .post(Uri.parse(encodedURl), headers: {"Accept": "application/json"});

    var data = json.decode(response.body);
    if (data["StatusVal"] == false) {
      AppCommon().showErrorAlertDialog(context, data["StatusMsg"]);
      return;
    }

    var parsedDept = data["Data"].cast<Map<String, dynamic>>();
    List<Uom> _LstUom =
        parsedDept.map<Uom>((json) => Uom.fromJson(json)).toList();

    setState(() {
      uomId = 0;
      _uom.clear();
      lstUom = _LstUom;
    });
    _uom.clear();
    FocusScope.of(context).unfocus();
  }

  void deleteItem(int index) {
    setState(() {
      uom.removeAt(index);
      // uom.removeLast();
    });
  }

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
              Column(
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
                      controller: _uom,
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
                          addUomList();
                        }
                      },
                      child: const Text('Add')),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
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
                                  // Text(
                                  //   lstUom[index].UomCode,

                                  //   style: const TextStyle(fontSize: 18),

                                  
                                  // ),
                                  Text(
                                    lstUom[index].UomName,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          // uomId= lstRoles[index].WRole_ID;
                                          _uom.text = uom[index];
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
