import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/checking_no_to_checking_items_request.dart';
import 'package:soleoserp/models/api_requests/final_checking_delete_all_items_request.dart';
import 'package:soleoserp/models/api_requests/final_checking_header_save_request.dart';
import 'package:soleoserp/models/api_requests/final_checking_items_request.dart';
import 'package:soleoserp/models/api_requests/final_checking_list_request.dart';
import 'package:soleoserp/models/api_requests/out_word_no_list_request.dart';
import 'package:soleoserp/models/api_requests/search_finalchecking_request.dart';
import 'package:soleoserp/models/api_responses/checking_no_to_checking_item_response.dart';
import 'package:soleoserp/models/api_responses/final_checking_delete_all_item_response.dart';
import 'package:soleoserp/models/api_responses/final_checking_items_response.dart';
import 'package:soleoserp/models/api_responses/final_checking_list_response.dart';
import 'package:soleoserp/models/api_responses/final_checking_sub_details_response.dart';
import 'package:soleoserp/models/api_responses/final_cheking_header_save_response.dart';
import 'package:soleoserp/models/api_responses/out_word_no_list_response.dart';
import 'package:soleoserp/models/api_responses/packing_no_list_response.dart';
import 'package:soleoserp/models/api_responses/search_finalchecking_label_response.dart';
import 'package:soleoserp/models/common/final_checking_items.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'final_checking_event.dart';
part 'final_checking_state.dart';

class FinalCheckingBloc extends Bloc<FinalCheckingListEvent, FinalCheckingListState> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;


  ///Bloc Constructor
  FinalCheckingBloc(this.baseBloc) : super(FinalCheckingListInitialState());

  @override
  Stream<FinalCheckingListState> mapEventToState(
      FinalCheckingListEvent event) async* {

    /// Check If Event is Exist from below Function
    if (event is FinalCheckingListCallEvent) {
      yield* _mapFinalCheckingListCallEventToState(event);
    }if (event is SearchFinalCheckingCallEvent) {
      yield* _mapSearchFinalCheckingCallEventToState(event);
    }if (event is SearchFinalCheckingLabelCallEvent) {
      yield* _mapSearchFinalCheckingLabelCallEventToState(event);
    }

    if (event is OutWordCallEvent) {
      yield* _mapPackingListCallEventToState(event);
    }

    if (event is FinalCheckingItemsRequestCallEvent) {
      yield* _mapFinalCheckingItemsCallEventToState(event);
    }

    if (event is CheckingNoToCheckingItemsRequestCallEvent) {
      yield* _mapCheckingNoToCheckingItemsEventToState(event);
    }

    if (event is FinalCheckingHeaderSaveRequestCallEvent) {
      yield* _mapFinalCheckingHeaderSaveEventToState(event);
    }

    if (event is FinalCheckingSubDetailsSaveCallEvent) {
      yield* _mapPackingAssamblySaveEventToState(event);
    }
    if (event is FinalCheckingDeleteAllItemRequestCallEvent) {
      yield* _mapFinalCheckingDeleteAllItemRequestEventToState(event);
    }

    if (event is FinalCheckingDeleteCallEvent) {
      yield* _mapFinalCheckingDeleteEventToState(event);
    }





  }



  Stream<FinalCheckingListState> _mapFinalCheckingListCallEventToState(
      FinalCheckingListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      FinalCheckingListResponse respo =  await userRepository.FinalCheckingListCall(event.pageNo,event.finalCheckingListRequest);

      yield FinalCheckingListCallResponseState(event.pageNo,respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<FinalCheckingListState> _mapSearchFinalCheckingCallEventToState(
      SearchFinalCheckingCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      FinalCheckingListResponse respo =  await userRepository.searchfinalchecking(event.searchFinalCheckingRequest);

      yield SearchFinalCheckingCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<FinalCheckingListState> _mapSearchFinalCheckingLabelCallEventToState(
      SearchFinalCheckingLabelCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      SearchFinalCheckingLabelResponse respo =  await userRepository.searchfinalcheckinglabel(event.searchFinalCheckingRequest);

      yield SearchFinalCheckingLabelCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<FinalCheckingListState> _mapPackingListCallEventToState(
      OutWordCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      PackingNoListResponse respo =
      await userRepository.PackingNoListAPI(event.outWordNoListRequest);
      yield PackingNoListResponseState(respo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<FinalCheckingListState> _mapFinalCheckingItemsCallEventToState(
      FinalCheckingItemsRequestCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      FinalCheckingItemsResponse respo =
      await userRepository.FinalCheckingItemsAPI(event.finalCheckingItemsRequest);
      yield FinalCheckingItemsResponseState(respo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<FinalCheckingListState> _mapCheckingNoToCheckingItemsEventToState(
      CheckingNoToCheckingItemsRequestCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      CheckingNoToCheckingItemsResponse respo =
      await userRepository.CheckingNoToCheckingItemsAPI(event.checkingNoToCheckingItemsRequest);
      yield CheckingNoToCheckingItemsResponseState(respo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<FinalCheckingListState> _mapFinalCheckingHeaderSaveEventToState(
      FinalCheckingHeaderSaveRequestCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      FinalCheckingHeaderSaveResponse respo =
      await userRepository.finalCheckingHeaderSaveApi(event.pkID,event.finalCheckingHeaderSaveRequest);
      yield FinalCheckingHeaderSaveResponseState(respo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<FinalCheckingListState> _mapPackingAssamblySaveEventToState(
      FinalCheckingSubDetailsSaveCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      FinalCheckingSubDetailsSaveResponse respo = await userRepository
          .finalCheckingSubDetailsSaveAPI(event.finalCheckingItems);
      yield FinalCheckingSubDetailsSaveResponseState(respo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<FinalCheckingListState> _mapFinalCheckingDeleteAllItemRequestEventToState(
      FinalCheckingDeleteAllItemRequestCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      FinalCheckingDeleteAllItemResponse respo =
      await userRepository.finalCheckingDeleteAllItemApi(event.FinalcheckingNo,event.finalCheckingDeleteAllItemsRequest);
      yield FinalCheckingDeleteAllItemResponseState(respo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<FinalCheckingListState> _mapFinalCheckingDeleteEventToState(
      FinalCheckingDeleteCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      FinalCheckingDeleteAllItemResponse respo =
      await userRepository.finalCheckingDeleteApi(event.pkID,event.finalCheckingDeleteAllItemsRequest);
      yield FinalCheckingDeleteResponseState(respo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

}
