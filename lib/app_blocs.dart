import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/app_events.dart';
import 'package:ulearning_app/app_states.dart';

class AppBlocs extends Bloc<AppEvents, AppStates> {
  AppBlocs() : super(InitStates()) {
    on<Increment>((event, serve) {
      serve(AppStates(counter: state.counter + 1));
      print(state.counter);
    });

    on<Decrement>((event, ask) {
      ask(AppStates(counter: state.counter - 1));
      print(state.counter);
    });
  }
}
