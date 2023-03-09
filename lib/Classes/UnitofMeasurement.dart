class Uom {
  String UomCode;
  String UomName;
  
  Uom(this.UomCode, this.UomName);

  factory Uom.fromJson(Map<String, dynamic> parsedJson) {
    return Uom(
        parsedJson["UOMCODE"] as String, parsedJson["UOMNAME"] as String);
  }
}
