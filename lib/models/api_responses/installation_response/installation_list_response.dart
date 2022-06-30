class InstallationListResponse {
  List<InstallationListDetails> details;
  int totalCount;

  InstallationListResponse({this.details, this.totalCount});

  InstallationListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new InstallationListDetails.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

class InstallationListDetails {
  int rowNum;
  int pkID;
  int customerID;
  String customerName;
  int productID;
  String productName;
  String outwardNo;
  String address;
  String area;
  String countryCode;
  String countryName;
  int stateCode;
  String stateName;
  int cityCode;
  String cityName;
  String pinCode;
  int contactNo;
  String machineSRno;
  String installationDate;
  String installationPlace;
  String roomCooling;
  String powerStabilize;
  String groundEarthing;
  String createdBy;
  String createdDate;
  String installationNo;
  int employeeID;
  String employeeName;
  String traineeName;
  String traineeDesg;
  String traineeDepart;
  String traineeQuali;
  String aprovedName;
  String aprovedDepart;
  String aprovedDesg;

  InstallationListDetails(
      {this.rowNum,
        this.pkID,
        this.customerID,
        this.customerName,
        this.productID,
        this.productName,
        this.outwardNo,
        this.address,
        this.area,
        this.countryCode,
        this.countryName,
        this.stateCode,
        this.stateName,
        this.cityCode,
        this.cityName,
        this.pinCode,
        this.contactNo,
        this.machineSRno,
        this.installationDate,
        this.installationPlace,
        this.roomCooling,
        this.powerStabilize,
        this.groundEarthing,
        this.createdBy,
        this.createdDate,
        this.installationNo,
        this.employeeID,
        this.employeeName,
        this.traineeName,
        this.traineeDesg,
        this.traineeDepart,
        this.traineeQuali,
        this.aprovedName,
        this.aprovedDepart,
        this.aprovedDesg});

  InstallationListDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    customerID = json['CustomerID']==null?0:json['CustomerID'];
    customerName = json['CustomerName']==null?"":json['CustomerName'];
    productID = json['ProductID']==null?0:json['ProductID'];
    productName = json['ProductName']==null?"":json['ProductName'];
    outwardNo = json['OutwardNo']==null?"":json['OutwardNo'];
    address = json['Address']==null?"":json['Address'];
    area = json['Area']==null?"":json['Area'];
    countryCode = json['CountryCode']==null?"":json['CountryCode'];
    countryName = json['CountryName']==null?"":json['CountryName'];
    stateCode = json['StateCode']==null?0:json['StateCode'];
    stateName = json['StateName']==null?"":json['StateName'];
    cityCode = json['CityCode']==null?0:json['CityCode'];
    cityName = json['CityName']==null?"":json['CityName'];
    pinCode = json['PinCode']==null?"":json['PinCode'];
    contactNo = json['ContactNo']==null?0:json['ContactNo'];
    machineSRno = json['MachineSRno']==null?"":json['MachineSRno'];
    installationDate = json['InstallationDate']==null?"":json['InstallationDate'];
    installationPlace = json['InstallationPlace']==null?"":json['InstallationPlace'];
    roomCooling = json['RoomCooling']==null?"":json['RoomCooling'];
    powerStabilize = json['PowerStabilize']==null?"":json['PowerStabilize'];
    groundEarthing = json['GroundEarthing']==null?"":json['GroundEarthing'];
    createdBy = json['CreatedBy']==null?"":json['CreatedBy'];
    createdDate = json['CreatedDate']==null?"":json['CreatedDate'];
    installationNo = json['InstallationNo']==null?"":json['InstallationNo'];
    employeeID = json['EmployeeID']==null?0:json['EmployeeID'];
    employeeName = json['EmployeeName']==null?"":json['EmployeeName'];
    traineeName = json['TraineeName']==null?"":json['TraineeName'];
    traineeDesg = json['TraineeDesg']==null?"":json['TraineeDesg'];
    traineeDepart = json['TraineeDepart']==null?"":json['TraineeDepart'];
    traineeQuali = json['TraineeQuali']==null?"":json['TraineeQuali'];
    aprovedName = json['AprovedName']==null?"":json['AprovedName'];
    aprovedDepart = json['AprovedDepart']==null?"":json['AprovedDepart'];
    aprovedDesg = json['AprovedDesg']==null?"":json['AprovedDesg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['ProductID'] = this.productID;
    data['ProductName'] = this.productName;
    data['OutwardNo'] = this.outwardNo;
    data['Address'] = this.address;
    data['Area'] = this.area;
    data['CountryCode'] = this.countryCode;
    data['CountryName'] = this.countryName;
    data['StateCode'] = this.stateCode;
    data['StateName'] = this.stateName;
    data['CityCode'] = this.cityCode;
    data['CityName'] = this.cityName;
    data['PinCode'] = this.pinCode;
    data['ContactNo'] = this.contactNo;
    data['MachineSRno'] = this.machineSRno;
    data['InstallationDate'] = this.installationDate;
    data['InstallationPlace'] = this.installationPlace;
    data['RoomCooling'] = this.roomCooling;
    data['PowerStabilize'] = this.powerStabilize;
    data['GroundEarthing'] = this.groundEarthing;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['InstallationNo'] = this.installationNo;
    data['EmployeeID'] = this.employeeID;
    data['EmployeeName'] = this.employeeName;
    data['TraineeName'] = this.traineeName;
    data['TraineeDesg'] = this.traineeDesg;
    data['TraineeDepart'] = this.traineeDepart;
    data['TraineeQuali'] = this.traineeQuali;
    data['AprovedName'] = this.aprovedName;
    data['AprovedDepart'] = this.aprovedDepart;
    data['AprovedDesg'] = this.aprovedDesg;
    return data;
  }
}