import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              draft.cliente == null
                  ? "No hay cliente seleccionado"
                  : draft.cliente!.nombre,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final cliente = await showModalBottomSheet(
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
              '¿No está registrado? Créalo en la pantalla de clientes.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
            Text(
              'Fecha de Ingreso',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formato, style: Theme.of(context).textTheme.bodyLarge,),
                const Icon(Icons.calendar_month),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
