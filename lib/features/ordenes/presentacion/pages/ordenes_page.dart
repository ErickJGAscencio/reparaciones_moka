import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/core/widgets/search_bar_custom.dart';
import 'package:reparaciones_moka/features/ordenes/domain/entities/orden.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/ordenes_provider.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/widgets/orden_card.dart';

class OrdenesPage extends ConsumerStatefulWidget {
  const OrdenesPage({super.key});

  @override
  ConsumerState<OrdenesPage> createState() => _OrdenesPageState();
}

class _OrdenesPageState extends ConsumerState<OrdenesPage> {
  String query = "";
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(ordenesProvider.notifier).loadOrdenes();
    });
  }

  List<Orden> _filtrarOrdenes(List<Orden> ordenes) {
    if (query.isEmpty) return ordenes;

    final q = query.toLowerCase();

    return ordenes.where((c) {
      return c.cliente.nombre.toLowerCase().contains(q) ||
      c.id.toString().toLowerCase().contains(q) ||
      c.estadoReparacion.nombre.toLowerCase().contains(q);
    }).toList();
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

    final ordenesFiltrados = _filtrarOrdenes(state.ordenes);

    return RefreshIndicator(
      onRefresh: () async {
        // Aquí llamas a tu provider para recargar los datos
        await ref.read(ordenesProvider.notifier).loadOrdenes();
      },
      child: Column(
        children: [
          SearchBarCustom(
            hintText: "orden",
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ordenesFiltrados.length,
              itemBuilder: (context, index) {
                final orden = ordenesFiltrados[index];

                return OrdenCard(orden: orden);
              },
            ),
          ),
        ],
      ),
    );
  }
}
