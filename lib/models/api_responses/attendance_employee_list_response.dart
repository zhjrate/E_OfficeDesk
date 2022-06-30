class AttendanceEmployeeListResponse {
  List<Details> details;
  int totalCount;

  AttendanceEmployeeListResponse({this.details, this.totalCount});

  AttendanceEmployeeListResponse.fromJson(Map<String, dynamic> json) {
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
  int rowNum;
  int pkID;
  String employeeName;
  int companyID;
  String companyName;
  String companyType;
  String orgCode;
  String userID;
  int parentCompanyID;
  String parentCompanyName;
  String tokenNo;

  Details(
      {this.rowNum,
        this.pkID,
        this.employeeName,
        this.companyID,
        this.companyName,
        this.companyType,
        this.orgCode,
        this.userID,
        this.parentCompanyID,
        this.parentCompanyName,
        this.tokenNo});

  Details.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    pkID = json['pkID'];
    employeeName = json['EmployeeName'];
    companyID = json['CompanyID'];
    companyName = json['CompanyName'];
    companyType = json['CompanyType'];
    orgCode = json['OrgCode'];
    userID = json['UserID'];
    parentCompanyID = json['ParentCompanyID'];
    parentCompanyName = json['ParentCompanyName'];
    tokenNo = json['TokenNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['EmployeeName'] = this.employeeName;
    data['CompanyID'] = this.companyID;
    data['CompanyName'] = this.companyName;
    data['CompanyType'] = this.companyType;
    data['OrgCode'] = this.orgCode;
    data['UserID'] = this.userID;
    data['ParentCompanyID'] = this.parentCompanyID;
    data['ParentCompanyName'] = this.parentCompanyName;
    data['TokenNo'] = this.tokenNo;
    return data;
  }
}