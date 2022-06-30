
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/city_list_request.dart';
import 'package:soleoserp/models/api_requests/country_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_delete_request.dart';
import 'package:soleoserp/models/api_requests/customer_source_list_request.dart';
import 'package:soleoserp/models/api_requests/district_list_request.dart';
import 'package:soleoserp/models/api_requests/external_lead_list_request.dart';
import 'package:soleoserp/models/api_requests/external_lead_save_request.dart';
import 'package:soleoserp/models/api_requests/external_lead_search_request.dart';
import 'package:soleoserp/models/api_requests/state_list_request.dart';
import 'package:soleoserp/models/api_requests/taluka_api_request.dart';
import 'package:soleoserp/models/api_responses/city_api_response.dart';
import 'package:soleoserp/models/api_responses/country_list_response.dart';
import 'package:soleoserp/models/api_responses/customer_delete_response.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/external_lead_list_response.dart';
import 'package:soleoserp/models/api_responses/external_lead_save_response.dart';
import 'package:soleoserp/models/api_responses/external_leadsearch_response_by_name.dart';
import 'package:soleoserp/models/api_responses/state_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'external_lead_event.dart';
part 'external_lead_state.dart';

class ExternalLeadBloc extends Bloc<ExternalLeadEvents, ExternalLeadStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  ExternalLeadBloc(this.baseBloc) : super(ExternalLeadInitialState());

  @override
  Stream<ExternalLeadStates> mapEventToState(
      ExternalLeadEvents event) async* {
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

    if(event is ExternalLeadListCallEvent)
      {
        yield* _mapExternalLeadListCallEventToState(event);

      }
    if(event is ExternalLeadDeleteCallEvent)
      {
        yield*  _mapDeleteCustomerCallEventToState(event);
      }
    if(event is ExternalLeadSearchByNameCallEvent)
      {
        yield* _mapExternalLeadSearchByNameCallEventToState(event);
      }
    if(event is ExternalLeadSearchByIDCallEvent)
      {
        yield* _mapExternalLeadSearchByIDCallEventToState(event);

      }
    if(event is ExternalLeadSaveCallEvent)
      {
        yield*  _mapExternalLeadSaveCallEventToState(event);
      }
  }

  Stream<ExternalLeadStates> _mapCountryListCallEventToState(
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

  Stream<ExternalLeadStates> _mapStateListCallEventToState(
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




  Stream<ExternalLeadStates> _mapCityListCallEventToState(
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


  Stream<ExternalLeadStates> _mapCustomerSourceCallEventToState(
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

  Stream<ExternalLeadStates> _mapExternalLeadListCallEventToState(
      ExternalLeadListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      ExternalLeadListResponse response =
      await userRepository.getExternalLeadList(event.pageNo,event.request1);
      yield ExternalLeadListCallResponseState(response,event.pageNo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<ExternalLeadStates> _mapDeleteCustomerCallEventToState(
      ExternalLeadDeleteCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      CustomerDeleteResponse customerDeleteResponse = await userRepository.deleteExternalLead(event.pkID,event.customerDeleteRequest);
      yield ExternalLeadDeleteCallResponseState(customerDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }



  Stream<ExternalLeadStates> _mapExternalLeadSearchByNameCallEventToState(
      ExternalLeadSearchByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      ExternalLeadSearchResponseByName respo =  await userRepository.externalLeadSearchByNamedetails(event.request1);
      yield ExternalLeadSearchByNameResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<ExternalLeadStates> _mapExternalLeadSearchByIDCallEventToState(
      ExternalLeadSearchByIDCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      ExternalLeadListResponse respo =  await userRepository.externalLeadSearchByIDDetails(event.request1);
      yield ExternalLeadSearchByIDResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<ExternalLeadStates> _mapExternalLeadSaveCallEventToState(
      ExternalLeadSaveCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      ExternalLeadSaveResponse respo =  await userRepository.externalLeadSaveDetails(event.pkID,event.request1);
      yield ExternalLeadSaveResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  }