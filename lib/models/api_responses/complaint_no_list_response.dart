class ComplaintNoListResponse {
  List<ComplaintNoDetails> details;
  int totalCount;

  ComplaintNoListResponse({this.details, this.totalCount});

  ComplaintNoListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new ComplaintNoDetails.fromJson(v));
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

class ComplaintNoDetails {
  int customerID;
  String complaintNo;
  int visitID;

  ComplaintNoDetails({this.customerID, this.complaintNo,this.visitID});

  ComplaintNoDetails.fromJson(Map<String, dynamic> json) {
    customerID = json['CustomerID'];
    complaintNo = json['ComplaintNo'];
    visitID = json['VisitID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerID'] = this.customerID;
    data['ComplaintNo'] = this.complaintNo;
    data['VisitID']=this.visitID;
    return data;
  }
}