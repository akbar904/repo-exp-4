
import 'package:flutter_bloc/flutter_bloc.dart';

// Base class for animal states
abstract class AnimalState {}

// State representing a cat
class CatState extends AnimalState {}

// State representing a dog
class DogState extends AnimalState {}

// Cubit to manage animal states
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
