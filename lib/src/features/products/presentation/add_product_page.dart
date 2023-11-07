import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController description = TextEditingController();
  TextEditingController barCode = TextEditingController();
  TextEditingController validate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 100,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              TextField(
                decoration: const InputDecoration(
                  label: Text('Descrição'),
                ),
                controller: description,
              ),
              TextField(
                decoration: const InputDecoration(
                  label: Text('Codigo de Barras'),
                ),
                controller: barCode,
              ),
              TextField(
                decoration: const InputDecoration(
                  label: Text('Data de Validade'),
                ),
                controller: validate,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
