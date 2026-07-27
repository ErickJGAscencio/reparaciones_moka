import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/ordenes_provider.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/widgets/orden_card.dart';

class OrdenesPage extends ConsumerStatefulWidget {
  const OrdenesPage({super.key});

  @override
  ConsumerState<OrdenesPage> createState() => _OrdenesPageState();
}

class _OrdenesPageState extends ConsumerState<OrdenesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(ordenesProvider.notifier).loadOrdenes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ordenesState = ref.watch(ordenesProvider);

    if (ordenesState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (ordenesState.error != null) {
      return Center(child: Text(ordenesState.error!));
    }

    if (ordenesState.ordenes.isEmpty) {
      return Center(child: Text("No hay órdenes"));
    }

    return ListView.builder(
      itemCount: ordenesState.ordenes.length,
      itemBuilder: (context, index) {
        final orden = ordenesState.ordenes[index];
        return OrdenCard(orden: orden);
      },
    );
  }
}
