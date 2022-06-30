class MissedPunchSearchByNameResponse {
  List<MissedPunchSearchDetails> details;
  int totalCount;

  MissedPunchSearchByNameResponse({this.details, this.totalCount});

  MissedPunchSearchByNameResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new MissedPunchSearchDetails.fromJson(v));
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

class MissedPunchSearchDetails {
  String label;
  int value;
  int pkID;

  MissedPunchSearchDetails({this.label, this.value, this.pkID});

  MissedPunchSearchDetails.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    pkID = json['pkID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['pkID'] = this.pkID;
    return data;
  }
}