class SalaryUpadListResponse {
  List<Details> details;
  int totalCount;

  SalaryUpadListResponse({this.details, this.totalCount});

  SalaryUpadListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <Details>[];
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
  String loanCategory;
  String loanType;
  int employeeID;
  String employeeName;
  String startDate;
  String endDate;
  int loanAmount;
  int noOfInstallments;
  int installmentAmount;
  String remarks;
  String approvalStatus;
  String approvedBy;
  String approvedOn;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;

  Details(
      {this.rowNum,
        this.pkID,
        this.loanCategory,
        this.loanType,
        this.employeeID,
        this.employeeName,
        this.startDate,
        this.endDate,
        this.loanAmount,
        this.noOfInstallments,
        this.installmentAmount,
        this.remarks,
        this.approvalStatus,
        this.approvedBy,
        this.approvedOn,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate});

  Details.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    pkID = json['pkID'];
    loanCategory = json['LoanCategory'];
    loanType = json['LoanType'];
    employeeID = json['EmployeeID'];
    employeeName = json['EmployeeName'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    loanAmount = json['LoanAmount'];
    noOfInstallments = json['NoOfInstallments'];
    installmentAmount = json['InstallmentAmount'];
    remarks = json['Remarks'];
    approvalStatus = json['ApprovalStatus'];
    approvedBy = json['ApprovedBy'];
    approvedOn = json['ApprovedOn'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    updatedBy = json['UpdatedBy'];
    updatedDate = json['UpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['LoanCategory'] = this.loanCategory;
    data['LoanType'] = this.loanType;
    data['EmployeeID'] = this.employeeID;
    data['EmployeeName'] = this.employeeName;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['LoanAmount'] = this.loanAmount;
    data['NoOfInstallments'] = this.noOfInstallments;
    data['InstallmentAmount'] = this.installmentAmount;
    data['Remarks'] = this.remarks;
    data['ApprovalStatus'] = this.approvalStatus;
    data['ApprovedBy'] = this.approvedBy;
    data['ApprovedOn'] = this.approvedOn;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    return data;
  }
}