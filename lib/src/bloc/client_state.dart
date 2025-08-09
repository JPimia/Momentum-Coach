part of 'client_bloc.dart';

class ClientState extends Equatable {
  const ClientState({
    required this.isLoading,
    required this.clients,
  });

  const ClientState.initial()
      : isLoading = false,
        clients = const [];

  final bool isLoading;
  final List<Client> clients;

  ClientState copyWith({
    bool? isLoading,
    List<Client>? clients,
  }) {
    return ClientState(
      isLoading: isLoading ?? this.isLoading,
      clients: clients ?? this.clients,
    );
  }

  @override
  List<Object?> get props => [isLoading, clients];
}


