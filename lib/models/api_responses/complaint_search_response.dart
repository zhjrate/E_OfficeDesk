class ComplaintSearchResponse {
  List<ComplaintSearchDetails> details;
  int totalCount;

  ComplaintSearchResponse({this.details, this.totalCount});

  ComplaintSearchResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new ComplaintSearchDetails.fromJson(v));
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

class ComplaintSearchDetails {
  String label;
  int value;
  String complaintNo;
  int pkID;

  ComplaintSearchDetails({this.label, this.value, this.complaintNo, this.pkID});

  ComplaintSearchDetails.fromJson(Map<String, dynamic> json) {
    label = json['label']==null?"":json['label'];
    value = json['value']==null?0:json['value'];
    complaintNo = json['ComplaintNo']==null?"":json['ComplaintNo'];
    pkID = json['pkID']==null?0:json['pkID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['ComplaintNo'] = this.complaintNo;
    data['pkID'] = this.pkID;
    return data;
  }
}