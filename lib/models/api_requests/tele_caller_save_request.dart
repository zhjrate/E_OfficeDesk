/*SenderName
SenderMail
QueryDatetime
CompanyName
CountryFlagURL
Message
Address
City
State
CountryISO
ForProduct
PrimaryMobileNo
SecondaryMobileNo
LeadSource
ACID
CompanyId
*/
class TeleCallerSaveRequest {
  String LeadID;

  String SenderName;

  String QueryDatetime;

  String SenderMail;

  String CompanyName;

  String CountryFlagURL;

  String Message;

  String Address;

  String City;

  String State;

  String Country;

  String CountryISO;

  String PrimaryMobileNo;

  String SecondaryMobileNo;

  String ForProduct;

  String LeadSource;

  String LeadStatus;

  String EmployeeID;

  String ACID;

  String ProductID;

  String Pincode;

  String StateCode;

  String CityCode;

  String CountryCode;

  String CustomerID;

  String ExLeadClosure;

  String LoginUserID;

  String FollowupNotes;

  String FollowupDate;

  String PreferredTime;

  String SerialKey;

  String Latitude;

  String Longitude;

  String DisqualifedRemarks;

  String CompanyId;

  String Image;


  TeleCallerSaveRequest({
      this.LeadID,
      this.SenderName,
      this.QueryDatetime,
      this.SenderMail,
      this.CompanyName,
      this.CountryFlagURL,
      this.Message,
      this.Address,
      this.City,
      this.State,
      this.Country,
      this.CountryISO,
      this.PrimaryMobileNo,
      this.SecondaryMobileNo,
      this.ForProduct,
      this.LeadSource,
      this.LeadStatus,
      this.EmployeeID,
      this.ACID,
      this.ProductID,
      this.Pincode,
      this.StateCode,
      this.CityCode,
      this.CountryCode,
      this.CustomerID,
      this.ExLeadClosure,
      this.LoginUserID,
      this.FollowupNotes,
      this.FollowupDate,
      this.PreferredTime,
      this.SerialKey,
      this.DisqualifedRemarks,
      this.CompanyId,
      this.Latitude,
      this.Longitude,
      this.Image
  });



  TeleCallerSaveRequest.fromJson(Map<String, dynamic> json) {
    LeadID = json['LeadID'];
    SenderName = json['SenderName'];
    QueryDatetime = json['QueryDatetime'];
    SenderMail = json['SenderMail'];
    CompanyName = json['CompanyName'];
    CountryFlagURL = json['CountryFlagURL'];
    Message = json['Message'];
    Address = json['Address'];
    City = json['City'];
    State = json['State'];
    Country = json['Country'];
    CountryISO = json['CountryISO'];
    PrimaryMobileNo = json['PrimaryMobileNo'];
    SecondaryMobileNo = json['SecondaryMobileNo'];
    ForProduct = json['ForProduct'];
    LeadSource = json['LeadSource'];
    LeadStatus = json['LeadStatus'];
    EmployeeID = json['EmployeeID'];
    ACID = json['ACID'];
    ProductID = json['ProductID'];
    Pincode = json['Pincode'];
    StateCode = json['StateCode'];
    CityCode = json['CityCode'];
    CountryCode = json['CountryCode'];
    CustomerID = json['CustomerID'];
    ExLeadClosure = json['ExLeadClosure'];
    LoginUserID = json['LoginUserID'];
    FollowupNotes = json['FollowupNotes'];
    FollowupDate = json['FollowupDate'];
    PreferredTime = json['PreferredTime'];
    SerialKey = json['SerialKey'];
    DisqualifedRemarks = json['DisqualifedRemarks'];
    CompanyId = json['CompanyId'];
    Latitude = json['Latitude'];
    Longitude = json['Longitude'];
    Image = json['Image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeadID'] = this.LeadID;
    data['SenderName'] = this.SenderName;
    data['QueryDatetime'] = this.QueryDatetime;
    data['SenderMail'] = this.SenderMail;
    data['CompanyName'] = this.CompanyName;
    data['CountryFlagURL'] = this.CountryFlagURL;
    data['Message'] = this.Message;
    data['Address'] = this.Address;
    data['City'] = this.City;
    data['State'] = this.State;
    data['Country'] = this.Country;
    data['CountryISO'] = this.CountryISO;
    data['PrimaryMobileNo'] = this.PrimaryMobileNo;
    data['SecondaryMobileNo'] = this.SecondaryMobileNo;
    data['ForProduct'] = this.ForProduct;
    data['LeadSource'] = this.LeadSource;
    data['LeadStatus'] = this.LeadStatus;
    data['EmployeeID'] = this.EmployeeID;
    data['ACID'] = this.ACID;
    data['ProductID'] = this.ProductID;
    data['Pincode'] = this.Pincode;
    data['StateCode'] = this.StateCode;
    data['CityCode'] = this.CityCode;
    data['CountryCode'] = this.CountryCode;
    data['CustomerID'] = this.CustomerID;
    data['ExLeadClosure'] = this.ExLeadClosure;
    data['LoginUserID'] = this.LoginUserID;
    data['FollowupNotes'] = this.FollowupNotes;
    data['FollowupDate'] = this.FollowupDate;
    data['PreferredTime'] = this.PreferredTime;
    data['SerialKey'] = this.SerialKey;
    data['DisqualifedRemarks'] = this.DisqualifedRemarks;
    data['CompanyId'] = this.CompanyId;
    data['Latitude']=this.Latitude;
    data['Longitude']=this.Longitude;
    data['Image']=this.Image;

    return data;
  }
}
