import 'package:flutter/material.dart';

class OrdenStepper extends StatelessWidget {
  final int currentStep;
  const OrdenStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _StepItem(
            title: "Cliente",
            number: 1,
            isActive: currentStep == 0,
            isCompleted: currentStep > 0,
            showLine: true,
          ),
        ),
        Expanded(
          child: _StepItem(
            title: "Equipo",
            number: 2,
            isActive: currentStep == 1,
            isCompleted: currentStep > 1,
            showLine: true,
          ),
        ),
        Expanded(
          child: _StepItem(
            title: "Detalles",
            number: 3,
            isActive: currentStep == 2,
            isCompleted: false,
            showLine: false,
          ),
        ),
      ],
    );
  }
}

class _StepItem extends StatelessWidget {
  final int number;
  final String title;
  final bool isActive;
  final bool isCompleted;
  final bool showLine;

  const _StepItem({
    required this.number,
    required this.title,
    required this.isActive,
    required this.isCompleted,
    required this.showLine,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCompleted || isActive
        ? Theme.of(context).colorScheme.primary
        : Colors.grey;

    return Row(
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: color,
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : Text(
                      "$number",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        if (showLine)
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 2,
              color: isCompleted
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey.shade300,
            ),
          ),
      ],
    );
  }
}
