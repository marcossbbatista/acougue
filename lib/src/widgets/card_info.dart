import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:acougue/src/models/controleProduto.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({
    super.key,
    required this.produto,
    required this.onEdit,
    required this.onRemove,
  });

  final ControleProduto produto;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  int _diasRestantes(DateTime vencimento) {
    final hoje = DateTime.now();
    return vencimento.difference(hoje).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Card(
            elevation: 4,
            margin: EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Loja:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(produto.nomeLoja),
                  SizedBox(height: 4),
                  Text(
                    'Recipiente:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(produto.nomeRecipiente),
                  SizedBox(height: 4),
                  Text(
                    'Produto:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(produto.nomeProduto),
                  SizedBox(height: 4),
                  Text(
                    'Quantidade:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(produto.quantidadeProduto.toString()),
                  SizedBox(height: 4),
                  Text('Moida:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(produto.moida ? 'Sim' : 'Não'),
                  SizedBox(height: 4),
                  Text(
                    'Entrada:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(DateFormat('dd/MM/yyyy').format(produto.dataEntrada)),
                  SizedBox(height: 4),
                  Text(
                    'Vencimento:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(produto.dataVencimento),
                    style: TextStyle(
                      color: _diasRestantes(produto.dataVencimento) <= 10
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Icon(Icons.edit_square, color: Colors.green),
                        onTap: onEdit,
                      ),
                      GestureDetector(
                        child: Icon(Icons.remove_circle, color: Colors.red),
                        onTap: onRemove,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
