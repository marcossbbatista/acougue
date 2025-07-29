import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:acougue/src/models/controle_produto.dart';

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
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              produto.nomeProduto,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(),
            _infoRow('Loja:', produto.nomeLoja),
            _infoRow('Recipiente:', produto.nomeRecipiente),
            _infoRow('Lote:', produto.lote),
            _infoRow('Prateleira:', produto.prateleira),
            _infoRow('Quantidade:', produto.quantidadeProduto.toString()),
            _infoRow('Moída:', produto.moida ? 'Sim' : 'Não'),
            _infoRow(
              'Entrada:',
              DateFormat('dd/MM/yyyy').format(produto.dataEntrada),
            ),
            _infoRow(
              'Vencimento:',
              DateFormat('dd/MM/yyyy').format(produto.dataVencimento),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.green),
                  tooltip: 'Editar',
                  onPressed: onEdit,
                ),
                Chip(
                  label: Text(
                    _diasRestantes(produto.dataVencimento) <= 10
                        ? 'VENCE EM ${_diasRestantes(produto.dataVencimento)} DIAS'
                        : 'VÁLIDO ATÉ ${DateFormat('dd/MM/yyyy').format(produto.dataVencimento)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: _diasRestantes(produto.dataVencimento) <= 10
                      ? Colors.red
                      : Colors.green,
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  tooltip: 'Remover',
                  onPressed: onRemove,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Expanded(child: Text(value, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
