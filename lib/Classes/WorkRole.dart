class WorkRole {
  int WRole_ID;
  String WorkRoleName;

  WorkRole(this.WRole_ID, this.WorkRoleName);

  factory WorkRole.fromJson(Map<String, dynamic> parsedJson) {
    return WorkRole(
        parsedJson["WROLE_ID"] as int, parsedJson["WROLENAME"] as String);
  }
}
