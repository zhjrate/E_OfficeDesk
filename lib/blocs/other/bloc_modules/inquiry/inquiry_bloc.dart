import 'package:flutter/material.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/InquiryShareModel.dart';
import 'package:soleoserp/models/api_requests/city_list_request.dart';
import 'package:soleoserp/models/api_requests/closer_reason_list_request.dart';
import 'package:soleoserp/models/api_requests/country_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_label_value_request.dart';
import 'package:soleoserp/models/api_requests/customer_search_by_id_request.dart';
import 'package:soleoserp/models/api_requests/customer_source_list_request.dart';
import 'package:soleoserp/models/api_requests/follower_employee_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_delete_request.dart';
import 'package:soleoserp/models/api_requests/inqiory_header_save_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_no_followup_details_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_no_to_delete_product.dart';
import 'package:soleoserp/models/api_requests/inquiry_no_to_product_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_product_search_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_search_by_pk_id_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_share_emp_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_status_list_request.dart';
import 'package:soleoserp/models/api_requests/search_inquiry_fillter_request.dart';
import 'package:soleoserp/models/api_requests/search_inquiry_list_by_name_request.dart';
import 'package:soleoserp/models/api_requests/search_inquiry_list_by_number_request.dart';
import 'package:soleoserp/models/api_requests/state_list_request.dart';
import 'package:soleoserp/models/api_responses/city_api_response.dart';
import 'package:soleoserp/models/api_responses/closer_reason_list_response.dart';
import 'package:soleoserp/models/api_responses/country_list_response_for_packing_checking.dart';
import 'package:soleoserp/models/api_responses/customer_contact_save_response.dart';
import 'package:soleoserp/models/api_responses/customer_details_api_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_history_list_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_delete_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_header_save_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_list_reponse.dart';
import 'package:soleoserp/models/api_responses/inquiry_no_to_delete_product_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_no_to_product_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_product_save_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_product_search_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_search_by_pk_id_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_share_emp_list_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_share_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_status_list_response.dart';
import 'package:soleoserp/models/api_responses/search_inquiry_list_response.dart';
import 'package:soleoserp/models/api_responses/state_list_response.dart';
import 'package:soleoserp/models/common/inquiry_product_model.dart';
import 'package:soleoserp/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'inquiry_events.dart';

part 'inquiry_states.dart';

class InquiryBloc extends Bloc<InquiryEvents, InquiryStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  InquiryBloc(this.baseBloc) : super(InquiryInitialState());

  @override
  Stream<InquiryStates> mapEventToState(InquiryEvents event) async* {
    /// sets state based on events
    if (event is InquiryListCallEvent) {
      yield* _mapInquiryListCallEventToState(event);
    }
    if (event is SearchInquiryListByNameCallEvent) {
      yield* _mapSearchInquiryListByNameCallEventToState(event);
    }
    if (event is SearchInquiryListByNumberCallEvent) {
      yield* _mapSearchInquiryListByNumberCallEventToState(event);
    }

    /* if(event is InquiryLeadSourceCallEvent)
      {
        yield* _mapCustomerSourceCallEventToState(event);
      }*/

    if (event is InquiryDeleteByNameCallEvent) {
      yield* _mapDeleteInquiryCallEventToState(event);
    }
    if (event is InquiryProductSearchNameCallEvent) {
      yield* _mapInquiryProductSearchCallEventToState(event);
    }
    if (event is InquiryHeaderSaveNameCallEvent) {
      yield* _mapInquiryHeaderSaveEventToState(event);
    }
    if (event is InquiryProductSaveCallEvent) {
      yield* _mapInquiryProductSaveEventToState(event);
    }
    if(event is InquiryNotoProductCallEvent)
      {
        yield* _mapInquryNoToProductEventToState(event);

      }
    if(event is InquiryNotoDeleteProductCallEvent)
      {
        yield* _mapInquryNoToDeleteProductEventToState(event);

      }
    if(event is InquirySearchByPkIDCallEvent)
      {
        yield* _mapInqurySearchByEventToState(event);

      }
    if(event is SearchInquiryCustomerListByNameCallEvent)
      {
        yield* _mapCustomerListByNameCallEventToState(event);

      }

    if(event is InquiryLeadStatusTypeListByNameCallEvent)
      {
        yield* _mapFollowupInquiryStatusListCallEventToState(event);
      }

    if(event is CustomerSourceCallEvent)
      {
        yield* _mapCustomerSourceCallEventToState(event);

      }
    if(event is InquiryNoToFollowupDetailsRequestCallEvent)
    {
      yield* _mapInquiry_No_To_CallEventToState(event);

    }

    if(event is InquiryShareModelCallEvent)
      {
        yield* _mapInquiryShareSaveEventToState(event);

      }

    if(event is FollowerEmployeeListCallEvent){
      yield* _mapFollowerEmployeeByStatusCallEventToState(event);

    }

    if(event is InquiryShareEmpListRequestEvent)
      {
        yield* _mapInquiryShareEmpListEventToState(event);

      }

    if(event is CloserReasonTypeListByNameCallEvent)
    {
      yield* _mapCloserReasonStatusListCallEventToState(event);

    }


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
    if(event is SearchInquiryListFillterByNameRequestEvent)
    {
      yield* _mapSearchInquiryFillterCallEventToState(event);
    }
    if(event is SearchCustomerListByNumberCallEvent)
    {
      yield* _mapSearchCustomerListByNumberCallEventToState(event);
    }



  }

  ///event functions to states implementation
  Stream<InquiryStates> _mapInquiryListCallEventToState(
      InquiryListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      InquiryListResponse response = await userRepository.getInquiryList(
          event.pageNo, event.inquiryListApiRequest);
      yield InquiryListCallResponseState(response, event.pageNo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<InquiryStates> _mapSearchInquiryListByNumberCallEventToState(
      SearchInquiryListByNumberCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      InquiryListResponse response =
          await userRepository.getInquiryListSearchByNumber(event.request);
      yield SearchInquiryListByNumberCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<InquiryStates> _mapSearchInquiryListByNameCallEventToState(
      SearchInquiryListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      SearchInquiryListResponse response =
          await userRepository.getInquiryListSearchByName(event.request);
      yield SearchInquiryListByNameCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  /* Stream<InquiryStates> _mapCustomerSourceCallEventToState(
      InquiryLeadSourceCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      CustomerSourceResponse respo =  await userRepository.customer_Source_List_call(event.request1);
      yield InquirySourceCallEventResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
*/
  Stream<InquiryStates> _mapDeleteInquiryCallEventToState(
      InquiryDeleteByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      InquiryDeleteResponse inquiryDeleteResponse = await userRepository.deleteInquiry(
          event.pkID, event.followupDeleteRequest);
      yield InquiryDeleteCallResponseState(inquiryDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<InquiryStates> _mapInquiryProductSearchCallEventToState(
      InquiryProductSearchNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      InquiryProductSearchResponse response = await userRepository
          .getInquiryProductSearchList(event.inquiryProductSearchRequest);
      yield InquiryProductSearchResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<InquiryStates> _mapInquiryHeaderSaveEventToState(
      InquiryHeaderSaveNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      InquiryHeaderSaveResponse response = await userRepository
          .getInquiryHeaderSave(event.pkID,event.inquiryHeaderSaveRequest);
      yield InquiryHeaderSaveResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<InquiryStates> _mapInquiryProductSaveEventToState(
      InquiryProductSaveCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      InquiryProductSaveResponse respo = await userRepository
          .inquiryProductSaveDetails(event.inquiryProductModel);
      yield InquiryProductSaveResponseState(respo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<InquiryStates> _mapInquryNoToProductEventToState(
      InquiryNotoProductCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      InquiryNoToProductResponse response = await userRepository
          .getInquiryNoToProductList(event.inquiryNoToProductListRequest);
      yield InquiryNotoProductResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<InquiryStates> _mapInquryNoToDeleteProductEventToState(
      InquiryNotoDeleteProductCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      InquiryNoToDeleteProductResponse response = await userRepository
          .getInquiryNoToDeleteProductList(event.InqNo,event.inquiryNoToDeleteProductRequest);
      yield InquiryNotoDeleteProductResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<InquiryStates> _mapInqurySearchByEventToState(
      InquirySearchByPkIDCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      InquiryListResponse response = await userRepository
          .getInquiryByPkID(event.pkID,event.inquirySearchByPkIdRequest);
      yield InquirySearchByPkIDResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<InquiryStates> _mapCustomerListByNameCallEventToState(
      SearchInquiryCustomerListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      CustomerLabelvalueRsponse response =
      await userRepository.getCustomerListSearchByName(event.request);
      yield InquiryCustomerListByNameCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<InquiryStates> _mapFollowupInquiryStatusListCallEventToState(
      InquiryLeadStatusTypeListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      InquiryStatusListResponse response =
      await userRepository.getFollowupInquiryStatusList(event.followupInquiryStatusTypeListRequest);
      yield InquiryLeadStatusListCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<InquiryStates> _mapCustomerSourceCallEventToState(
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


  Stream<InquiryStates> _mapInquiry_No_To_CallEventToState(
      InquiryNoToFollowupDetailsRequestCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      FollowupHistoryListResponse respo =  await userRepository.inquiry_no_to_followup_details(event.inquiryNoToFollowupDetailsRequest);
      yield FollowupHistoryListResponseState(event.inquiryDetails,respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<InquiryStates> _mapInquiryShareSaveEventToState(
      InquiryShareModelCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      InquiryShareResponse respo = await userRepository
          .inquiryShareSaveDetails(event.inquiryShareModel);
      yield InquiryShareResponseState(respo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<InquiryStates> _mapFollowerEmployeeByStatusCallEventToState(
      FollowerEmployeeListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowerEmployeeListResponse response =
      await userRepository.getFollowerEmployeeList(event.followerEmployeeListRequest);
      yield FollowerEmployeeListByStatusCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<InquiryStates> _mapInquiryShareEmpListEventToState(
      InquiryShareEmpListRequestEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      InquiryShareEmpListResponse response =
      await userRepository.getInquiryShareEmpList(event.inquiryShareEmpListRequest);
      yield InquiryShareEmpListResponseState(event.inquiryShareEmpListRequest.InquiryNo,response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<InquiryStates> _mapCloserReasonStatusListCallEventToState(
      CloserReasonTypeListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      CloserReasonListResponse response =
      await userRepository.getCloserReasonStatusList(event.closerReasonTypeListRequest);
      yield CloserReasonListCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<InquiryStates> _mapCountryListCallEventToState(
      CountryCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      CountryListResponseForPacking respo =  await userRepository.country_list_call_For_Packing(event.countryListRequest);
      yield CountryListEventResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<InquiryStates> _mapStateListCallEventToState(
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




  Stream<InquiryStates> _mapCityListCallEventToState(
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

  Stream<InquiryStates> _mapSearchInquiryFillterCallEventToState(
      SearchInquiryListFillterByNameRequestEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      InquiryListResponse response =
      await userRepository.getInquiryListSearchByNameFillter(event.searchInquiryListFillterByNameRequest);
      yield SearchInquiryFillterResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<InquiryStates> _mapSearchCustomerListByNumberCallEventToState(
      SearchCustomerListByNumberCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      CustomerDetailsResponse response =
      await userRepository.getCustomerListSearchByNumber(event.request);
      yield SearchCustomerListByNumberCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  //SearchInquiryListFillterByNameRequestEvent

}
