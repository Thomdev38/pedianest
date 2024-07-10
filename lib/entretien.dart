import "package:flutter/material.dart";


class EntretienPage extends StatelessWidget {
  final double? dosePropofolEntretien; // Recevoir la variable du parent
  
 
  const EntretienPage({super.key, 
  this.dosePropofolEntretien,
  
  });
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Entretien Page',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          
          
          if (dosePropofolEntretien != null)
      
            Text(
              'Dose d\'entretien de Propofol: ${dosePropofolEntretien!.toStringAsFixed(1)} mg/kg/h',
              style: const TextStyle(fontSize: 16),
            ),
          // Autres éléments à afficher...
        ],
      ),
    );
  }
}