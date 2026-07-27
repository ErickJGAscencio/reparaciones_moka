import 'package:reparaciones_moka/core/entities/cliente.dart';
import 'package:reparaciones_moka/core/entities/estado_equipo.dart';
import 'package:reparaciones_moka/core/entities/estado_reparacion.dart';
import 'package:reparaciones_moka/core/entities/tipo_equipo.dart';

class Orden {
  final int id;
  final String modelo;
  final String serie;
  final String fallaReporte;

  final double costo;
  final double anticipo;
  final double saldoPendiente;

  final String accesorios;
  final DateTime fechaIngreso;
  final String diagnostico;

  final Cliente cliente;
  final TipoEquipo tipoEquipo;
  final EstadoEquipo estadoEquipo;
  final EstadoReparacion estadoReparacion;

  const Orden({
    required this.id,
    required this.modelo,
    required this.serie,
    required this.fallaReporte,
    required this.costo,
    required this.anticipo,
    required this.saldoPendiente,
    required this.accesorios,
    required this.fechaIngreso,
    required this.diagnostico,
    required this.cliente,
    required this.tipoEquipo,
    required this.estadoEquipo,
    required this.estadoReparacion,
  });
}
