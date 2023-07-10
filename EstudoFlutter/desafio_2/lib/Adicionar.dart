import 'package:desafio_2/service/textLabel.dart';
import 'package:flutter/material.dart';

class Adicionar extends StatelessWidget {
  const Adicionar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const AdicionarPage(title: 'Adicionar Pessoa'),
    );
  }
}

class AdicionarPage extends StatefulWidget {
  const AdicionarPage({super.key, required this.title});

  final String title;

  @override
  State<AdicionarPage> createState() => _AdicionarPageState();
}

class _AdicionarPageState extends State<AdicionarPage> {
  var nomeController = TextEditingController(text: "");
  var dataController = TextEditingController(text: "");
  double peso = 0;
  double altura = 0;
  bool salvo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(widget.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold))),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: salvo
                ? const Center(child: CircularProgressIndicator())
                : ListView(children: [
                    const Icon(Icons.person,
                        size: 100, color: Color.fromARGB(255, 148, 24, 16)),
                    const TextLabel(texto: "Nome"),
                    TextField(controller: nomeController),
                    TextLabel(texto: "Peso: ${peso.toStringAsFixed(2)} kg"),
                    Slider(
                        min: 0,
                        max: 200,
                        value: peso,
                        onChanged: (double value) {
                          setState(() {
                            peso = value;
                          });
                        }),
                    TextLabel(texto: "Altura: ${altura.round().toString()} cm"),
                    Slider(
                        min: 0,
                        max: 250,
                        value: altura,
                        onChanged: (double value) {
                          setState(() {
                            altura = value;
                          });
                        }),
                    const TextLabel(texto: "Data de Nascimento (Opcional)"),
                    TextField(
                        controller: dataController,
                        readOnly: true,
                        onTap: () async {
                          var data = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1923, 1, 1),
                              lastDate: DateTime.now());
                          if (data != null) {
                            dataController.text = data.toString();
                          }
                        }),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          salvo = false;
                        });
                        if (nomeController.text.trim().length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("O nome deve ser preenchido")));
                          return;
                        }

                        if (peso == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("O peso deve ser preenchido")));
                          return;
                        }

                        if (altura == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("A altura deve ser preenchida")));
                          return;
                        }

                        setState(() {
                          salvo = true;
                        });
                        Future.delayed(const Duration(seconds: 3), () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Indivíduo adicionado com sucesso")));
                          setState(() {
                            salvo = false;
                          });
                          Navigator.pop(context);
                        });
                      },
                      child: const Text("Adicionar"),
                    ),
                  ])));
  }
}
