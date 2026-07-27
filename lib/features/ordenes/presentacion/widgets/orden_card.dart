import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reparaciones_moka/core/entities/cliente.dart';
import 'package:reparaciones_moka/core/entities/estado_reparacion.dart';
import 'package:reparaciones_moka/core/entities/tipo_equipo.dart';
import 'package:reparaciones_moka/features/ordenes/domain/entities/orden.dart';

class OrdenCard extends StatelessWidget {
  final Orden orden;

  const OrdenCard({super.key, required this.orden});

  String _formatoFecha(DateTime date) {
    return DateFormat("d MMM  yyyy", 'es_ES').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final folio = orden.id.toString();
    final fecha = orden.fechaIngreso;
    final saldo = orden.saldoPendiente;
    Cliente cliente = orden.cliente;
    TipoEquipo equipoInfo = orden.tipoEquipo;
    EstadoReparacion estadoReparacion = orden.estadoReparacion;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.phone_android),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(folio, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(estadoReparacion.nombre, style: const TextStyle(color: Colors.blue)),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              cliente.nombre,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              '${equipoInfo.nombre} - ${_formatoFecha(fecha)}',
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
