/*SenderName:Sahil Patel123
QueryDatetime:2022-02-28
SenderMail:info.ashutoshindustries@gmail.com
CompanyName:Ashutosh Industries231
CountryFlagURL:
Message:Test From API For ExternalLeads API
Address:9, Nandanvan Industrial Estate, Near Mahakali Mandir, Bakrol-Dhamatvan Roda, Bakrol, Ahemdabad.
City:Ahemdabad
State:Gujarat
PrimaryMobileNo:9106838291
SecondaryMobileNo:7041001778
ForProduct:PP Bages.
LeadSource:IndiaMart
LeadStatus:
EmployeeID:
ProductID:
Pincode:380026
StateCode:
CityCode:
CustomerID:0
ExLeadClosure:
LoginUserID:admin
CountryCode:
ClosureRemark:
CompanyId:10032*/

class ExternalLeadSaveRequest {
  String SenderName;
  String QueryDatetime;
  String CompanyName;
  String SenderMail;
  String CountryFlagURL;
  String Message;
  String Address;
  String City;
  String State;
  String PrimaryMobileNo;
  String SecondaryMobileNo;
  String ForProduct;
  String LeadSource;
  String LeadStatus;
  String EmployeeID;
  String ProductID;
  String Pincode;
  String StateCode;
  String CityCode;
  String CustomerID;
  String ExLeadClosure;
  String LoginUserID;
  String CountryCode;
  String ClosureRemark;
  String CompanyId;

  ExternalLeadSaveRequest(
      {this.CompanyName,
      this.CountryFlagURL,
      this.Message,
      this.Address,
      this.City,
      this.State,
      this.PrimaryMobileNo,
      this.SecondaryMobileNo,
      this.ForProduct,
      this.LeadSource,
      this.LeadStatus,
      this.EmployeeID,
      this.ProductID,
      this.Pincode,
      this.StateCode,
      this.CityCode,
      this.CustomerID,
      this.ExLeadClosure,
      this.LoginUserID,
      this.CountryCode,
      this.ClosureRemark,
      this.CompanyId,
      this.SenderName,
      this.QueryDatetime,
      this.SenderMail
      });

  ExternalLeadSaveRequest.fromJson(Map<String, dynamic> json) {
    CompanyName = json['CompanyName'];
    CountryFlagURL = json['CountryFlagURL'];
    Message = json['Message'];
    Address = json['Address'];
    City = json['City'];
    State = json['State'];
    PrimaryMobileNo = json['PrimaryMobileNo'];
    SecondaryMobileNo = json['SecondaryMobileNo'];
    ForProduct = json['ForProduct'];
    LeadSource = json['LeadSource'];
    LeadStatus = json['LeadStatus'];
    EmployeeID = json['EmployeeID'];
    ProductID = json['ProductID'];
    Pincode = json['Pincode'];
    StateCode = json['StateCode'];
    CityCode = json['CityCode'];
    CustomerID = json['CustomerID'];
    ExLeadClosure = json['ExLeadClosure'];
    LoginUserID = json['LoginUserID'];
    CountryCode = json['CountryCode'];
    ClosureRemark = json['ClosureRemark'];
    CompanyId = json['CompanyId'];
    SenderName= json['SenderName'];
    QueryDatetime= json['QueryDatetime'];
    SenderMail= json['SenderMail'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['CompanyName'] = this.CompanyName;
    data['CountryFlagURL'] = this.CountryFlagURL;
    data['Message'] = this.Message;
    data['Address'] = this.Address;
    data['City'] = this.City;
    data['State'] = this.State;
    data['PrimaryMobileNo'] = this.PrimaryMobileNo;
    data['SecondaryMobileNo'] = this.SecondaryMobileNo;
    data['ForProduct'] = this.ForProduct;
    data['LeadSource'] = this.LeadSource;
    data['LeadStatus'] = this.LeadStatus;
    data['EmployeeID'] = this.EmployeeID;
    data['ProductID'] = this.ProductID;
    data['Pincode'] = this.Pincode;
    data['StateCode'] = this.StateCode;
    data['CityCode'] = this.CityCode;
    data['CustomerID'] = this.CustomerID;
    data['ExLeadClosure'] = this.ExLeadClosure;
    data['LoginUserID'] = this.LoginUserID;
    data['CountryCode'] = this.CountryCode;
    data['ClosureRemark'] = this.ClosureRemark;
    data['CompanyId'] = this.CompanyId;
    data['SenderName']=this.SenderName;
    data['QueryDatetime']=this.QueryDatetime;
    data['SenderMail']=this.SenderMail;






    return data;
  }
}
