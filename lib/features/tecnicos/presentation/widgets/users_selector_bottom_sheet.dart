import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/tecnicos/presentation/providers/users_provider.dart';

class UsersSelectorBottomSheet extends ConsumerStatefulWidget {
  const UsersSelectorBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UsersSelectorBottomSheetState();
}

class _UsersSelectorBottomSheetState
    extends ConsumerState<UsersSelectorBottomSheet> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(usersProvider.notifier).loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(usersProvider);

    return SizedBox(
      height: MediaQuery.of(context).size.height * .75,
      child: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            "Seleccionar Técnico",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const Divider(),
          
          Expanded(
            child: Builder(
              builder: (_) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.error != null) {
                  return Center(child: Text(state.error!));
                }
                if (state.users.isEmpty) {
                  return const Center(child: Text("No hay Técnicos registrados"));
                }
                return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (_, index) {
                    final tecnico = state.users[index];
                    return ListTile(
                      onTap: () {
                        Navigator.pop(context, tecnico);
                      },
                      title: Text(tecnico.nombre),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
