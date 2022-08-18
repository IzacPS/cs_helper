import 'package:bloc/bloc.dart';

part 'load_visualization_event.dart';
part 'load_visualization_state.dart';

class LoadVisualizationBloc extends Bloc<LoadVisualizationEvent, LoadVisualizationState> {
  LoadVisualizationBloc() : super(LoadVisualizationInitial()) {
    on<LoadVisualizationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
