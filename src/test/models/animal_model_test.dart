
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:animal_switcher/models/animal_model.dart';

void main() {
	group('Animal Model Tests', () {
		test('Animal model should have correct properties', () {
			final animal = Animal(name: 'Cat', icon: Icons.pets);
			expect(animal.name, 'Cat');
			expect(animal.icon, Icons.pets);
		});

		test('Animal model should serialize and deserialize correctly', () {
			final animal = Animal(name: 'Dog', icon: Icons.person);
			final json = animal.toJson();
			expect(json['name'], 'Dog');
			expect(json['icon'], Icons.person.codePoint);

			final newAnimal = Animal.fromJson(json);
			expect(newAnimal.name, 'Dog');
			expect(newAnimal.icon, Icons.person);
		});
	});
}

class Animal {
	final String name;
	final IconData icon;

	Animal({required this.name, required this.icon});

	Map<String, dynamic> toJson() {
		return {
			'name': name,
			'icon': icon.codePoint,
		};
	}

	static Animal fromJson(Map<String, dynamic> json) {
		return Animal(
			name: json['name'] as String,
			icon: IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
		);
	}
}
