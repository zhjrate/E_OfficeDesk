class SearchInquiryListResponse {
  List<SearchInquiryDetails> details;
  int totalCount;

  SearchInquiryListResponse({this.details, this.totalCount});

  SearchInquiryListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new SearchInquiryDetails.fromJson(v));
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

class SearchInquiryDetails {
  String customerName;
  String label;
  int value;
  int pkID;
  String createdBy;
  int createdEmployeeID;

  SearchInquiryDetails({this.customerName, this.label, this.value, this.pkID,this.createdBy,this.createdEmployeeID});

  SearchInquiryDetails.fromJson(Map<String, dynamic> json) {
    customerName = json['CustomerName'];
    label = json['Label'];
    value = json['value'];
    pkID = json['pkID'];
    createdBy = json['CreatedBy'];
    createdEmployeeID  = json['CreatedEmployeeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerName'] = this.customerName;
    data['Label'] = this.label;
    data['value'] = this.value;
    data['pkID'] = this.pkID;
    data['CreatedBy'] = this.createdBy;
    data['CreatedEmployeeID'] = this.createdEmployeeID;

    return data;
  }
}