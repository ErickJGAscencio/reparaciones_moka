
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/core/entities/tipo_equipo.dart';
import 'package:reparaciones_moka/core/providers/core_dependencies.dart';

class TiposEquipoState {
  final List<TipoEquipo> tiposEquipo;
  final bool isLoading;
  final String? error;

  const TiposEquipoState({
    this.tiposEquipo = const [],
    this.isLoading = false,
    this.error,
  });

  TiposEquipoState copyWith({
    List<TipoEquipo>? tiposEquipo,
    bool? isLoading,
    String? error
  }){
    return TiposEquipoState(
      tiposEquipo: tiposEquipo ?? this.tiposEquipo,
      isLoading: isLoading ?? this.isLoading,
      error: error
    );
  }
}

class TiposEquipoNotifier extends Notifier<TiposEquipoState>{
  @override
  TiposEquipoState build() {
    return const TiposEquipoState();
  }

  Future<void> loadTiposEquipo({bool forceRefresh = false}) async {
    if(state.isLoading) return;
    if(!forceRefresh && state.tiposEquipo.isNotEmpty) return;

    try{
      state = state.copyWith(isLoading: true, error: null);

      final tiposEquipo = await ref.read(getTiposEquipoUseCaseProvider).execute();

      state = state.copyWith(tiposEquipo: tiposEquipo, isLoading: false);
    }catch (e){
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final tiposEquipoProvider = NotifierProvider<TiposEquipoNotifier, TiposEquipoState>(
  TiposEquipoNotifier.new,
);