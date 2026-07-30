import 'package:reparaciones_moka/core/entities/cliente.dart';
import 'package:reparaciones_moka/core/entities/estado_equipo.dart';
import 'package:reparaciones_moka/core/entities/estado_reparacion.dart';
import 'package:reparaciones_moka/core/entities/tipo_equipo.dart';
import 'package:reparaciones_moka/features/tecnicos/data/models/user_model.dart';

class OrdenDraft {
  final Cliente? cliente;
  final TipoEquipo? tipoEquipo;
  final EstadoEquipo? estadoEquipo;
  final EstadoReparacion? estadoReparacion;
  final UserModel? tecnicoAsignado;

  final String marca;
  final String modelo;
  final String serie;
  final List<String> accesorios;
  final String fallaReporte;
  final String diagnostico;

  final double costo;
  final double anticipo;

  const OrdenDraft({
    this.cliente,
    this.tipoEquipo,
    this.estadoEquipo,
    this.estadoReparacion,
    this.tecnicoAsignado,
    this.marca = '',
    this.modelo = '',
    this.serie = '',
    this.accesorios = const [],
    this.fallaReporte = '',
    this.diagnostico = '',
    this.costo = 0,
    this.anticipo = 0,
  });

  double get saldo => costo - anticipo;

  OrdenDraft copyWith({
    Cliente? cliente,
    TipoEquipo? tipoEquipo,
    EstadoEquipo? estadoEquipo,
    EstadoReparacion? estadoReparacion,
    UserModel? tecnicoAsignado,
    String? marca,
    String? modelo,
    String? serie,
    List<String>? accesorios,
    String? fallaReporte,
    String? diagnostico,
    double? costo,
    double? anticipo,
  }) {
    return OrdenDraft(
      cliente: cliente ?? this.cliente,
      tipoEquipo: tipoEquipo ?? this.tipoEquipo,
      estadoEquipo: estadoEquipo ?? this.estadoEquipo,
      estadoReparacion: estadoReparacion ?? this.estadoReparacion,
      tecnicoAsignado: tecnicoAsignado ?? this.tecnicoAsignado,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      serie: serie ?? this.serie,
      accesorios: accesorios ?? this.accesorios,
      fallaReporte: fallaReporte ?? this.fallaReporte,
      diagnostico: diagnostico ?? this.diagnostico,
      costo: costo ?? this.costo,
      anticipo: anticipo ?? this.anticipo,
    );
  }
}