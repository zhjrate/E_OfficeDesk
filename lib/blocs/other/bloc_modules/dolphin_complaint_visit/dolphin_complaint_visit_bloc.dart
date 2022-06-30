
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/dolphin_complaint_search_request.dart';
import 'package:soleoserp/models/api_requests/dolphin_complaint_visit_delete_request.dart';
import 'package:soleoserp/models/api_requests/dolphin_complaint_visit_list_request.dart';
import 'package:soleoserp/models/api_requests/dolphin_complaint_visit_save_request.dart';
import 'package:soleoserp/models/api_requests/dolphin_complaint_visit_search_by_id_request.dart';
import 'package:soleoserp/models/api_responses/dolphin_complaint_search_response.dart';
import 'package:soleoserp/models/api_responses/dolphin_complaint_visit_delete_response.dart';
import 'package:soleoserp/models/api_responses/dolphin_complaint_visit_list_response.dart';
import 'package:soleoserp/models/api_responses/dolphin_complaint_visit_save_response.dart';
import 'package:soleoserp/repositories/repository.dart';



part 'dolphin_complaint_visit_event.dart';


part 'dolphin_complaint_visit_state.dart';

class DolphinComplaintVisitBloc extends Bloc<DolphinComplaintVisitEvents, DolphinComplaintVisitStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  DolphinComplaintVisitBloc(this.baseBloc) : super(DolphinComplaintVisitInitialState());

  @override
  Stream<DolphinComplaintVisitStates> mapEventToState(DolphinComplaintVisitEvents event) async* {
    if (event is DolphinComplaintVisitListCallEvent) {
      yield* _mapAttenVisitCallEventToState(event);
    }
    if(event is DolphinComplaintSearchByNameCallEvent)
      {
        yield* _mapSearchByNameCallEventToState(event);

      }
    if(event is DolphinComplaintVisitSearchByIDCallEvent)
    {
      yield* _mapSearchByIDCallEventToState(event);

    }
    if(event is DolphinComplaintVisitDeleteCallEvent)
      {
        yield* _mapDolphinComplaintVisitDeleteCallEventToState(event);

      }
    if(event is DolphinComplaintVisitSaveCallEvent)
    {
      yield* _mapDolphinComplaintVisitSaveCallEventToState(event);

    }


  }


  Stream<DolphinComplaintVisitStates> _mapAttenVisitCallEventToState(
      DolphinComplaintVisitListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      // CustomerCategoryResponse loginResponse =

      /* List<CustomerCategoryResponse> customercategoryresponse*/
      DolphinComplaintVisitListResponse respo =  await userRepository.getDolphinComplaintVisitList(event.pageNo,event.dolphinComplaintVisitListRequest);

      yield DolphinComplaintVisitListCallResponseState(event.pageNo,respo);

    } catch (error, stacktrace) {
      print(error.toString());
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<DolphinComplaintVisitStates> _mapSearchByNameCallEventToState(
      DolphinComplaintSearchByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      DolphinComplaintSearchResponse response =
      await userRepository.getDolphinComplaintSearchByName(event.dolphinComplaintSearchRequest);
      yield DolphinComplaintSearchByNameResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }




  Stream<DolphinComplaintVisitStates> _mapSearchByIDCallEventToState(
      DolphinComplaintVisitSearchByIDCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      DolphinComplaintVisitListResponse response = await userRepository.getDolphinComplaintVisitSearchByID(event.pkID,event.dolphinComplaintSearchByIDRequest);
      yield DolphinComplaintVisitSearchByIDResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<DolphinComplaintVisitStates> _mapDolphinComplaintVisitDeleteCallEventToState(
      DolphinComplaintVisitDeleteCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      DolphinComplaintVisitDeleteResponse response = await userRepository.getDolphinComplaintVisitDelete(event.dolphinComplaintVisitDeleteRequest);
      yield DolphinComplaintVisitDeleteResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  //DolphinComplaintVisitSaveResponseState
  // DolphinComplaintVisitSaveResponse
 //DolphinComplaintVisitSaveCallEvent
//DolphinComplaintVisitSaveRequest


  Stream<DolphinComplaintVisitStates> _mapDolphinComplaintVisitSaveCallEventToState(
      DolphinComplaintVisitSaveCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      DolphinComplaintVisitSaveResponse response = await userRepository.getDolphinComplaintVisitSave(event.pkID,event.dolphinComplaintVisitSaveRequest);
      yield DolphinComplaintVisitSaveResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

}