part of 'first_screen_bloc.dart';

abstract class FirstScreenStates extends BaseStates {
  const FirstScreenStates();
}

///all states of AuthenticationStates

class FirstScreenInitialState extends FirstScreenStates {}


class LoginUserDetialsCallEventResponseState extends FirstScreenStates {
  LoginUserDetialsResponse response;

  LoginUserDetialsCallEventResponseState(this.response);
}

class ComapnyDetailsEventResponseState extends FirstScreenStates{
  final CompanyDetailsResponse companyDetailsResponse;

  ComapnyDetailsEventResponseState(this.companyDetailsResponse);

}
