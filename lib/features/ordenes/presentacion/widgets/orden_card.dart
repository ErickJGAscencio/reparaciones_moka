import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdenCard extends StatelessWidget {
  final Map<String, dynamic> orden;

  const OrdenCard({super.key, required this.orden});

  String _formatoFecha(String date) {
    final DateTime dateTime = DateTime.parse(date);
    return DateFormat("d MMM  yyyy", 'es_ES').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final folio = orden["orden_id"]?.toString() ?? "";
    final clienteNombre = orden["cliente"]?["nombre"] ?? "Sin nombre";
    final equipoInfo = orden['modelo'] ?? "";
    final fecha = orden['fecha_ingreso'] ?? "";
    final saldo = orden['saldo_a_pagar'] ?? 0;
    final estadoReparacion =
        orden['estado_reparacion']?['nombre'] ?? "Desconocido";

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.phone_android),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(folio, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(estadoReparacion, style: const TextStyle(color: Colors.blue)),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              clienteNombre,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              '$equipoInfo - ${_formatoFecha(fecha)}',
              style: TextStyle(color: Colors.blueGrey),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  const TextSpan(text: 'Saldo: '),
                  TextSpan(
                    text: saldo.toString(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
