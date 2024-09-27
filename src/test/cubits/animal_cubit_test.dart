
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';
import 'package:animal_switcher/cubits/animal_state.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		test('initial state is CatState', () {
			expect(animalCubit.state, equals(CatState()));
		});

		blocTest<AnimalCubit, AnimalState>(
			'emits [DogState] when toggleAnimal is called from CatState',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [DogState()],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits [CatState] when toggleAnimal is called from DogState',
			build: () => animalCubit,
			act: (cubit) {
				cubit.toggleAnimal(); // First, go to DogState
				cubit.toggleAnimal(); // Then, go back to CatState
			},
			expect: () => [DogState(), CatState()],
		);
	});
}
