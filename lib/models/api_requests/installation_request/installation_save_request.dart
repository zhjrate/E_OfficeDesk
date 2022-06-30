class SaveInstallationRequest {


   String CustomerID;
  String ProductID;
  String OutwardNo;
  String Address;
  String Area;
  String CountryCode;
  String StateCode;
  String CityCode;
  String PinCode;
  String ContactNo;
  String InstallationDate;
  String InstallationPlace;
  String RoomCooling;
  String PowerStabilize;
  String GroundEarthing;
  String LoginUserID;
  String InstallationNo;
  String EmployeeID;
  String TraineeName;
  String TraineeDesg;
  String TraineeDepart;
  String TraineeQuali;
  String AprovedName;
  String AprovedDepart;
  String AprovedDesg;
  String MachineSRno;
  String CompanyId;

/*CustomerID:100191
ProductID:30021
OutwardNo:OT-APR21-004
Address:Dr. Subrahmanyam Saderla Department of aerospace Engineering Kanpur
Area:Kanpur
CountryCode:IND
StateCode:37
CityCode:1469
PinCode:208016
ContactNo:8009210933
InstallationDate:2022-03-21
InstallationPlace:Open Environment
RoomCooling:By Air Condition
PowerStabilize:Stabilizer
GroundEarthing:Test API
LoginUserID:admin
InstallationNo:
EmployeeID:47
TraineeName:Test Traniee Name
TraineeDesg:Test Traniee Desg
TraineeDepart:Test Traniee Dedpart
TraineeQuali:Test TraineeQuali
AprovedName:Test Approved Name
AprovedDepart:Test AprovedDepart
AprovedDesg:Test AprovedDesg 123
MachineSRno:0605teg
CompanyId:11051*/


  SaveInstallationRequest({
    this.AprovedDesg,
    this.AprovedDepart,
    this.CompanyId,
    this.CustomerID,
    this.LoginUserID,
    this.EmployeeID,
    this.Address,
    this.AprovedName,
    this.Area,
    this.CityCode,
    this.ContactNo,
    this.CountryCode,
    this.GroundEarthing,
    this.InstallationDate,
    this.InstallationNo,
    this.InstallationPlace,
    this.MachineSRno,
    this.OutwardNo,
    this.PinCode,
    this.PowerStabilize,
    this.ProductID,
    this.RoomCooling,
    this.StateCode,
    this.TraineeDepart,
    this.TraineeDesg,
    this.TraineeName,
    this.TraineeQuali,


  });

  SaveInstallationRequest.fromJson(Map<String, dynamic> json) {
   CustomerID=json["CustomerID"];
   ProductID=json["ProductID"];
   OutwardNo=json["OutwardNo"];
   Address=json["Address"];
   Area=json["Area"];
   CountryCode=json["CountryCode"];
   StateCode=json["StateCode"];
   CityCode=json["CityCode"];
   PinCode=json["PinCode"];
   ContactNo=json["ContactNo"];
   InstallationDate=json["InstallationDate"];
   InstallationPlace=json["InstallationPlace"];
   RoomCooling=json["RoomCooling"];
   PowerStabilize=json["PowerStabilize"];
   GroundEarthing=json["GroundEarthing"];
   LoginUserID=json["LoginUserID"];
   InstallationNo=json["InstallationNo"];
   EmployeeID=json["EmployeeID"];
   TraineeName=json["TraineeName"];
   TraineeDesg=json["TraineeDesg"];
   TraineeDepart=json["TraineeDepart"];
   TraineeQuali=json["TraineeQuali"];
   AprovedName=json["AprovedName"];
   AprovedDepart=json["AprovedDepart"];
   AprovedDesg=json["AprovedDesg"];
   MachineSRno=json["MachineSRno"];
   CompanyId=json["CompanyId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["CustomerID"] = this.CustomerID;
    data["ProductID"] = this.ProductID;
    data["OutwardNo"] = this.OutwardNo;
    data["Address"] = this.Address;
    data["Area"] = this.Area;
    data["CountryCode"] = this.CountryCode;
    data["StateCode"] = this.StateCode;
    data["CityCode"] = this.CityCode;
    data["LoginUserID"] = this.LoginUserID;
    data["Address"] = this.Address;
    data["PinCode"] = this.PinCode;
    data["ContactNo"] = this.ContactNo;
    data["InstallationDate"] = this.InstallationDate;
    data["InstallationPlace"] = this.InstallationPlace;
    data["RoomCooling"] = this.RoomCooling;
    data["PowerStabilize"] = this.PowerStabilize;
    data["CompanyId"] = this.CompanyId;
    data["GroundEarthing"] = this.GroundEarthing;
    data["LoginUserID"] = this.LoginUserID;
    data["InstallationNo"] = this.InstallationNo;
    data["EmployeeID"] = this.EmployeeID;
    data["TraineeName"] = this.TraineeName;
    data["TraineeDesg"] = this.TraineeDesg;
    data["TraineeDepart"] = this.TraineeDepart;
    data["TraineeQuali"] = this.TraineeQuali;
    data["AprovedName"] = this.AprovedName;
    data["AprovedDepart"] = this.AprovedDepart;
    data["AprovedDesg"] = this.AprovedDesg;
    data["MachineSRno"] = this.MachineSRno;
    data["CompanyId"] = this.CompanyId;

    return data;
  }
}
