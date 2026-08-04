import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reparaciones_moka/core/entities/cliente.dart';
import 'package:reparaciones_moka/core/entities/estado_reparacion.dart';
import 'package:reparaciones_moka/features/ordenes/domain/entities/orden.dart';
import 'package:go_router/go_router.dart';

class OrdenCard extends StatelessWidget {
  final Orden orden;

  const OrdenCard({super.key, required this.orden});

  String _formatoFecha(DateTime date) {
    return DateFormat("d MMM  yyyy", 'es_ES').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final folio = orden.id.toString();
    EstadoReparacion estadoReparacion = orden.estadoReparacion;
    Cliente cliente = orden.cliente;
    final fecha = orden.fechaIngreso;
    final marca = orden.marca;
    final modeloEquipo = orden.modelo;
    final saldo = orden.saldoPendiente;

    return InkWell(
      onTap: () {
        context.push('/orders/${orden.id}');
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 228, 234, 255),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(5),
            child: const Icon(Icons.phone_android),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                folio,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              _buildPil(estadoReparacion.nombre),
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
                '$marca $modeloEquipo - ${_formatoFecha(fecha)}',
                style: TextStyle(color: Colors.blueGrey),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    const TextSpan(text: 'Saldo pendiente: '),
                    TextSpan(
                      text: '\$${saldo.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPil(String label) {
    late Color colorPil = Colors.white;
    switch (label) {
      case "Pendiente":
        colorPil = const Color.fromARGB(255, 250, 235, 191);
        break;
      case "En reparación":
        colorPil = const Color.fromARGB(255, 199, 230, 255);
        break;
      case "Listo":
        colorPil = const Color.fromARGB(255, 192, 255, 192);
        break;
      case "Entregado":
        colorPil = const Color.fromARGB(255, 169, 169, 169);
        break;
      default:
        colorPil = Colors.white;
    }
    return Container(
      decoration: BoxDecoration(
        color: colorPil,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
