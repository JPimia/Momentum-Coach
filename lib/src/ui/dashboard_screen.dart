import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/client_bloc.dart';
import '../models/client.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'T',
                  style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text('FITBENV COACHING', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: colorScheme.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Yleiskatsaus'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Kirjasto'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profiili'),
        ],
      ),
      body: BlocBuilder<ClientBloc, ClientState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final today = DateFormat('d.M.yyyy').format(DateTime.now());
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _SegmentChip(label: 'Oma yleiskatsaus', selected: true),
                    const SizedBox(width: 12),
                    const _SegmentChip(label: 'Edistykseni'),
                  ],
                ),
                const SizedBox(height: 16),
                Card(
                  color: const Color(0xFF6C7A6F),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/100')),
                    title: const Text('On aika tehdä tilannekatsaus', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    subtitle: Text('Päivä: $today', style: const TextStyle(color: Colors.white70)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Viikoittaiset tavoitteet', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                _GoalsCard(),
                const SizedBox(height: 16),
                const Text('Aktiiviteetti ja askeleet', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                const _StepsCard(stepsToday: 7534),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Viimeisimmät harjoitukset', style: TextStyle(fontWeight: FontWeight.w700)),
                    Text('Katso kaikki  ›'),
                  ],
                ),
                const SizedBox(height: 8),
                ...state.clients.map((c) => _WorkoutTile(client: c)),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SegmentChip extends StatelessWidget {
  const _SegmentChip({required this.label, this.selected = false});
  final String label;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF6C7A6F) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: TextStyle(color: selected ? Colors.white : Colors.black87, fontWeight: FontWeight.w600)),
    );
  }
}

class _GoalsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const ListTile(
        leading: Icon(Icons.flag_outlined),
        title: Text('Aseta yksinkertaisia viikoittaisia tavoitteita, jotta saat motivaatiota.'),
      ),
    );
  }
}

class _StepsCard extends StatelessWidget {
  const _StepsCard({required this.stepsToday});
  final int stepsToday;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ASKELEET', style: TextStyle(letterSpacing: 1.2, color: Colors.grey)),
            Text('$stepsToday', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Row(
              children: List.generate(7, (index) {
                final height = 10 + (index * 6).toDouble();
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Container(
                      height: height,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB8C1B0),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class _WorkoutTile extends StatelessWidget {
  const _WorkoutTile({required this.client});
  final Client client;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=300&auto=format&fit=crop',
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(client.trainingPlan?.title ?? 'Harjoitus'),
        subtitle: Text('Viimeisin viikko: ${client.weeklyProgress.isNotEmpty ? client.weeklyProgress.last.weekOfYear : '-'}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text('Heinä', style: TextStyle(color: Colors.grey)),
            Text('09, 2025'),
          ],
        ),
      ),
    );
  }
}


