part of 'first_screen_bloc.dart';

@immutable
abstract class FirstScreenEvents {}

///all events of AuthenticationEvents



class LoginUserDetailsCallEvent extends FirstScreenEvents {
  final LoginUserDetialsAPIRequest request;

  LoginUserDetailsCallEvent(this.request);
}

class CompanyDetailsCallEvent extends FirstScreenEvents {
  final CompanyDetailsApiRequest companyDetailsApiRequest;

  CompanyDetailsCallEvent(this.companyDetailsApiRequest);
}
