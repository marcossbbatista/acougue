import 'package:acougue/src/models/controle_produto.dart';
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
  late TextEditingController loteController;
  late TextEditingController prateleiraController;

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
      text: p?.quantidadeProduto != null && p!.quantidadeProduto != 0.0
          ? p.quantidadeProduto.toString()
          : '',
    );
    loteController = TextEditingController(text: p?.lote ?? '');
    prateleiraController = TextEditingController(text: p?.prateleira ?? '');

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
    loteController.dispose();
    prateleiraController.dispose();
    super.dispose();
  }

  void _salvarProduto() {
    if (nomeLojaController.text.isEmpty ||
        nomeRecipienteController.text.isEmpty ||
        nomeProdutoController.text.isEmpty ||
        quantidadeController.text.isEmpty ||
        loteController.text.isEmpty ||
        prateleiraController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preencha todos os campos obrigatórios!'),
          backgroundColor: Colors.red[400],
        ),
      );
      return;
    }

    final novoProduto = ControleProduto(
      nomeLoja: nomeLojaController.text,
      nomeRecipiente: nomeRecipienteController.text,
      nomeProduto: nomeProdutoController.text,
      quantidadeProduto:
          double.tryParse(quantidadeController.text.replaceAll(',', '.')) ??
          0.0,
      moida: moida,
      dataEntrada: dataEntrada,
      dataVencimento: dataVencimento,
      lote: loteController.text,
      prateleira: prateleiraController.text,
    );

    Navigator.pop(context, novoProduto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        title: Text(
          'Controle de Produto',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(controller: nomeLojaController, label: 'Loja *'),
            SizedBox(height: 12),
            _buildTextField(
              controller: nomeRecipienteController,
              label: 'Recipiente (Geladeira/Freezer) *',
            ),
            SizedBox(height: 12),
            _buildTextField(
              controller: nomeProdutoController,
              label: 'Produto *',
            ),
            SizedBox(height: 12),
            _buildTextField(
              controller: quantidadeController,
              label: 'Quantidade Produto (KG/gm) *',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 12),
            _buildTextField(controller: loteController, label: 'Lote *'),
            SizedBox(height: 12),
            _buildTextField(
              controller: prateleiraController,
              label: 'Prateleira *',
            ),
            SizedBox(height: 12),
            CheckboxListTile(
              title: Text(
                'Moída?',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              value: moida,
              activeColor: Color(0xFF1976D2),
              onChanged: (value) {
                setState(() {
                  moida = value ?? false;
                });
              },
            ),
            SizedBox(height: 12),
            _buildDateField(
              context: context,
              controller: _dataEntradaController,
              label: 'Data de Entrada',
              selectedDate: dataEntrada,
              onDateSelected: (novaData) {
                setState(() {
                  dataEntrada = novaData;
                  _dataEntradaController.text = DateFormat(
                    'dd/MM/yyyy',
                  ).format(novaData);
                });
              },
            ),
            SizedBox(height: 12),
            _buildDateField(
              context: context,
              controller: _dataVencimentoController,
              label: 'Data de Vencimento',
              selectedDate: dataVencimento,
              onDateSelected: (novaData) {
                setState(() {
                  dataVencimento = novaData;
                  _dataVencimentoController.text = DateFormat(
                    'dd/MM/yyyy',
                  ).format(novaData);
                });
              },
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(Icons.save),
              label: Text('Salvar'),
              onPressed: _salvarProduto,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF1976D2), width: 2),
        ),
      ),
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildDateField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required DateTime selectedDate,
    required ValueChanged<DateTime> onDateSelected,
  }) {
    return TextField(
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: Icon(Icons.calendar_today, color: Color(0xFF1976D2)),
      ),
      onTap: () async {
        final novaData = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (novaData != null) {
          onDateSelected(novaData);
        }
      },
    );
  }
}
