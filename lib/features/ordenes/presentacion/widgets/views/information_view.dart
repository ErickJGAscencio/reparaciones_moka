import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/ordenes/domain/entities/orden.dart';

class InformationView extends ConsumerStatefulWidget {
  final Orden orden;

  const InformationView({required this.orden});

  @override
  ConsumerState<InformationView> createState() => _InformationView();
}

class _InformationView extends ConsumerState<InformationView> {
  Widget _infoRow(String tag, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(tag, style: Theme.of(context).textTheme.bodyLarge),
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }

  Widget _pill(String label) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 56, 122, 59),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orden = widget.orden;
    final accesorios = orden.accesorios.isNotEmpty
        ? orden.accesorios.split(", ").map((a) => a.trim()).toList()
        : ["Ninguno"];

    return SingleChildScrollView(
      child: Column(
        children: [
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
                      const Icon(
                        Icons.person,
                        color: const Color.fromARGB(255, 56, 122, 59),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Cliente',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _infoRow("Nombre", orden.cliente.nombre),
                  _infoRow("Técnico asignado", orden.tecnico!.nombre),
                  _infoRow(
                    "Fecha de ingreo",
                    orden.fechaIngreso.toIso8601String(),
                  ),
                ],
              ),
            ),
          ),
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
                      const Icon(
                        Icons.settings,
                        color: const Color.fromARGB(255, 56, 122, 59),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Equipo y falla',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  _infoRow("Equipo", orden.marca),
                  _infoRow("Modelo", orden.modelo),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Falle reportada',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 4),
                      Text(
                        orden.fallaReporte,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Accesorios',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 4),
                      Wrap(
                        children: [
                          const SizedBox(width: 8),
                          ...accesorios.map(
                            (accesorio) => Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: _pill(accesorio),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
                      const Icon(
                        Icons.settings,
                        color: const Color.fromARGB(255, 56, 122, 59),
                      ),
                      const SizedBox(width: 8),
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
                        '\$${orden.costo.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
                        '${orden.anticipo > 0 ? "\$" + orden.anticipo.toStringAsFixed(2) : "Sin anticipo"}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
                        '${orden.saldoPendiente > 0 ? "\$" + orden.saldoPendiente.toStringAsFixed(2) : "Sin saldo pendiente"}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
    );
  }
}
