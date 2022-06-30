class BankVoucherSearchByNameResponse {
  List<BankVoucherSearchByNameDetails> details;
  int totalCount;

  BankVoucherSearchByNameResponse({this.details, this.totalCount});

  BankVoucherSearchByNameResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new BankVoucherSearchByNameDetails.fromJson(v));
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

class BankVoucherSearchByNameDetails {
  String customerName;
  String voucherNo;
  int value;
  String recPay;

  BankVoucherSearchByNameDetails({this.customerName, this.voucherNo, this.value, this.recPay});

  BankVoucherSearchByNameDetails.fromJson(Map<String, dynamic> json) {
    customerName = json['CustomerName'];
    voucherNo = json['VoucherNo'];
    value = json['value'];
    recPay = json['RecPay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerName'] = this.customerName;
    data['VoucherNo'] = this.voucherNo;
    data['value'] = this.value;
    data['RecPay'] = this.recPay;
    return data;
  }
}