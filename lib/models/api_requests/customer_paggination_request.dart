import 'package:soleoserp/models/common/contact_model.dart';

class CustomerPaginationRequest {
  int companyId;
  String loginUserID;
  String CustomerID;
  String ListMode;
  List<ContactModel> lstcontact;


  CustomerPaginationRequest({this.companyId, this.loginUserID,this.CustomerID,this.ListMode,this.lstcontact});

  CustomerPaginationRequest.fromJson(Map<String, dynamic> json) {
    companyId = json['CompanyId'];
    loginUserID = json['LoginUserID'];
    CustomerID = json['CustomerID'];
    ListMode = json['ListMode'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.companyId;
    data['LoginUserID'] = this.loginUserID;
    data['CustomerID'] = this.CustomerID;
    data['ListMode'] = this.ListMode;

    return data;
  }
}