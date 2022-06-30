class LoanListResponse {
  List<LoanDetails> details;
  int totalCount;

  LoanListResponse({this.details, this.totalCount});

  LoanListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new LoanDetails.fromJson(v));
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

class LoanDetails {
  int rowNum;
  int pkID;
  String loanCategory;
  String loanType;
  int employeeID;
  String employeeName;
  String startDate;
  String endDate;
  double loanAmount;
  int noOfInstallments;
  double installmentAmount;
  String approvalStatus;
  String approvedBy;
  String approvedOn;
  String remarks;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;

  LoanDetails(
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
        this.approvalStatus,
        this.approvedBy,
        this.approvedOn,
        this.remarks,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate});

  LoanDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    loanCategory = json['LoanCategory']==null?"":json['LoanCategory'];
    loanType = json['LoanType']==null?"":json['LoanType'];
    employeeID = json['EmployeeID']==null?0:json['EmployeeID'];
    employeeName = json['EmployeeName']==null?"":json['EmployeeName'];
    startDate = json['StartDate']==null?"":json['StartDate'];
    endDate = json['EndDate']==null?"":json['EndDate'];
    loanAmount = json['LoanAmount']==null?0.00:json['LoanAmount'];
    noOfInstallments = json['NoOfInstallments']==null?0:json['NoOfInstallments'];
    installmentAmount = json['InstallmentAmount']==null?0.00:json['InstallmentAmount'];
    approvalStatus = json['ApprovalStatus']==null?"":json['ApprovalStatus'];
    approvedBy = json['ApprovedBy']==null?"":json['ApprovedBy'];
    approvedOn = json['ApprovedOn']==null?"":json['ApprovedOn'];
    remarks = json['Remarks']==null?"":json['Remarks'];
    createdBy = json['CreatedBy']==null?"":json['CreatedBy'];
    createdDate = json['CreatedDate']==null?"":json['CreatedDate'];
    updatedBy = json['UpdatedBy']==null?"":json['UpdatedBy'];
    updatedDate = json['UpdatedDate']==null?"":json['UpdatedDate'];
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
    data['ApprovalStatus'] = this.approvalStatus;
    data['ApprovedBy'] = this.approvedBy;
    data['ApprovedOn'] = this.approvedOn;
    data['Remarks'] = this.remarks;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    return data;
  }
}