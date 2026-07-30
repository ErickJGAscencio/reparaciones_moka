import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/ordenes/domain/entities/orden.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/orden_dependencies.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/orden_form_provider.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/ordenes_provider.dart';
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
          top: 0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Nueva Orden",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      ref.watch(ordenFormProvider.notifier).reset();
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.clear),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              OrdenStepper(currentStep: state.currentStep),

              // Contenido
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child:  _buildStep(state.currentStep),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Positioned(
                bottom: 0,
                child: Row(
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F775A),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      if (state.currentStep < 2) {
                        ref.read(ordenFormProvider.notifier).goToNextStep();
                      }else if(ref.read(ordenFormProvider.notifier).goToNextStep()){
                        //Crreamos la orden
                        print("JJKLL");
                        final orden = ref.read(ordenFormProvider).draft as Orden;
                        //await ref.read(ordenesProvider.notifier).createOrder(orden);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      state.currentStep == 2 ? "Crear órden" : "Siguiente",
                    ),
                  ),
                ],
              ))
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
