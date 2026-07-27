import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/orden_form_provider.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/widgets/orden_stepper.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/widgets/steps/cliente_step.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/widgets/steps/detalles_step.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/widgets/steps/equipo_step.dart';

class OrdenFormBottomSheet extends ConsumerWidget {
  const OrdenFormBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ordenFormProvider);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Nueva Orden",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              OrdenStepper(currentStep: state.currentStep),

              const SizedBox(height: 30),

              // Contenido
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: _buildStep(state.currentStep),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  if (state.currentStep > 0)
                    OutlinedButton(
                      onPressed: () {
                        ref.read(ordenFormProvider.notifier).previousStep();
                      },
                      child: const Text("Anterior"),
                    ),

                  const Spacer(),

                  ElevatedButton(
                    onPressed: () {
                      if (state.currentStep < 2) {
                        ref.read(ordenFormProvider.notifier).nextStep();
                      }
                    },
                    child: Text(
                      state.currentStep == 2 ? "Guardar" : "Siguiente",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int step) {
    switch (step) {
      case 0:
        return const ClienteStep();

      case 1:
        return const EquipoStep();

      case 2:
        return const DetallesStep();

      default:
        return const SizedBox.shrink();
    }
  }
}
