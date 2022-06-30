



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/telecaller/telecaller_bloc.dart';
import 'package:soleoserp/models/api_requests/city_list_request.dart';
import 'package:soleoserp/models/api_requests/country_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_delete_request.dart';
import 'package:soleoserp/models/api_requests/customer_label_value_request.dart';
import 'package:soleoserp/models/api_requests/customer_source_list_request.dart';
import 'package:soleoserp/models/api_requests/district_list_request.dart';
import 'package:soleoserp/models/api_requests/state_list_request.dart';
import 'package:soleoserp/models/api_requests/swastick_telecaller_request/new_telecaller_save_request.dart';
import 'package:soleoserp/models/api_requests/swastick_telecaller_request/telecaller_new_pagination_request.dart';
import 'package:soleoserp/models/api_requests/taluka_api_request.dart';
import 'package:soleoserp/models/api_requests/tele_caller_save_request.dart';
import 'package:soleoserp/models/api_requests/tele_caller_search_by_name_request.dart';
import 'package:soleoserp/models/api_responses/city_api_response.dart';
import 'package:soleoserp/models/api_responses/country_list_response.dart';
import 'package:soleoserp/models/api_responses/customer_delete_response.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/external_lead_save_response.dart';
import 'package:soleoserp/models/api_responses/state_list_response.dart';
import 'package:soleoserp/models/api_responses/swastik_telecaller_response/telecaller_new_pagination_response.dart';
import 'package:soleoserp/models/api_responses/tele_caller_search_by_name_response.dart';
import 'package:soleoserp/models/api_responses/telecaller_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';

import '../../../../models/api_responses/telecaller_company_search_response.dart';
part 'telecaller_new_event.dart';
part 'telecaller_new_state.dart';

class TeleCallerNewBloc extends Bloc<TeleCallerNewEvents, TeleCallerNewStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  TeleCallerNewBloc(this.baseBloc) : super(TeleCallerNewInitialState());

  @override
  Stream<TeleCallerNewStates> mapEventToState(
      TeleCallerNewEvents event) async* {
    if(event is CountryCallEvent)
    {
      yield* _mapCountryListCallEventToState(event);
    }
    if(event is StateCallEvent)
    {
      yield* _mapStateListCallEventToState(event);
    }

    if(event is CityCallEvent)
    {
      yield* _mapCityListCallEventToState(event);
    }

    if(event is CustomerSourceCallEvent)
    {
      yield* _mapCustomerSourceCallEventToState(event);
    }

    if(event is TeleCallerNewListCallEvent)
    {
      yield* _mapTeleCallerNewListCallEventToState(event);

    }
    if(event is TeleCallerDeleteCallEvent)
    {
      yield*  _mapDeleteCustomerCallEventToState(event);
    }
    if(event is TeleCallerSearchByNameCallEvent)
    {
      yield* _mapExternalLeadSearchByNameCallEventToState(event);
    }
    if(event is TeleCallerSearchByIDCallEvent)
    {
      yield* _mapExternalLeadSearchByIDCallEventToState(event);

    }
    if(event is NewTeleCallerSaveCallEvent)
    {
      yield*  _mapExternalLeadSaveCallEventToState(event);
    }
    /*if(event is SearchCustomerListByNameCallEvent)
    {
      yield* _mapCustomerListByNameCallEventToState(event);
    }*/
  }

  Stream<TeleCallerNewStates> _mapCountryListCallEventToState(
      CountryCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      CountryListResponse respo =  await userRepository.country_list_call(event.countryListRequest);
      yield CountryListEventResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<TeleCallerNewStates> _mapStateListCallEventToState(
      StateCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      StateListResponse respo =  await userRepository.state_list_call(event.stateListRequest);
      yield StateListEventResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }




  Stream<TeleCallerNewStates> _mapCityListCallEventToState(
      CityCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      CityApiRespose respo =  await userRepository.city_list_details(event.cityApiRequest);
      yield CityListEventResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<TeleCallerNewStates> _mapCustomerSourceCallEventToState(
      CustomerSourceCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      CustomerSourceResponse respo =  await userRepository.customer_Source_List_call(event.request1);
      yield CustomerSourceCallEventResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<TeleCallerNewStates> _mapTeleCallerNewListCallEventToState(
      TeleCallerNewListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      TelecallerNewpaginationResponse response =
      await userRepository.telecallernewlist(event.pageNo,event.request1);
      yield TeleCallerNewListCallResponseState(response,event.pageNo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<TeleCallerNewStates> _mapDeleteCustomerCallEventToState(
      TeleCallerDeleteCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      CustomerDeleteResponse customerDeleteResponse = await userRepository.deleteTeleCaller(event.pkID,event.customerDeleteRequest);
      yield TeleCallerDeleteCallResponseState(customerDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }



  Stream<TeleCallerNewStates> _mapExternalLeadSearchByNameCallEventToState(
      TeleCallerSearchByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      TeleCallerSearchResponseByName respo =  await userRepository.getTeleCallerSearchByNamedetails(event.request1);
      yield TeleCallerSearchByNameResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<TeleCallerNewStates> _mapExternalLeadSearchByIDCallEventToState(
      TeleCallerSearchByIDCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      TeleCallerListResponse respo =  await userRepository.getTeleCallerLeadSearchByIDDetails(event.request1);
      yield TeleCallerSearchByIDResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<TeleCallerNewStates> _mapExternalLeadSaveCallEventToState(
      NewTeleCallerSaveCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));


      ExternalLeadSaveResponse respo =  await userRepository.new_teleCallerSaveDetails(event.pkID,event.request1);
      yield ExternalLeadSaveResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  /*Stream<TeleCallerNewStates> _mapCustomerListByNameCallEventToState(
      SearchCustomerListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      CustomerLabelvalueRsponse response =
      await userRepository.getTeleCallerCustomerListSearchByName(event.request);
      yield CustomerListByNameCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }*/

}