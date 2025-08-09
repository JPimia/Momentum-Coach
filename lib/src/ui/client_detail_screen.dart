import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/client_bloc.dart';
import '../models/client.dart';
import '../models/plan.dart';
import '../models/progress.dart';

class ClientDetailScreen extends StatelessWidget {
  const ClientDetailScreen({super.key, required this.client});
  final Client client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(client.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(client.avatarUrl), radius: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(client.trainingPlan?.title ?? 'No training plan'),
                      Text(client.mealPlan?.title ?? 'No meal plan', style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.restaurant_menu_outlined),
                  label: const Text('Assign Meal Plan'),
                  onPressed: () {
                    context.read<ClientBloc>().add(
                          AssignMealPlanEvent(
                            client.id,
                            const MealPlan(
                              title: 'Balanced 2200',
                              calories: 2200,
                              description: 'Protein 150g / Carbs 220g / Fat 70g',
                            ),
                          ),
                        );
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.fitness_center_outlined),
                  label: const Text('Assign Training'),
                  onPressed: () {
                    context.read<ClientBloc>().add(
                          AssignTrainingPlanEvent(
                            client.id,
                            const TrainingPlan(
                              title: 'Push/Pull/Legs 5x',
                              sessionsPerWeek: 5,
                              description: 'Power-building split',
                            ),
                          ),
                        );
                  },
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.add_chart),
                  label: const Text('Log Weekly Progress'),
                  onPressed: () {
                    final nextWeek = (client.weeklyProgress.isEmpty
                            ? 1
                            : client.weeklyProgress.last.weekOfYear + 1)
                        .clamp(1, 53);
                    context.read<ClientBloc>().add(
                          LogWeeklyProgressEvent(
                            client.id,
                            WeeklyProgress(weekOfYear: nextWeek, weightKg: 80.0, steps: 8000),
                          ),
                        );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Weekly Progress', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<ClientBloc, ClientState>(
                builder: (context, state) {
                  final latest = state.clients.firstWhere((c) => c.id == client.id, orElse: () => client);
                  final progress = latest.weeklyProgress.reversed.toList();
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final p = progress[index];
                      return ListTile(
                        leading: const Icon(Icons.trending_up),
                        title: Text('Week ${p.weekOfYear}'),
                        subtitle: Text('Weight: ${p.weightKg.toStringAsFixed(1)} kg • Steps: ${p.steps}'),
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemCount: progress.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


