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