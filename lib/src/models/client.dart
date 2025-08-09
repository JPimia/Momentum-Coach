import 'package:equatable/equatable.dart';

import 'plan.dart';
import 'progress.dart';

class Client extends Equatable {
  const Client({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.weeklyProgress,
    this.mealPlan,
    this.trainingPlan,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final List<WeeklyProgress> weeklyProgress;
  final MealPlan? mealPlan;
  final TrainingPlan? trainingPlan;

  Client copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    List<WeeklyProgress>? weeklyProgress,
    MealPlan? mealPlan,
    TrainingPlan? trainingPlan,
  }) {
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      weeklyProgress: weeklyProgress ?? this.weeklyProgress,
      mealPlan: mealPlan ?? this.mealPlan,
      trainingPlan: trainingPlan ?? this.trainingPlan,
    );
  }

  @override
  List<Object?> get props => [id, name, avatarUrl, weeklyProgress, mealPlan, trainingPlan];
}


