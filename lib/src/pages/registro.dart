import 'package:acougue/src/models/controleProduto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Registro extends StatefulWidget {
  final ControleProduto? produto;
  const Registro({super.key, this.produto});

  @override
  State<Registro> createState() => _Registro();
}

class _Registro extends State<Registro> {
  late TextEditingController _dataEntradaController;
  late TextEditingController _dataVencimentoController;
  late TextEditingController nomeLojaController;
  late TextEditingController nomeRecipienteController;
  late TextEditingController nomeProdutoController;
  late TextEditingController quantidadeController;
  String nomeLoja = '';
  String nomeRecipiente = '';
  String nomeProduto = '';
  double quantidadeProduto = 0;
  bool moida = false;
  DateTime dataEntrada = DateTime.now();
  DateTime dataVencimento = DateTime.now();

  final dataFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    final p = widget.produto;

    nomeLojaController = TextEditingController(text: p?.nomeLoja ?? '');
    nomeRecipienteController = TextEditingController(
      text: p?.nomeRecipiente ?? '',
    );
    nomeProdutoController = TextEditingController(text: p?.nomeProduto ?? '');
    quantidadeController = TextEditingController(
      text: p?.quantidadeProduto.toString() ?? '',
    );

    dataEntrada = p?.dataEntrada ?? DateTime.now();
    dataVencimento = p?.dataVencimento ?? DateTime.now();

    _dataEntradaController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(dataEntrada),
    );
    _dataVencimentoController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(dataVencimento),
    );

    moida = p?.moida ?? false;
  }

  @override
  void dispose() {
    nomeLojaController.dispose();
    nomeRecipienteController.dispose();
    nomeProdutoController.dispose();
    quantidadeController.dispose();
    _dataEntradaController.dispose();
    _dataVencimentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Controle de Produto')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            TextField(
              controller: nomeLojaController,
              decoration: InputDecoration(labelText: 'Loja'),
              onChanged: (value) => nomeLoja = value,
            ),
            TextField(
              controller: nomeRecipienteController,
              decoration: InputDecoration(
                labelText: 'Nome do Recipiente (Geladeira/Freezer)',
              ),
              onChanged: (value) => nomeRecipiente = value,
            ),
            TextField(
              controller: nomeProdutoController,
              decoration: InputDecoration(labelText: 'Produto'),
              onChanged: (value) => nomeProduto = value,
            ),
            TextField(
              controller: quantidadeController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Quantidade Produto (KG/gm)',
              ),
            ),

            CheckboxListTile(
              title: Text('Moída?'),
              value: moida,
              onChanged: (value) {
                setState(() {
                  moida = value ?? false;
                });
              },
            ),
            TextField(
              readOnly: true,
              controller: _dataEntradaController,
              decoration: InputDecoration(
                labelText: 'Data de Entrada',
                hintText: DateFormat('dd/MM/yyyy').format(dataEntrada),
              ),
              onTap: () async {
                final novaData = await showDatePicker(
                  context: context,
                  initialDate: dataEntrada,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (novaData != null) {
                  setState(() {
                    dataEntrada = novaData;
                    _dataEntradaController.text = DateFormat(
                      'dd/MM/yyyy',
                    ).format(novaData);
                  });
                }
              },
            ),

            TextField(
              readOnly: true,
              controller: _dataVencimentoController,
              decoration: InputDecoration(
                labelText: 'Data de Vencimento',
                hintText: DateFormat('dd/MM/yyyy').format(dataVencimento),
              ),
              onTap: () async {
                final novaData = await showDatePicker(
                  context: context,
                  initialDate: dataVencimento,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (novaData != null) {
                  setState(() {
                    dataVencimento = novaData;
                    _dataVencimentoController.text = DateFormat(
                      'dd/MM/yyyy',
                    ).format(novaData);
                  });
                }
              },
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                final novoProduto = ControleProduto(
                  nomeLoja: nomeLojaController.text,
                  nomeRecipiente: nomeRecipienteController.text,
                  nomeProduto: nomeProdutoController.text,
                  quantidadeProduto:
                      double.tryParse(
                        quantidadeController.text.replaceAll(',', '.'),
                      ) ??
                      0.0,
                  moida: moida,
                  dataEntrada: dataEntrada,
                  dataVencimento: dataVencimento,
                );

                Navigator.pop(context, novoProduto);
              },
              child: Text('Salvar'),
              style: ElevatedButton.styleFrom(
                side: BorderSide(style: BorderStyle.solid),
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
