class DolphinComplaintSearchResponse {
  List<DolphinComplaintSearchDetails> details;
  int totalCount;

  DolphinComplaintSearchResponse({this.details, this.totalCount});

  DolphinComplaintSearchResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new DolphinComplaintSearchDetails.fromJson(v));
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

class DolphinComplaintSearchDetails {
  String label;
  int value;
  String complaintNo;
  int pkID;

  DolphinComplaintSearchDetails({this.label, this.value, this.complaintNo, this.pkID});

  DolphinComplaintSearchDetails.fromJson(Map<String, dynamic> json) {
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