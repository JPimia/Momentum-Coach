import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/in_memory_repository.dart';
import '../models/client.dart';
import '../models/plan.dart';
import '../models/progress.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  ClientBloc(this.repository) : super(const ClientState.initial()) {
    on<LoadClientsEvent>(_onLoadClients);
    on<AssignMealPlanEvent>(_onAssignMealPlan);
    on<AssignTrainingPlanEvent>(_onAssignTrainingPlan);
    on<LogWeeklyProgressEvent>(_onLogWeeklyProgress);
  }

  final InMemoryRepository repository;

  Future<void> _onLoadClients(LoadClientsEvent event, Emitter<ClientState> emit) async {
    emit(state.copyWith(isLoading: true));
    final clients = await repository.fetchClients();
    emit(state.copyWith(isLoading: false, clients: clients));
  }

  Future<void> _onAssignMealPlan(AssignMealPlanEvent event, Emitter<ClientState> emit) async {
    await repository.assignMealPlan(event.clientId, event.plan);
    final updated = await repository.fetchClients();
    emit(state.copyWith(clients: updated));
  }

  Future<void> _onAssignTrainingPlan(
    AssignTrainingPlanEvent event,
    Emitter<ClientState> emit,
  ) async {
    await repository.assignTrainingPlan(event.clientId, event.plan);
    final updated = await repository.fetchClients();
    emit(state.copyWith(clients: updated));
  }

  Future<void> _onLogWeeklyProgress(LogWeeklyProgressEvent event, Emitter<ClientState> emit) async {
    await repository.logWeeklyProgress(event.clientId, event.progress);
    final updated = await repository.fetchClients();
    emit(state.copyWith(clients: updated));
  }
}
