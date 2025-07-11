import 'package:acougue/src/models/controleProduto.dart';
import 'package:acougue/src/widgets/card_info.dart';
import 'package:acougue/src/pages/registro.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ControleProduto> produto = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BitBoi')),
      body: produto.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Text('Nenhum dado cadastrado')),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Produtos são listados por ordem de validade.'
                    ' Datas em vermelho indicam vencimento em até 10 dias.',
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: produto.length,
                      itemBuilder: (context, index) {
                        return CardInfo(
                          produto: produto[index],
                          onEdit: () async {
                            final produtoEditado = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    Registro(produto: produto[index]),
                              ),
                            );

                            if (produtoEditado != null) {
                              setState(() {
                                produto[index] = produtoEditado;
                              });
                            }
                          },
                          onRemove: () {
                            setState(() {
                              produto.removeAt(index);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () async {
          final novoCadastro = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Registro()),
          );
          if (novoCadastro != null) {
            setState(() {
              produto.add(novoCadastro);
              produto.sort(
                (a, b) => a.dataVencimento.compareTo(b.dataVencimento),
              );
            });
          }
        },
        child: Icon(Icons.add),
        tooltip: 'Adicionar Produto',
      ),
    );
  }
}
