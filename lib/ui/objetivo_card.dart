import 'package:agora_vai/ui/objetivo_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ObjetivoCard extends StatefulWidget {
  static const routeName = '/objetivo-card';
  final double altura;
  final double largura;
  final String nome;
  final int total;
  final Function deleteFunction;

  const ObjetivoCard({
    Key key,
    this.altura,
    this.largura,
    this.nome,
    this.total,
    this.deleteFunction,
  }) : super(key: key);

  @override
  _ObjetivoCardState createState() => _ObjetivoCardState();
}

class _ObjetivoCardState extends State<ObjetivoCard> {
  final TextStyle style = GoogleFonts.poppins(
      textStyle: TextStyle(fontSize: 17, color: Colors.black));

  int _lancamentos = 5;

  _exibirTelaDetalhes() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(" anotação"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Titulo", hintText: "Digite titulo..."),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Descrição", hintText: "Digite descrição..."),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancelar"),
              ),
              FlatButton(
                onPressed: () {
                  // salva no banco

                  Navigator.pop(context);
                },
                child: Text("nada"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    int left = widget.total - _lancamentos;
    return GestureDetector(
      onTap: () {
//        Navigator.of(context).pushNamed(ObjetivoPage.routeName);
        Navigator.push(context, new MaterialPageRoute(
            builder: (context) =>
            new ObjetivoPage())
        );
//        _exibirTelaDetalhes();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        height: widget.largura * 0.75 * 1.2,
        width: widget.largura * 0.75,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 6),
                  blurRadius: 4,
                  spreadRadius: 3)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${widget.nome}".toUpperCase(),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 25, color: Colors.black)),
                ),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 21,
                      color: Colors.redAccent,
                    ),
                    onPressed: () {
                      widget.deleteFunction(widget.nome);
                    })
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                left == 0
                    ? Text(
                        "All Todos done",
                        style: style,
                      )
                    : left == 1
                        ? Text(
                            "You have $left Todo",
                            style: style,
                          )
                        : Text(
                            "You have $left Todos",
                            style: style,
                          ),
                SizedBox(
                  height: 20,
                ),
                LinearProgressIndicator(
                  value: widget.total == 0
                      ? 1
                      : _lancamentos == 0
                          ? 0
                          : (_lancamentos / widget.total).toDouble(),
                )
              ],
            )
            //Text("${widget.total}"),
          ],
        ),
      ),
    );
  }
}
