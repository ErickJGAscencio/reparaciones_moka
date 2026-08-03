import 'package:reparaciones_moka/core/models/cliente_model.dart';
import 'package:reparaciones_moka/core/models/estado_equipo_model.dart';
import 'package:reparaciones_moka/core/models/estado_reparacion_model.dart';
import 'package:reparaciones_moka/core/models/tipo_equipo_model.dart';
import 'package:reparaciones_moka/features/ordenes/domain/entities/orden.dart';
import 'package:reparaciones_moka/features/tecnicos/data/models/user_model.dart';

class OrdenModel extends Orden {
  const OrdenModel({
    required super.id,
    required super.modelo,
    required super.serie,
    required super.fallaReporte,
    required super.marca,
    required super.costo,
    required super.anticipo,
    required super.saldoPendiente,
    required super.accesorios,
    required super.fechaIngreso,
    required super.diagnostico,
    required super.cliente,
    required super.tipoEquipo,
    required super.estadoEquipo,
    required super.estadoReparacion,
    required super.tecnico,
  });

  factory OrdenModel.fromJson(Map<String, dynamic> json) {
    return OrdenModel(
      id: json['orden_id'],
      modelo: json['modelo'] ?? '',
      serie: json['serie'] ?? '',
      fallaReporte: json['falla_reporte'] ?? '',
      marca: json['marca'] ?? '',
      costo: (json['costo'] as num).toDouble(),
      anticipo: (json['anticipo'] as num).toDouble(),
      saldoPendiente: (json['saldo_a_pagar'] as num).toDouble(),
      accesorios: json['accesorios'] ?? '',
      fechaIngreso: DateTime.parse(json['fecha_ingreso']),
      diagnostico: json['diagnostico'] ?? '',

      cliente: ClienteModel.fromJson(json["cliente"]),
      tipoEquipo: TipoEquipoModel.fromJson(json['tipo_equipo']),
      estadoEquipo: EstadoEquipoModel.fromJson(json['estado_equipo']),
      estadoReparacion: EstadoReparacionModel.fromJson(json['estado_reparacion']),
      tecnico: UserModel.fromJson(json['user'])
    );
  }
}