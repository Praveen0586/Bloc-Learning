import 'package:flutter_application_2/visibilityBloc/visibilityEvent.dart';
import 'package:flutter_application_2/visibilityBloc/visibilityState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Visibiltybloc extends Bloc<VisibilityEvent, Visibilitystate> {
  Visibiltybloc() : super(Visibilitystate(visible: true)) {
    on<VisiBilityShowEevent>(
        (event, emit) => emit(Visibilitystate(visible: true)));

    on<VisibilityHideEvent>(
        (event, emii) => emii(Visibilitystate(visible: false)));
  }
}
