class TeleCallerSearchResponseByName {
  List<TeleCallerOnlyNameDetails> details;
  int totalCount;

  TeleCallerSearchResponseByName({this.details, this.totalCount});

  TeleCallerSearchResponseByName.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new TeleCallerOnlyNameDetails.fromJson(v));
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

class TeleCallerOnlyNameDetails {
  String label;
  int value;
  String leadStatus;
  String leadSource;

  TeleCallerOnlyNameDetails({this.label, this.value, this.leadStatus, this.leadSource});

  TeleCallerOnlyNameDetails.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    leadStatus = json['LeadStatus'];
    leadSource = json['LeadSource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['LeadStatus'] = this.leadStatus;
    data['LeadSource'] = this.leadSource;
    return data;
  }
}