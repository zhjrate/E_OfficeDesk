class AttendanceSaveApiRequest {
  String EmployeeID;
  String PresenceDate;
  String TimeIn;
  String TimeOut;
  String LoginUserID;
  String CompanyId;
  String Notes;
  String Latitude;
  String Longitude;
  String LocationAddress;


  /*

EmployeeID:47
PresenceDate:2021-11-21
TimeIn:09:25 AM
TimeOut:5:00 PM
//Notes:Please enter the number.
LoginUserID:admin
//Latitude:1234
//Longitude:2342
//LocationAddress:Sharvaya Infotech
CompanyId:8033

  */

  AttendanceSaveApiRequest({this.EmployeeID,this.PresenceDate,this.TimeIn,this.TimeOut,this.LoginUserID,this.CompanyId,this.Latitude,this.Longitude,this.Notes,this.LocationAddress});

  AttendanceSaveApiRequest.fromJson(Map<String, dynamic> json) {
    EmployeeID = json['EmployeeID'];
    PresenceDate = json['PresenceDate'];
    TimeIn = json['TimeIn'];
    TimeOut = json['TimeOut'];
    LoginUserID = json['LoginUserID'];
    CompanyId = json['CompanyId'];
    Notes = json['Notes'];
    Latitude = json['Latitude'];
    Longitude = json['Longitude'];
    LocationAddress = json['LocationAddress'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeID'] = this.EmployeeID;
    data['PresenceDate'] = this.PresenceDate;
    data['TimeIn'] = this.TimeIn;
    data['TimeOut'] = this.TimeOut;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;
    data['Notes'] = this.Notes;
    data['Latitude'] = this.Latitude;
    data['Longitude'] = this.Longitude;
    data['LocationAddress'] = this.LocationAddress;
    return data;
  }
}