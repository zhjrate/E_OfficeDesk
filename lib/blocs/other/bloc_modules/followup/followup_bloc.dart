import 'dart:io';

import 'package:flutter/material.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/closer_reason_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_label_value_request.dart';
import 'package:soleoserp/models/api_requests/followup_history_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_upload_image_request.dart';
import 'package:soleoserp/models/api_requests/follower_employee_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_delete_image_request.dart';
import 'package:soleoserp/models/api_requests/followup_delete_request.dart';
import 'package:soleoserp/models/api_requests/followup_filter_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_inquiry_by_customer_id_request.dart';
import 'package:soleoserp/models/api_requests/followup_inquiry_no_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_save_request.dart';
import 'package:soleoserp/models/api_requests/followup_type_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_status_list_request.dart';
import 'package:soleoserp/models/api_requests/quick_followup_list_request.dart';
import 'package:soleoserp/models/api_requests/search_followup_by_status_request.dart';
import 'package:soleoserp/models/api_responses/closer_reason_list_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/expense_upload_image_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_Image_Upload_response.dart';
import 'package:soleoserp/models/api_responses/followup_delete_Image_response.dart';
import 'package:soleoserp/models/api_responses/followup_delete_response.dart';
import 'package:soleoserp/models/api_responses/followup_filter_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_history_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_inquiry_by_customer_id_response.dart';
import 'package:soleoserp/models/api_responses/followup_inquiry_no_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_save_response.dart';
import 'package:soleoserp/models/api_responses/followup_save_success_response.dart';
import 'package:soleoserp/models/api_responses/followup_type_list_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_list_reponse.dart';
import 'package:soleoserp/models/api_responses/inquiry_status_list_response.dart';
import 'package:soleoserp/models/api_responses/quick_followup_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'followup_events.dart';

part 'followup_states.dart';

class FollowupBloc extends Bloc<FollowupEvents, FollowupStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  FollowupBloc(this.baseBloc) : super(FollowupInitialState());

  @override
  Stream<FollowupStates> mapEventToState(
      FollowupEvents event) async* {
    /// sets state based on events
    if (event is FollowupListCallEvent) {
      yield* _mapFollowupListCallEventToState(event);
    }
    if(event is SearchFollowupListByNameCallEvent)
      {
        yield* _mapFollowupListbyStatusCallEventToState(event);

      }



    if(event is SearchFollowupCustomerListByNameCallEvent)
    {
      yield* _mapFollowupCustomerListByNameCallEventToState(event);

    }



    if(event is FollowupInquiryNoListByNameCallEvent)
    {
      yield* _mapFollowupInquiryNoStatusListCallEventToState(event);

    }

    if(event is FollowupSaveByNameCallEvent)
    {
      yield* _mapFollowupSaveStatusListCallEventToState(event);

    }
    if(event is QuickFollowupSaveByNameCallEvent)
    {
      yield* _mapQuickFollowupSaveStatusListCallEventToState(event);

    }


    if(event is FollowupDeleteByNameCallEvent)
    {
      yield* _mapDeleteInquiryCallEventToState(event);

    }

    if(event is QuickFollowupDeleteByNameCallEvent)
    {
      yield* _mapQuickFollowupDeleteInquiryCallEventToState(event);

    }



    if(event is FollowupFilterListCallEvent)
    {
      yield* _mapFollowupFilterListCallEventToState(event);

    }

    if(event is FollowupInquiryByCustomerIDCallEvent){
      yield* _mapFollowupInquiryByCustomerCallEventToState(event);

    }
    if(event is FollowupUploadImageNameCallEvent){
      yield* _mapFollowupUploadImageCallEventToState(event);

    }
    if(event is FollowupImageDeleteCallEvent){
      yield* _mapFollowupImageDeleteCallEventToState(event);

    }

     if(event is FollowupTypeListByNameCallEvent)
    {
      yield* _mapFollowupTypeListCallEventToState(event);

    }

    if(event is InquiryLeadStatusTypeListByNameCallEvent){
      yield* _mapFollowupInquiryStatusListCallEventToState(event);
    }

    if(event is CloserReasonTypeListByNameCallEvent)
    {
      yield* _mapCloserReasonStatusListCallEventToState(event);

    }
    if(event is FollowupHistoryListRequestCallEvent)
    {
      yield* _mapFollowupHistoryListCallEventToState(event);

    }

    if(event is QuickFollowupListRequestEvent)
      {
        yield* _mapQuickFollowupEventToState(event);

      }

  }

  ///event functions to states implementation
  Stream<FollowupStates> _mapFollowupListCallEventToState(
      FollowupListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupListResponse response =
      await userRepository.getFollowupList(event.pageNo,event.followupListApiRequest);
      yield FollowupListCallResponseState(response,event.pageNo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  ///event functions to states implementation
  Stream<FollowupStates> _mapFollowupListbyStatusCallEventToState(
      SearchFollowupListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupListResponse response =
      await userRepository.getFollowupListbyStatus(event.request);
      yield SearchFollowupListByStatusCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }




  Stream<FollowupStates> _mapFollowupCustomerListByNameCallEventToState(
      SearchFollowupCustomerListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      CustomerLabelvalueRsponse response =
      await userRepository.getCustomerListSearchByName(event.request);
      yield FollowupCustomerListByNameCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }








  Stream<FollowupStates> _mapFollowupInquiryNoStatusListCallEventToState(
      FollowupInquiryNoListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupInquiryNoListResponse response =
      await userRepository.getInquiryNoStatusList(event.followerInquiryNoListRequest);
      yield FollowupInquiryNoListCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<FollowupStates> _mapFollowupSaveStatusListCallEventToState(
      FollowupSaveByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupSaveSuccessResponse response =
      await userRepository.getFollowupSaveStatus(event.pkID,event.followupSaveApiRequest);
      yield FollowupSaveCallResponseState(event.context,response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<FollowupStates> _mapQuickFollowupSaveStatusListCallEventToState(
      QuickFollowupSaveByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupSaveSuccessResponse response =
      await userRepository.getQuickFollowupSaveStatus(event.pkID,event.followupSaveApiRequest);
      yield FollowupSaveCallResponseState(event.context,response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }








/*  Stream<FollowupStates> _mapFollowupDeleteCallEventToState(
      FollowupDeleteByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupDeleteResponse response =
      await userRepository.getFollowupDeleteStatus(event.pkID,event.followupDeleteRequest);
      yield FollowupDeleteCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }*/

  Stream<FollowupStates> _mapDeleteInquiryCallEventToState(
      FollowupDeleteByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupDeleteResponse followupDeleteResponse = await userRepository.deleteFollowup(event.pkID,event.followupDeleteRequest);
      yield FollowupDeleteCallResponseState(followupDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<FollowupStates> _mapQuickFollowupDeleteInquiryCallEventToState(
      QuickFollowupDeleteByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupDeleteResponse followupDeleteResponse = await userRepository.deleteQuickFollowup(event.pkID,event.followupDeleteRequest);
      yield FollowupDeleteCallResponseState(followupDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }



  Stream<FollowupStates> _mapFollowupFilterListCallEventToState(
      FollowupFilterListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupFilterListResponse response =
      await userRepository.getFollowupFilterList(event.filtername,event.followupFilterListRequest);
      yield FollowupFilterListCallResponseState(event.followupFilterListRequest.PageNo,response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<FollowupStates> _mapFollowupInquiryByCustomerCallEventToState(
      FollowupInquiryByCustomerIDCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupInquiryByCustomerIDResponse response =
      await userRepository.getFollowupInquiryByCustomerID(event.followerInquiryByCustomerIDRequest);
      yield FollowupInquiryByCustomerIdCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

 /* Stream<FollowupStates> _mapFollowupTypeListCallEventToState(
      FollowupTypeListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupTypeListResponse response =
      await userRepository.getFollowupTypeList(event.followupTypeListRequest);
      yield FollowupTypeListCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }*/

  Stream<FollowupStates> _mapFollowupUploadImageCallEventToState(
      FollowupUploadImageNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupImageUploadResponse response =
      await userRepository.getFollowupuploadImage(event.expenseImageFile,event.expenseUploadImageAPIRequest);
      // print("RESPPDDDD" +  await userRepository.getuploadImage(event.expenseUploadImageAPIRequest).toString());
      yield FollowupUploadImageCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<FollowupStates> _mapFollowupImageDeleteCallEventToState(
      FollowupImageDeleteCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupDeleteImageResponse response =
      await userRepository.getFollowupImageDeleteByPkID(event.pkID,event.followupImageDeleteRequest);
      yield FollowupImageDeleteCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<FollowupStates> _mapFollowupTypeListCallEventToState(
      FollowupTypeListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupTypeListResponse response =
      await userRepository.getFollowupTypeList(event.followupTypeListRequest);
      yield FollowupTypeListCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<FollowupStates> _mapFollowupInquiryStatusListCallEventToState(
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

  Stream<FollowupStates> _mapCloserReasonStatusListCallEventToState(
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

  Stream<FollowupStates> _mapFollowupHistoryListCallEventToState(
      FollowupHistoryListRequestCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupHistoryListResponse response = await userRepository.getFollowupHistoryList(event.followupHistoryListRequest);
      yield FollowupHistoryListResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<FollowupStates> _mapQuickFollowupEventToState(
      QuickFollowupListRequestEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      QuickFollowupListResponse response = await userRepository.getQuickFollowupListAPi(event.quickFollowupListRequest);
      yield QuickFollowupListResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

}