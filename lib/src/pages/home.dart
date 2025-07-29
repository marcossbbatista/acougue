import 'package:acougue/src/models/controle_produto.dart';
import 'package:acougue/src/widgets/card_info.dart';
import 'package:acougue/src/pages/registro.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA), // cinza bem claro
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2), // azul moderno
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.store, color: Colors.white, size: 32),
            SizedBox(width: 12),
            Text(
              'BitBoi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Color(0xFF1976D2),
                  semanticLabel: 'Adicionar Produto',
                ),
                onPressed: () async {
                  final novoCadastro = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registro()),
                  );
                  if (novoCadastro != null) {
                    setState(() {
                      listaControleProduto.add(novoCadastro);
                      listaControleProduto.sort(
                        (a, b) => a.dataVencimento.compareTo(b.dataVencimento),
                      );
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: listaControleProduto.length,
        itemBuilder: (context, index) {
          return CardInfo(
            produto: listaControleProduto[index],
            onEdit: () async {
              final produtoEditado = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      Registro(produto: listaControleProduto[index]),
                ),
              );

              if (produtoEditado != null) {
                setState(() {
                  listaControleProduto[index] = produtoEditado;
                });
              }
            },
            onRemove: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Remover produto'),
                  content: Text('Tem certeza que deseja remover este produto?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text('Remover'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                setState(() {
                  listaControleProduto.removeAt(index);
                });
              }
            },
          );
        },
      ),
    );
  }
}
