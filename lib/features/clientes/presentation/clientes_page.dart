import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/ordenes_provider.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/widgets/orden_card.dart';

class ClientesPage extends ConsumerStatefulWidget {
  const ClientesPage({super.key});
  @override
  ConsumerState<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends ConsumerState<ClientesPage> {
  @override
  void initState() {
    super.initState();
    
    Future.microtask(() {
      ref.read(ordenesProvider.notifier).loadOrdenes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ordenesProvider);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text(state.error!));
    }

    if (state.ordenes.isEmpty) {
      return const Center(child: Text("No hay clientes"));
    }

    return ListView.builder(
      itemCount: state.ordenes.length,
      itemBuilder: (context, index) {
        return OrdenCard(orden: state.ordenes[index]);
      },
    );
  }
}
