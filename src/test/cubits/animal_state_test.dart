
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:animal_switcher/cubits/animal_state.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalState', () {
		test('CatState should be a subclass of AnimalState', () {
			expect(CatState(), isA<AnimalState>());
		});
		
		test('DogState should be a subclass of AnimalState', () {
			expect(DogState(), isA<AnimalState>());
		});
	});

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
			'emits [DogState] when toggleAnimal is called and current state is CatState',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [DogState()],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits [CatState] when toggleAnimal is called and current state is DogState',
			build: () => animalCubit,
			seed: () => DogState(),
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [CatState()],
		);
	});
}
