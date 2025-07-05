class ControleProduto {
  String nomeLoja;
  String nomeRecipiente;
  String nomeProduto;
  double quantidadeProduto;
  bool moida;
  DateTime dataEntrada;
  DateTime dataVencimento;

  ControleProduto({
    required this.nomeLoja,
    required this.nomeRecipiente,
    required this.nomeProduto,
    required this.quantidadeProduto,
    required this.moida,
    required this.dataEntrada,
    required this.dataVencimento,
  });
}
