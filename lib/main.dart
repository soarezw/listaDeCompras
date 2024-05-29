import 'package:flutter/material.dart';

void main() {
  runApp(AppCrud());
}

class Produto {
  String nome;
  double preco;
  String categoria;

  Produto({required this.nome, required this.preco, required this.categoria});
}

class AppCrud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Produto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromARGB(255, 3, 184, 103),
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Adiciona a imagem do logo
            Image.asset(
              'images/logo.png',
              height: 244, // Ajuste conforme necessário
              width: 275, // Ajuste conforme necessário
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_usernameController.text == 'Vedilson' &&
                    _passwordController.text == 'trocar123') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductListPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Credenciais inválidas')),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Produto> products = [
    Produto(nome: 'Produto 1', preco: 10.0, categoria: 'Categoria A'),
    Produto(nome: 'Produto 2', preco: 20.0, categoria: 'Categoria B'),
    Produto(nome: 'Produto 3', preco: 30.0, categoria: 'Categoria C'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].nome),
            subtitle: Text(
                'Preço: ${products[index].preco.toString()} - Categoria: ${products[index].categoria}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  products.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Produto removido')),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Produto newProduct = await showDialog(
            context: context,
            builder: (context) {
              TextEditingController _nomeController = TextEditingController();
              TextEditingController _precoController = TextEditingController();
              TextEditingController _categoriaController =
                  TextEditingController();

              return AlertDialog(
                title: Text('Novo Produto'),
                content: Column(
                  children: [
                    TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                    TextField(
                      controller: _precoController,
                      decoration: InputDecoration(labelText: 'Preço'),
                    ),
                    TextField(
                      controller: _categoriaController,
                      decoration: InputDecoration(labelText: 'Categoria'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_nomeController.text.isNotEmpty &&
                          _precoController.text.isNotEmpty &&
                          _categoriaController.text.isNotEmpty) {
                        Navigator.pop(
                          context,
                          Produto(
                            nome: _nomeController.text.trim(),
                            preco: double.parse(_precoController.text.trim()),
                            categoria: _categoriaController.text.trim(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Preencha todos os campos corretamente')),
                        );
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );
          if (newProduct != null) {
            setState(() {
              products.add(newProduct);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
