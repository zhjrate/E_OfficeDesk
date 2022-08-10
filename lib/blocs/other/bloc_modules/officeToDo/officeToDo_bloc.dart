
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'officeToDo_event.dart';
part 'officeToDo_state.dart';

class OfficeToDoScreenBloc
    extends Bloc<OfficeToDoEvent, OfficeToDoScreenStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  OfficeToDoScreenBloc(this.baseBloc) : super(OfficeToDoScreenInitialState());

  @override
  Stream<OfficeToDoScreenStates> mapEventToState(
      OfficeToDoEvent event) async* {

  }


}
