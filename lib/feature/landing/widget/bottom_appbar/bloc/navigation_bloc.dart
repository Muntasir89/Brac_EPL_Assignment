import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NavigationEvent {}

class NavigationTabChanged extends NavigationEvent {
  final int index;
  NavigationTabChanged(this.index);
}

// State
class NavigationState {
  final int selectedIndex;

  NavigationState({required this.selectedIndex});

  NavigationState copyWith({int? selectedIndex}) {
    return NavigationState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}

// Bloc
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(selectedIndex: 0)) {
    on<NavigationTabChanged>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}
