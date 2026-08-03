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
  final state = ref.watch(ordenesProvider);

  if (state.isLoading) {
    return const Center(child: CircularProgressIndicator());
  }

  if (state.error != null) {
    return Center(child: Text(state.error!));
  }

  if (state.ordenes.isEmpty) {
    return const Center(child: Text("No hay órdenes"));
  }

  return RefreshIndicator(
    onRefresh: () async {
      // Aquí llamas a tu provider para recargar los datos
      await ref.read(ordenesProvider.notifier).loadOrdenes();
    },
    child: ListView.builder(
      itemCount: state.ordenes.length,
      itemBuilder: (context, index) {
        return OrdenCard(orden: state.ordenes[index]);
      },
    ),
  );
}

}
