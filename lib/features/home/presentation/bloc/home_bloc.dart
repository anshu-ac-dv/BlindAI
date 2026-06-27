import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/process_command_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProcessCommandUseCase processCommandUseCase;

  HomeBloc({required this.processCommandUseCase}) : super(HomeInitial()) {
    on<CommandSubmitted>((event, emit) async {
      emit(HomeLoading());
      final result = await processCommandUseCase(event.command);
      result.fold(
        (failure) => emit(HomeError(failure.message)),
        (message) => emit(HomeCommandSuccess(message)),
      );
    });
  }
}
