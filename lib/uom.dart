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
  @override
  TextEditingController _uomName = TextEditingController();
  TextEditingController _uomCode = TextEditingController();
  List<Uom> lstUom = [];

  final formKey = GlobalKey<FormState>();

  String uomId = '';

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
        uomId = '';
        lstUom = _LstUom;
      });
    }
  }

  void addUomList() async {
    String encodedURl = AppCommon.hostName +
        "/DataLoad/SaveUOM?UomCode=" +
        _uomCode.text +
        "&UomName=" +
        _uomName.text +
        "&oldUomCode=" +
        uomId;

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
      uomId = '';

      lstUom = _LstUom;
    });
    _uomCode.clear();
    _uomName.clear();
    FocusScope.of(context).unfocus();
  }

  void deleteItem(String uomId) async {
    String encodedURl =
        AppCommon.hostName + "/List/DeleteUOM?UOMCode=" + uomId.toString();

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
      // uom.removeLast();
      lstUom = _LstUom;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  LoadUomList();
                  _uomCode.clear();
                  _uomName.clear();
                  FocusScope.of(context).unfocus();
                },
                icon: Icon(Icons.refresh)),
          )
        ],
        title: const Text('Unit of measurement'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: SizedBox(
                    height: 55,
                    child: TextField(
                      
                      maxLength: 4,
                      controller: _uomCode,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        
                        counterText: "",
                        filled: true,
                        fillColor: Color.fromARGB(73, 96, 125, 139),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        hintText: 'Unit code ',
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 12,
                  child: SizedBox(
                    height: 55,
                    child: TextField(
                      maxLength: 20,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please fill this!';
                      //   }
                      //   return null;
                      // },
                      controller: _uomName,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Color.fromARGB(73, 96, 125, 139),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        hintText: 'Unit name',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (_uomCode.text == '' || _uomCode.text == null) {
                  return AppCommon().showAlertWithoutTitleDialog(
                      context, 'Please enter unit code');
                }
                if (_uomName.text == '' || _uomName.text == null) {
                  return AppCommon().showAlertWithoutTitleDialog(
                      context, 'Please enter unit name');
                } else
                  addUomList();
              },
              child: Text(uomId != "" ? 'Update' : 'Add')),
          Expanded(
            child: ListView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: lstUom.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height*0.08,
                    child: Card(
                      elevation: 10,
                      margin: const EdgeInsets.all(2),
                      child: ClipPath(
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      uomId = lstUom[index].UomCode;
                                      uomId = lstUom[index].UomName;
                                      _uomCode.text = lstUom[index].UomCode;
                                      _uomName.text = lstUom[index].UomName;
                                    });
                                  },
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue)),
                              Text(
                                '${lstUom[index].UomName} (${lstUom[index].UomCode})',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    deleteItem(lstUom[index].UomCode);
                                  },
                                  icon: const Icon(Icons.delete_outline,
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
    );
  }
}
