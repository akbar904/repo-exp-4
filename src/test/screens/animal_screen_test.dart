
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animal_switcher/screens/animal_screen.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';
import 'package:animal_switcher/cubits/animal_state.dart';
import 'package:animal_switcher/models/animal_model.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalScreen Widget Tests', () {
		testWidgets('Initial state displays Cat with clock icon', (WidgetTester tester) async {
			final mockAnimalCubit = MockAnimalCubit();
			when(() => mockAnimalCubit.state).thenReturn(CatState());

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: mockAnimalCubit,
						child: AnimalScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('Tapping text switches to Dog with person icon', (WidgetTester tester) async {
			final mockAnimalCubit = MockAnimalCubit();
			whenListen(
				mockAnimalCubit,
				Stream.fromIterable([CatState(), DogState()]),
				initialState: CatState(),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: mockAnimalCubit,
						child: AnimalScreen(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});

	group('AnimalCubit Logic Tests', () {
		blocTest<AnimalCubit, AnimalState>(
			'emits [DogState] when toggleAnimal is called on CatState',
			build: () => AnimalCubit(),
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [DogState()],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits [CatState] when toggleAnimal is called on DogState',
			build: () => AnimalCubit()..emit(DogState()),
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [CatState()],
		);
	});
}
