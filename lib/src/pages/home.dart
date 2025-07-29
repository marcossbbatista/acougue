import 'package:acougue/src/models/controle_produto.dart';
import 'package:acougue/src/widgets/card_info.dart';
import 'package:acougue/src/pages/registro.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  double _showUpButton = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    final percent = maxScroll == 0 ? 0 : currentScroll / maxScroll;

    setState(() {
      _showUpButton = percent > 0.005 ? min(1, (percent - 0.005) * 2) : 0.0;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
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
      body: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
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
                      content: Text(
                        'Tem certeza que deseja remover este produto?',
                      ),
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
          Positioned(
            right: 24,
            bottom: 32,
            child: AnimatedOpacity(
              opacity: _showUpButton,
              duration: Duration(milliseconds: 300),
              child: IgnorePointer(
                ignoring: _showUpButton == 0,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFF1976D2),
                  mini: true,
                  onPressed: _scrollToTop,
                  child: Icon(Icons.keyboard_arrow_up, color: Colors.white),
                  tooltip: 'Voltar ao topo',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
