
import 'package:flutter_bloc/flutter_bloc.dart';
import 'animal_state.dart';

class AnimalCubit extends Cubit<AnimalState> {
	AnimalCubit() : super(CatState());

	void toggleAnimal() {
		if (state is CatState) {
			emit(DogState());
		} else {
			emit(CatState());
		}
	}
}
