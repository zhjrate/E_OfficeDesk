
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/city_list_request.dart';
import 'package:soleoserp/models/api_requests/country_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_delete_request.dart';
import 'package:soleoserp/models/api_requests/customer_label_value_request.dart';
import 'package:soleoserp/models/api_requests/customer_source_list_request.dart';
import 'package:soleoserp/models/api_requests/district_list_request.dart';
import 'package:soleoserp/models/api_requests/external_lead_list_request.dart';
import 'package:soleoserp/models/api_requests/external_lead_save_request.dart';
import 'package:soleoserp/models/api_requests/external_lead_search_request.dart';
import 'package:soleoserp/models/api_requests/general_telecaller_img_upload_request/telecaller_upload_img_request.dart';
import 'package:soleoserp/models/api_requests/state_list_request.dart';
import 'package:soleoserp/models/api_requests/taluka_api_request.dart';
import 'package:soleoserp/models/api_requests/tele_caller_delete_image/telecaller_delete_image_request.dart';
import 'package:soleoserp/models/api_requests/tele_caller_save_request.dart';
import 'package:soleoserp/models/api_requests/tele_caller_search_by_name_request.dart';
import 'package:soleoserp/models/api_requests/telecaller_list_request.dart';
import 'package:soleoserp/models/api_responses/city_api_response.dart';
import 'package:soleoserp/models/api_responses/country_list_response.dart';
import 'package:soleoserp/models/api_responses/customer_delete_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/external_lead_list_response.dart';
import 'package:soleoserp/models/api_responses/external_lead_save_response.dart';
import 'package:soleoserp/models/api_responses/external_leadsearch_response_by_name.dart';
import 'package:soleoserp/models/api_responses/general_telecaller_img_upload_response/telecaller_upload_img_response.dart';
import 'package:soleoserp/models/api_responses/state_list_response.dart';
import 'package:soleoserp/models/api_responses/tele_caller_image_delete/tele_caller_delete_image_response.dart';
import 'package:soleoserp/models/api_responses/tele_caller_search_by_name_response.dart';
import 'package:soleoserp/models/api_responses/telecaller_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'telecaller_event.dart';
part 'telecaller_state.dart';

class TeleCallerBloc extends Bloc<TeleCallerEvents, TeleCallerStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  TeleCallerBloc(this.baseBloc) : super(TeleCallerInitialState());

  @override
  Stream<TeleCallerStates> mapEventToState(
      TeleCallerEvents event) async* {
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

    if(event is TeleCallerListCallEvent)
    {
      yield* _mapExternalLeadListCallEventToState(event);

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
    if(event is TeleCallerSaveCallEvent)
    {
      yield*  _mapExternalLeadSaveCallEventToState(event);
    }
    if(event is SearchCustomerListByNameCallEvent)
      {
        yield* _mapCustomerListByNameCallEventToState(event);
      }

    if(event is TeleCallerUploadImageNameCallEvent)
      {
        yield* _mapTeleCallerUploadImageCallEventToState(event);
      }
    if(event is TeleCallerImageDeleteRequestCallEvent)
      {
        yield* _mapTeleCallerImageDeleteCallEventToState(event);

      }
  }

  Stream<TeleCallerStates> _mapCountryListCallEventToState(
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

  Stream<TeleCallerStates> _mapStateListCallEventToState(
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




  Stream<TeleCallerStates> _mapCityListCallEventToState(
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


  Stream<TeleCallerStates> _mapCustomerSourceCallEventToState(
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

  Stream<TeleCallerStates> _mapExternalLeadListCallEventToState(
      TeleCallerListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      TeleCallerListResponse response =
      await userRepository.getTeleCallerList(event.pageNo,event.request1);
      yield TeleCallerListCallResponseState(response,event.pageNo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<TeleCallerStates> _mapDeleteCustomerCallEventToState(
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



  Stream<TeleCallerStates> _mapExternalLeadSearchByNameCallEventToState(
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

  Stream<TeleCallerStates> _mapExternalLeadSearchByIDCallEventToState(
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


  Stream<TeleCallerStates> _mapExternalLeadSaveCallEventToState(
      TeleCallerSaveCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));


      ExternalLeadSaveResponse respo =  await userRepository.teleCallerSaveDetails(event.pkID,event.request1);
      yield ExternalLeadSaveResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<TeleCallerStates> _mapCustomerListByNameCallEventToState(
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
  }

  Stream<TeleCallerStates> _mapTeleCallerUploadImageCallEventToState(
      TeleCallerUploadImageNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      Telecaller_image_upload_response  expenseUploadImageResponse  =  await userRepository.getuploadImageTeleCaller(event.telecallerImageFile,event.teleCallerUploadImgApiRequest);


      yield TeleCallerUploadImgApiResponseState(expenseUploadImageResponse);
    } catch (error, stacktrace) {
      print(error);
      baseBloc.emit(ApiCallFailureState(error));

    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<TeleCallerStates> _mapTeleCallerImageDeleteCallEventToState(
      TeleCallerImageDeleteRequestCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      TeleCallerImageDeleteResponse response =
      await userRepository.getTeleCallerImageDeleteByPkID(event.pkID,event.request1);
      yield TeleCallerImageDeleteResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

// Ab pata chal raha he me kar lunga agar kuch dikkat aati toh bolunga thik he

}