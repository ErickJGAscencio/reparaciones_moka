import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/core/entities/cliente.dart';
import 'package:reparaciones_moka/core/entities/estado_equipo.dart';
import 'package:reparaciones_moka/core/entities/estado_reparacion.dart';
import 'package:reparaciones_moka/core/entities/tipo_equipo.dart';
import 'package:reparaciones_moka/features/ordenes/domain/entities/order_draft.dart';

class OrdenFormState {
  final int currentStep;
  final OrdenDraft draft;
  final bool isSaving;
  final String? error;

  const OrdenFormState({
    this.currentStep = 0,
    this.draft = const OrdenDraft(),
    this.isSaving = false,
    this.error,
  });

  OrdenFormState copyWith({
    int? currentStep,
    OrdenDraft? draft,
    bool? isSaving,
    String? error,
  }) {
    return OrdenFormState(
      currentStep: currentStep ?? this.currentStep,
      draft: draft ?? this.draft,
      isSaving: isSaving ?? this.isSaving,
      error: error,
    );
  }
}

class OrdenFormNotifier extends Notifier<OrdenFormState> {
  @override
  OrdenFormState build() {
    return const OrdenFormState();
  }

  void nextStep() {
    if (state.currentStep < 2) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void reset() {
    state = const OrdenFormState();
  }

  void updateCliente({Cliente? cliente}) {
    state = state.copyWith(draft: state.draft.copyWith(cliente: cliente));
  }

  void updateEquipo({
    TipoEquipo? tipoEquipo,
    EstadoEquipo? estadoEquipo,
    String? modelo,
    String? serie,
    String? accesorios,
  }) {
    state = state.copyWith(
      draft: state.draft.copyWith(
        tipoEquipo: tipoEquipo,
        estadoEquipo: estadoEquipo,
        modelo: modelo,
        serie: serie,
        accesorios: accesorios,
      ),
    );
  }

  void updateDetalles({
    EstadoReparacion? estadoReparacion,
    String? fallaReporte,
    String? diagnostico,
    double? costo,
    double? anticipo,
  }) {
    state = state.copyWith(
      draft: state.draft.copyWith(
        estadoReparacion: estadoReparacion,
        fallaReporte: fallaReporte,
        diagnostico: diagnostico,
        costo: costo,
        anticipo: anticipo,
      ),
    );
  }

  bool canContinue() {
    switch (state.currentStep) {
      case 0:
        return state.draft.cliente != null;

      case 1:
        return state.draft.tipoEquipo != null &&
            state.draft.estadoEquipo != null &&
            state.draft.modelo.trim().isNotEmpty;

      case 2:
        return state.draft.estadoReparacion != null &&
            state.draft.fallaReporte.trim().isNotEmpty;

      default:
        return false;
    }
  }

  bool goToNextStep() {
    if (!canContinue()) {
      return false;
    }

    nextStep();
    return true;
  }
}

final ordenFormProvider = NotifierProvider<OrdenFormNotifier, OrdenFormState>(
  OrdenFormNotifier.new,
);
