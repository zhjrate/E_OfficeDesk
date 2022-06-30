class DolphinComplaintVisitSaveResponse {
  List<DolphinComplaintVisitSaveDetails> details;
  int totalCount;

  DolphinComplaintVisitSaveResponse({this.details, this.totalCount});

  DolphinComplaintVisitSaveResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new DolphinComplaintVisitSaveDetails.fromJson(v));
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

class DolphinComplaintVisitSaveDetails {
  int column1;
  String column2;


  DolphinComplaintVisitSaveDetails({this.column1, this.column2});

  DolphinComplaintVisitSaveDetails.fromJson(Map<String, dynamic> json) {
    column1 = json['Column1'];
    column2 = json['Column2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Column1'] = this.column1;
    data['Column2'] = this.column2;
    return data;
  }
}