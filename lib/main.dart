import 'package:flutter/material.dart';

void main() {
  runApp(RansonCriteriaApp());
}

class RansonCriteriaApp extends StatefulWidget {
  @override
  _RansonCriteriaAppState createState() => _RansonCriteriaAppState();
}

class _RansonCriteriaAppState extends State<RansonCriteriaApp> {
  String _nome = "";
  int _idade = 0;
  int _leucocitos = 0;
  double _glicose = 0.0;
  double _ast = 0.0;
  double _ldh = 0.0;
  bool? _litiaseBiliar = false;
  int _pontuacao = 0;
  double _mortalidade = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Novo Paciente"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                onChanged: (text) {
                  _nome = text;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Idade"),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  _idade = int.tryParse(text) ?? 0;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Leucócitos"),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  _leucocitos = int.tryParse(text) ?? 0;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Glicose"),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  _glicose = double.tryParse(text) ?? 0.0;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "AST"),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  _ast = double.tryParse(text) ?? 0.0;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "LDH"),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  _ldh = double.tryParse(text) ?? 0.0;
                },
              ),
              CheckboxListTile(
                title: Text("Litíase biliar"),
                value: _litiaseBiliar ?? false,
                onChanged: (value) {
                  setState(() {
                    _litiaseBiliar = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                "Pontuação: ${_pontuacao}",
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                "Mortalidade: ${_mortalidade}%",
                style: TextStyle(fontSize: 20.0),
              ),
              ElevatedButton(
                onPressed: () {
                  calcularPontuacao();
                },
                child: Text("Adicionar Paciente"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calcularPontuacao() {
    _pontuacao = 0;

    try {
      if (_litiaseBiliar ?? false) {
        if (_idade >= 70) {
          _pontuacao += 1;
        }
        if (_leucocitos >= 18000) {
          _pontuacao += 1;
        }
        if (_glicose >= 12.2) {
          _pontuacao += 1;
        }
        if (_ast >= 250) {
          _pontuacao += 1;
        }
        if (_ldh >= 400) {
          _pontuacao += 1;
        }
      } else {
        if (_idade >= 55) {
          _pontuacao += 1;
        }
        if (_leucocitos >= 16000) {
          _pontuacao += 1;
        }
        if (_glicose >= 11) {
          _pontuacao += 1;
        }
        if (_ast >= 250) {
          _pontuacao += 1;
        }
        if (_ldh >= 350) {
          _pontuacao += 1;
        }
      }
    } catch (e) {
      print("Erro ao calcular pontuação: $e");
    }

    setState(() {
      _mortalidade = calcularMortalidade(_pontuacao);
    });
  }

  double calcularMortalidade(int pontuacao) {
    switch (pontuacao) {
      case 0:
      case 1:
        return 2.0;
      case 2:
      case 3:
        return 15.0;
      case 4:
      case 5:
        return 40.0;
      case 6:
      case 7:
        return 100.0;
      default:
        return 0.0;
    }
  }
}
