class ControleProduto {
  String nomeLoja;
  String nomeRecipiente;
  String prateleira;
  String nomeProduto;
  double quantidadeProduto;
  String lote;
  bool moida;
  DateTime dataEntrada;
  DateTime dataVencimento;

  ControleProduto({
    required this.lote,
    required this.prateleira,
    required this.nomeLoja,
    required this.nomeRecipiente,
    required this.nomeProduto,
    required this.quantidadeProduto,
    required this.moida,
    required this.dataEntrada,
    required this.dataVencimento,
  });
}

final List<ControleProduto> listaControleProduto = [
  ControleProduto(
    nomeLoja: 'Açougue Central',
    nomeRecipiente: 'Balde 1',
    nomeProduto: 'Carne Bovina',
    quantidadeProduto: 12.0,
    moida: false,
    dataEntrada: DateTime(2025, 7, 20),
    dataVencimento: DateTime(2025, 7, 30),
    lote: 'ABC123',
    prateleira: 'Prateleira 1',
  ),
  ControleProduto(
    nomeLoja: 'Açougue do Bairro',
    nomeRecipiente: 'Caixa 2',
    nomeProduto: 'Carne Moída',
    quantidadeProduto: 8.5,
    moida: true,
    dataEntrada: DateTime(2025, 7, 22),
    dataVencimento: DateTime(2025, 11, 1),
    lote: 'JHS23',
    prateleira: 'Gaveta 2',
  ),
  ControleProduto(
    nomeLoja: 'Açougue Central',
    nomeRecipiente: 'Balde 3',
    nomeProduto: 'Frango',
    quantidadeProduto: 20.0,
    moida: false,
    dataEntrada: DateTime(2025, 7, 23),
    dataVencimento: DateTime(2025, 8, 2),
    lote: 'VHUIER',
    prateleira: 'Prateleira 3',
  ),
  ControleProduto(
    nomeLoja: 'Açougue do Bairro',
    nomeRecipiente: 'Caixa 4',
    nomeProduto: 'Linguiça',
    quantidadeProduto: 15.0,
    moida: false,
    dataEntrada: DateTime(2025, 7, 24),
    dataVencimento: DateTime(2025, 10, 3),
    lote: '15864488',
    prateleira: 'Prateleira 4',
  ),
  ControleProduto(
    nomeLoja: 'Açougue Central',
    nomeRecipiente: 'Balde 5',
    nomeProduto: 'Costela',
    quantidadeProduto: 10.0,
    moida: false,
    dataEntrada: DateTime(2025, 7, 25),
    dataVencimento: DateTime(2025, 12, 4),
    lote: 'UUUEBE',
    prateleira: 'Gaveta 5',
  ),
];
