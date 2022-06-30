import 'package:flutter/material.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/company_details_request.dart';
import 'package:soleoserp/models/api_requests/customer_category_request.dart';
import 'package:soleoserp/models/api_requests/customer_source_list_request.dart';
import 'package:soleoserp/models/api_requests/designation_list_request.dart';
import 'package:soleoserp/models/api_requests/login_user_details_api_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_category_list.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/designation_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'first_screen_events.dart';

part 'first_screen_states.dart';

class FirstScreenBloc extends Bloc<FirstScreenEvents, FirstScreenStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  FirstScreenBloc(this.baseBloc) : super(FirstScreenInitialState());

  @override
  Stream<FirstScreenStates> mapEventToState(FirstScreenEvents event) async* {
    /// sets state based on events
   if (event is CompanyDetailsCallEvent) {
      yield* _mapCompanyDetailsCallEventToState(event);
    }
    if(event is LoginUserDetailsCallEvent)
      {
        yield* _mapLoginUserDetailsCallEventToState(event);

      }

  }




  ///event functions to states implementation
  Stream<FirstScreenStates> _mapCompanyDetailsCallEventToState(
      CompanyDetailsCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      CompanyDetailsResponse companyDetailsResponse =
      await userRepository.CompanyDetailsCallApi(event.companyDetailsApiRequest);
      yield ComapnyDetailsEventResponseState(companyDetailsResponse);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  ///event functions to states implementation
  Stream<FirstScreenStates> _mapLoginUserDetailsCallEventToState(
      LoginUserDetailsCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      LoginUserDetialsResponse loginResponse =
      await userRepository.loginUserDetailsCall(event.request);
      yield LoginUserDetialsCallEventResponseState(loginResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);

    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


}
