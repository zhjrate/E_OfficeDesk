class PackingChecklistListResponse {
  List<PackingChecklistDetails> details;
  int totalCount;

  PackingChecklistListResponse({this.details, this.totalCount});

  PackingChecklistListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <PackingChecklistDetails>[];
      json['details'].forEach((v) {
        details.add(new PackingChecklistDetails.fromJson(v));
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

class PackingChecklistDetails {
  int rowNum;
  int pkID;
  int employeeID;
  String employeeName;
  int customerID;
  String customerName;
  String pCNo;
  String pCdate;
  String finalizeDate;
  String dispatchDate;
  String address;
  String area;
  int cityCode;
  int stateCode;
  String stateName;
  String cityName;
  String countryCode;
  String sOno;
  String sOdate;
  int finishProductID;
  String finishProductName;
  String application;
  String createdBy;
  String createdDate;
  String status;

  PackingChecklistDetails(
      {this.rowNum,
        this.pkID,
        this.employeeID,
        this.employeeName,
        this.customerID,
        this.customerName,
        this.pCNo,
        this.pCdate,
        this.finalizeDate,
        this.dispatchDate,
        this.address,
        this.area,
        this.cityCode,
        this.stateCode,
        this.stateName,
        this.cityName,
        this.countryCode,
        this.sOno,
        this.sOdate,
        this.finishProductID,
        this.finishProductName,
        this.application,
        this.createdBy,
        this.createdDate,
        this.status});

  PackingChecklistDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    employeeID = json['EmployeeID']==null?0:json['EmployeeID'];
    employeeName = json['EmployeeName']==null?"":json['EmployeeName'];
    customerID = json['CustomerID']==null?0:json['CustomerID'];
    customerName = json['CustomerName']==null?"":json['CustomerName'];
    pCNo = json['PCNo']==null?"":json['PCNo'];
    pCdate = json['PCdate']==null?"":json['PCdate'];
    finalizeDate = json['FinalizeDate']==null?"":json['FinalizeDate'];
    dispatchDate = json['DispatchDate']==null?"":json['DispatchDate'];
    address = json['Address']==null?"":json['Address'];
    area = json['Area']==null?"":json['Area'];
    cityCode = json['CityCode']==null?0:json['CityCode'];
    stateCode = json['StateCode']==null?0:json['StateCode'];
    stateName = json['StateName']==null?"":json['StateName'];
    cityName = json['CityName']==null?"":json['CityName'];
    countryCode = json['CountryCode']==null?"":json['CountryCode'];
    sOno = json['SOno']==null?"":json['SOno'];
    sOdate = json['SOdate']==null?"":json['SOdate'];
    finishProductID = json['FinishProductID']==null?0:json['FinishProductID'];
    finishProductName = json['FinishProductName']==null?"":json['FinishProductName'];
    application = json['Application']==null?"":json['Application'];
    createdBy = json['CreatedBy']==null?"":json['CreatedBy'];
    createdDate = json['CreatedDate']==null?"":json['CreatedDate'];
    status = json['Status']==null?"":json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['EmployeeID'] = this.employeeID;
    data['EmployeeName'] = this.employeeName;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['PCNo'] = this.pCNo;
    data['PCdate'] = this.pCdate;
    data['FinalizeDate'] = this.finalizeDate;
    data['DispatchDate'] = this.dispatchDate;
    data['Address'] = this.address;
    data['Area'] = this.area;
    data['CityCode'] = this.cityCode;
    data['StateCode'] = this.stateCode;
    data['StateName'] = this.stateName;
    data['CityName'] = this.cityName;
    data['CountryCode'] = this.countryCode;
    data['SOno'] = this.sOno;
    data['SOdate'] = this.sOdate;
    data['FinishProductID'] = this.finishProductID;
    data['FinishProductName'] = this.finishProductName;
    data['Application'] = this.application;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['Status'] = this.status;
    return data;
  }
}