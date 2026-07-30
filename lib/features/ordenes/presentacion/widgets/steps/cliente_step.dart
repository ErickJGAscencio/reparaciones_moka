import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:reparaciones_moka/core/entities/cliente.dart';
import 'package:reparaciones_moka/features/clientes/presentation/widgets/cliente_selector_bottom_sheet.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/orden_form_provider.dart';

class ClienteStep extends ConsumerWidget {
  const ClienteStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(ordenFormProvider).draft;
    final formato = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cliente',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 242, 248, 246),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Color(0xFF2F775A)),
                    ),
                    child: Text(
                      draft.cliente == null
                          ? "No hay cliente seleccionado"
                          : draft.cliente!.nombre,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F775A),
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  final cliente = await showModalBottomSheet<Cliente>(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    showDragHandle: true,
                    builder: (_) => const ClienteSelectorBottomSheet(),
                  );

                  if (cliente != null) {
                    ref.read(ordenFormProvider.notifier).updateCliente(cliente);
                  }
                },
                child: Text(
                  draft.cliente != null ? "Cambiar Cliente" : "Buscar Cliente",
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Si el cliente no existe, registrelo en el módulo Clientes.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            // const SizedBox(height: 20),
            // Text(
            //   'Fecha de Ingreso',
            //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
            //         fontWeight: FontWeight.bold,
            //       ),
            // ),
            // const SizedBox(height: 6),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(formato, style: Theme.of(context).textTheme.bodyLarge,),
            //     const Icon(Icons.calendar_month),
            //   ],
            // ),
            // const SizedBox(height: 6),
            //  Text(
            //   'La hora de registro es automatica, se toma la hora del sistema al crear la orden.',
            //   style: Theme.of(context).textTheme.bodySmall,
            // ),
          ],
        ),
      ),
    );
  }
}
