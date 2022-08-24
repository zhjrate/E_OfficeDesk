import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'debit_note_events.dart';
part 'debit_note_states.dart';

class DebitNoteBloc extends Bloc<DebitNoteEvents, DebitNoteStates> {
  Repository repository = Repository.getInstance();
  BaseBloc baseBloc;

  DebitNoteBloc(this.baseBloc) : super(DebitNoteInitialState());

  @override
  Stream<DebitNoteStates> mapEventToState(DebitNoteEvents event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
