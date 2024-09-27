
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animal_switcher/main.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('MainApp', () {
		testWidgets('renders AnimalScreen', (tester) async {
			await tester.pumpWidget(MainApp());
			expect(find.byType(AnimalScreen), findsOneWidget);
		});

		group('AnimalCubit', () {
			late AnimalCubit animalCubit;

			setUp(() {
				animalCubit = MockAnimalCubit();
			});

			blocTest<AnimalCubit, AnimalState>(
				'initial state is CatState',
				build: () => animalCubit,
				verify: (_) {
					expect(animalCubit.state, isA<CatState>());
				},
			);

			blocTest<AnimalCubit, AnimalState>(
				'emits DogState when toggleAnimal is called while in CatState',
				build: () => animalCubit,
				seed: () => CatState(),
				act: (cubit) => cubit.toggleAnimal(),
				expect: () => [isA<DogState>()],
			);

			blocTest<AnimalCubit, AnimalState>(
				'emits CatState when toggleAnimal is called while in DogState',
				build: () => animalCubit,
				seed: () => DogState(),
				act: (cubit) => cubit.toggleAnimal(),
				expect: () => [isA<CatState>()],
			);
		});
	});
}
