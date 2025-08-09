part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();
  @override
  List<Object?> get props => [];
}

class LoadClientsEvent extends ClientEvent {}

class AssignMealPlanEvent extends ClientEvent {
  const AssignMealPlanEvent(this.clientId, this.plan);
  final String clientId;
  final MealPlan plan;
  @override
  List<Object?> get props => [clientId, plan];
}

class AssignTrainingPlanEvent extends ClientEvent {
  const AssignTrainingPlanEvent(this.clientId, this.plan);
  final String clientId;
  final TrainingPlan plan;
  @override
  List<Object?> get props => [clientId, plan];
}

class LogWeeklyProgressEvent extends ClientEvent {
  const LogWeeklyProgressEvent(this.clientId, this.progress);
  final String clientId;
  final WeeklyProgress progress;
  @override
  List<Object?> get props => [clientId, progress];
}
