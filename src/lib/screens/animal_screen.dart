
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';
import 'package:animal_switcher/cubits/animal_state.dart';
import 'package:animal_switcher/models/animal_model.dart';

class AnimalScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Animal Switcher'),
			),
			body: Center(
				child: BlocBuilder<AnimalCubit, AnimalState>(
					builder: (context, state) {
						final animal = state is CatState
							? Animal(name: 'Cat', icon: Icons.access_time)
							: Animal(name: 'Dog', icon: Icons.person);

						return GestureDetector(
							onTap: () => context.read<AnimalCubit>().toggleAnimal(),
							child: Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									Text(
										animal.name,
										style: TextStyle(fontSize: 24),
									),
									SizedBox(height: 16),
									Icon(
										animal.icon,
										size: 48,
									),
								],
							),
						);
					},
				),
			),
		);
	}
}
