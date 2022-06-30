class ExternalLeadSaveResponse {
  List<ExternalLeadSaveDetails> details;
  int totalCount;

  ExternalLeadSaveResponse({this.details, this.totalCount});

  ExternalLeadSaveResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new ExternalLeadSaveDetails.fromJson(v));
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

class ExternalLeadSaveDetails {
  int column1;
  String column2;
  int leadID;
  int pkID;

  ExternalLeadSaveDetails({this.column1, this.column2});

  ExternalLeadSaveDetails.fromJson(Map<String, dynamic> json) {
    column1 = json['Column1'];
    column2 = json['Column2'];
    leadID = json['LeadID'];
    pkID = json['pkID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Column1'] = this.column1;
    data['Column2'] = this.column2;
    data['LeadID'] = this.leadID;
    data['pkID'] = this.pkID;

    return data;
  }
}