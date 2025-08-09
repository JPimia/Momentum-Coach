import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/client_bloc.dart';
import '../../models/client.dart';
import '../client_detail_screen.dart';

class ClientList extends StatelessWidget {
  const ClientList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        if (state.isLoading) return const Center(child: CircularProgressIndicator());
        return ListView.separated(
          itemCount: state.clients.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final client = state.clients[index];
            return _ClientTile(client: client);
          },
        );
      },
    );
  }
}

class _ClientTile extends StatelessWidget {
  const _ClientTile({required this.client});
  final Client client;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(client.avatarUrl)),
      title: Text(client.name),
      subtitle: Text(client.trainingPlan?.title ?? 'No training plan'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ClientDetailScreen(client: client)),
      ),
    );
  }
}


