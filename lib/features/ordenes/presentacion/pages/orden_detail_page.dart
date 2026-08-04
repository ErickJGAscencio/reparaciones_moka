import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/ordenes_provider.dart';

class OrdenDetailPage extends ConsumerStatefulWidget {
  final int id;
  const OrdenDetailPage({super.key, required this.id});

  @override
  ConsumerState<OrdenDetailPage> createState() => _OrdenDetailPageState();
}

class _OrdenDetailPageState extends ConsumerState<OrdenDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(ordenesProvider.notifier).loadOrdenById(widget.id);
    });
  }

  Widget _buildPil(String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F775A)),
      ),
    );
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

    if (state.selectedOrden == null) {
      return const Center(child: Text("No se encontró la orden"));
    }

    final orden = state.selectedOrden!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F775A),
        title: Text(
          'Orden #${orden.id}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF2F775A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${orden.id}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        orden.cliente.nombre,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                      Text(
                        '${orden.marca} - ${orden.modelo}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                  _buildPil(orden.estadoReparacion.nombre),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.blueGrey),
                        const SizedBox(width: 8),
                        Text(
                          'Cliente',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nombre',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          orden.cliente.nombre,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Técnico asignado',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          orden.tecnico?.nombre ?? "-",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.settings, color: Colors.blueGrey),
                      Text(
                        'Equipo y falla',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Equipo',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '${orden.marca}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Modelo',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '${orden.modelo}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Falla reportada',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '${orden.fallaReporte}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Accesorios recibidos',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '${orden.accesorios}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.payment, color: Colors.blueGrey),
                      Text(
                        'Costos y pago',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Costo',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '${orden.costo}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Anticipo',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '${orden.anticipo}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Saldo pendiente',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '${orden.saldoPendiente}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.phone),
                    label: const Text(
                      "Llamar",
                      style: TextStyle(color: Color(0xFF2F775A)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Implementar la funcionalidad de imprimir
                    },
                    icon: const Icon(Icons.print, color: Colors.white),
                    label: const Text(
                      "Imprimir",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F775A),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
