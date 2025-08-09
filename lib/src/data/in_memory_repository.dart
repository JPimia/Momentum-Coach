import 'dart:async';

import '../models/client.dart';
import '../models/plan.dart';
import '../models/progress.dart';

class InMemoryRepository {
  InMemoryRepository() {
    _seed();
  }

  final List<Client> _clients = [];

  Future<List<Client>> fetchClients() async {
    // Simulate small delay
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return List<Client>.unmodifiable(_clients);
  }

  Future<void> assignMealPlan(String clientId, MealPlan plan) async {
    final index = _clients.indexWhere((c) => c.id == clientId);
    if (index == -1) return;
    _clients[index] = _clients[index].copyWith(mealPlan: plan);
  }

  Future<void> assignTrainingPlan(String clientId, TrainingPlan plan) async {
    final index = _clients.indexWhere((c) => c.id == clientId);
    if (index == -1) return;
    _clients[index] = _clients[index].copyWith(trainingPlan: plan);
  }

  Future<void> logWeeklyProgress(String clientId, WeeklyProgress progress) async {
    final index = _clients.indexWhere((c) => c.id == clientId);
    if (index == -1) return;
    final current = List<WeeklyProgress>.from(_clients[index].weeklyProgress);
    current.add(progress);
    _clients[index] = _clients[index].copyWith(weeklyProgress: current);
  }

  void _seed() {
    _clients.addAll([
      Client(
        id: 'c1',
        name: 'Alex Johnson',
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
        weeklyProgress: const [
          WeeklyProgress(weekOfYear: 26, weightKg: 82.0, steps: 5200),
          WeeklyProgress(weekOfYear: 27, weightKg: 81.6, steps: 7400),
          WeeklyProgress(weekOfYear: 28, weightKg: 81.2, steps: 8100),
        ],
        mealPlan: const MealPlan(
          title: 'Lean Bulk',
          calories: 2800,
          description: 'High protein, moderate carbs, healthy fats',
        ),
        trainingPlan: const TrainingPlan(
          title: 'Upper/Lower 4x',
          sessionsPerWeek: 4,
          description: 'Compound focus split with progressive overload',
        ),
      ),
      Client(
        id: 'c2',
        name: 'Mia Patel',
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
        weeklyProgress: const [
          WeeklyProgress(weekOfYear: 26, weightKg: 65.2, steps: 6000),
          WeeklyProgress(weekOfYear: 27, weightKg: 64.9, steps: 7100),
          WeeklyProgress(weekOfYear: 28, weightKg: 64.6, steps: 8800),
        ],
        mealPlan: const MealPlan(
          title: 'Cutting',
          calories: 1900,
          description: 'Calorie deficit with high satiety foods',
        ),
        trainingPlan: const TrainingPlan(
          title: 'Full-Body 3x',
          sessionsPerWeek: 3,
          description: 'Strength + accessory work',
        ),
      ),
    ]);
  }
}


