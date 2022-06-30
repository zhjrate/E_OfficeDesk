class ALL_EmployeeList_Response {
  List<Details> details;
  int totalCount;

  ALL_EmployeeList_Response({this.details, this.totalCount});

  ALL_EmployeeList_Response.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
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

class Details {
  int pkID;
  String userID;
  String employeeName;
  String mobileNo;
  String landline;
  String emailAddress;
  String desigCode;
  String designation;
  String orgCode;
  String orgName;
  int reportTo;
  String reportToEmployeeName;
  double fixedSalary;
  String birthDate;
  String confirmationDate;
  String joinDate;
  String  releaseDate;
  String authorizedSign;

  Details(
      {this.pkID,
        this.userID,
        this.employeeName,
        this.mobileNo,
        this.landline,
        this.emailAddress,
        this.desigCode,
        this.designation,
        this.orgCode,
        this.orgName,
        this.reportTo,
        this.reportToEmployeeName,
        this.fixedSalary,
        this.birthDate,
        this.confirmationDate,
        this.joinDate,
        this.releaseDate,
        this.authorizedSign});

  Details.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID']==null ? 0 : json['pkID'] ;
    userID = json['UserID']==null ? "" : json['UserID'] ;
    employeeName = json['EmployeeName']==null ? "" : json['EmployeeName'] ;
    mobileNo = json['MobileNo']==null ? "" : json['MobileNo'];
    landline = json['Landline']==null ? "" : json['Landline'];
    emailAddress = json['EmailAddress']==null ? "" : json['EmailAddress'] ;
    desigCode = json['DesigCode']==null ? "" : json['DesigCode'] ;
    designation = json['Designation']==null ? "" : json['Designation'] ;
    orgCode = json['OrgCode']==null ? "" : json['OrgCode'] ;
    orgName = json['OrgName']==null ? "" : json['OrgName'] ;
    reportTo = json['ReportTo']==null ? 0 : json['ReportTo'] ;
    reportToEmployeeName = json['ReportToEmployeeName']==null ? "" : json['ReportToEmployeeName'] ;
    fixedSalary = json['FixedSalary']==null ? 0.00 : json['FixedSalary'] ;
    birthDate = json['BirthDate']==null ? "" : json['BirthDate'] ;
    confirmationDate = json['ConfirmationDate']==null ? "" : json['ConfirmationDate'] ;
    joinDate = json['JoinDate']==null ? "" : json['JoinDate'] ;
    releaseDate = json['ReleaseDate']==null ? "" : json['ReleaseDate'] ;
    authorizedSign = json['AuthorizedSign']==null ? "" : json['AuthorizedSign'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['UserID'] = this.userID;
    data['EmployeeName'] = this.employeeName;
    data['MobileNo'] = this.mobileNo;
    data['Landline'] = this.landline;
    data['EmailAddress'] = this.emailAddress;
    data['DesigCode'] = this.desigCode;
    data['Designation'] = this.designation;
    data['OrgCode'] = this.orgCode;
    data['OrgName'] = this.orgName;
    data['ReportTo'] = this.reportTo;
    data['ReportToEmployeeName'] = this.reportToEmployeeName;
    data['FixedSalary'] = this.fixedSalary;
    data['BirthDate'] = this.birthDate;
    data['ConfirmationDate'] = this.confirmationDate;
    data['JoinDate'] = this.joinDate;
    data['ReleaseDate'] = this.releaseDate;
    data['AuthorizedSign'] = this.authorizedSign;
    return data;
  }
}