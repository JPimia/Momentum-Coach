import 'package:equatable/equatable.dart';

class MealPlan extends Equatable {
  const MealPlan({required this.title, required this.calories, required this.description});
  final String title;
  final int calories;
  final String description;

  @override
  List<Object?> get props => [title, calories, description];
}

class TrainingPlan extends Equatable {
  const TrainingPlan({required this.title, required this.sessionsPerWeek, required this.description});
  final String title;
  final int sessionsPerWeek;
  final String description;

  @override
  List<Object?> get props => [title, sessionsPerWeek, description];
}


