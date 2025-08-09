import 'package:equatable/equatable.dart';

class WeeklyProgress extends Equatable {
  const WeeklyProgress({required this.weekOfYear, required this.weightKg, required this.steps});
  final int weekOfYear;
  final double weightKg;
  final int steps; // average steps per day for the week

  @override
  List<Object?> get props => [weekOfYear, weightKg, steps];
}


