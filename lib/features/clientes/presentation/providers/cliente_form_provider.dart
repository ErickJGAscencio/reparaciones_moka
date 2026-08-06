import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/clientes/domain/entities/cliente_draft.dart';

class ClienteFormState{
  final ClienteDraft draft;
  final bool isSaving;
  final String? error;

  const ClienteFormState({
    this.draft = const ClienteDraft(),
    this.isSaving = false,
    this.error,
  });

  ClienteFormState copyWith({
    ClienteDraft? draft,
    bool? isSaving,
    String? error,
  }){
    return ClienteFormState(
      draft: draft ?? this.draft,
      isSaving: isSaving ?? this.isSaving,
      error: error
    );
  }
}

class ClienteFormNotifier extends Notifier<ClienteFormState>{
  @override
  ClienteFormState build(){
    return const ClienteFormState();
  }

  void updateCliente({
    String? nombre,
    String? telefono,
    String? correo,
    String? direccion, 
    String? notas
  }){
    state = state.copyWith(
      draft: state.draft.copyWith(
        nombre: nombre,
        telefono: telefono,
        correo: correo,
        direccion: direccion,
        notas: notas
      )
    );
  }
}

final clienteFormProvider = NotifierProvider<ClienteFormNotifier, ClienteFormState>(
  ClienteFormNotifier.new
);