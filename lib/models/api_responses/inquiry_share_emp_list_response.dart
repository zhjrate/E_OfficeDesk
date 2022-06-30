class InquiryShareEmpListResponse {
  List<InquirySharedEmpDetails> details;
  int totalCount;

  InquiryShareEmpListResponse({this.details, this.totalCount});

  InquiryShareEmpListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new InquirySharedEmpDetails.fromJson(v));
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

class InquirySharedEmpDetails {
  int pkID;
  String inquiryNo;
  int employeeID;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;

  InquirySharedEmpDetails(
      {this.pkID,
        this.inquiryNo,
        this.employeeID,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate});

  InquirySharedEmpDetails.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID']==null? 0:json['pkID'];
    inquiryNo = json['InquiryNo']==null? "":json['InquiryNo'];
    employeeID = json['EmployeeID']==null? 0:json['EmployeeID'];
    createdBy = json['CreatedBy']==null? "":json['CreatedBy'];
    createdDate = json['CreatedDate']==null? "":json['CreatedDate'];
    updatedBy = json['UpdatedBy']==null? "":json['UpdatedBy'];
    updatedDate = json['UpdatedDate']==null? "":json['UpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['InquiryNo'] = this.inquiryNo;
    data['EmployeeID'] = this.employeeID;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    return data;
  }
}