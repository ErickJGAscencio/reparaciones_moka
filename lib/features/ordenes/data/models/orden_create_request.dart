import 'package:reparaciones_moka/features/ordenes/domain/entities/order_draft.dart';

class OrdenCreateRequest {
  final int clienteId;
  final int tipoEquipoId;
  final int estadoEquipoId;
  final int tecnicoId;

  final String marca;
  final String modelo;
  final String serie;
  final String accesorios;
  final String fallaReporte;

  final double costo;
  final double anticipo;

  const OrdenCreateRequest({
    required this.clienteId,
    required this.tipoEquipoId,
    required this.estadoEquipoId,
    required this.tecnicoId,
    required this.marca,
    required this.modelo,
    required this.serie,
    required this.accesorios,
    required this.fallaReporte,
    required this.costo,
    required this.anticipo,
  });

  factory OrdenCreateRequest.fromDraft(OrdenDraft draft) {
    return OrdenCreateRequest(
      clienteId: draft.cliente?.id ?? 0,
      tipoEquipoId: draft.tipoEquipo?.id ?? 0,
      estadoEquipoId: draft.estadoEquipo?.id ?? 0,
      tecnicoId: draft.tecnicoAsignado?.id ?? 0,
      marca: draft.marca,
      modelo: draft.modelo,
      serie: draft.serie,
      accesorios: draft.accesorios.join(', '),
      fallaReporte: draft.fallaReporte,
      costo: draft.costo,
      anticipo: draft.anticipo,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cliente_id': clienteId,
      'tipo_equipo_id': tipoEquipoId,
      'estado_equipo_id': estadoEquipoId,
      'marca': marca,
      'modelo': modelo,
      'serie': serie,
      'accesorios': accesorios,
      'falla_reporte': fallaReporte,
      'costo': costo,
      'anticipo': anticipo,
    };
  }
}
