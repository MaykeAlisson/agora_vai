import 'package:agora_vai/model/Lancamento.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:provider/provider.dart';
//
////providers
//import '../providers/tasks.dart';
//
////widgets
//import '../widgets/new_task_dialog.dart';

class ObjetivoPage extends StatefulWidget {
  static const routeName = '/objetivo-page';

  @override
  _ObjetivoPageState createState() => _ObjetivoPageState();
}

class _ObjetivoPageState extends State<ObjetivoPage> {
  String _descricao = "teste";
  int _qtdLancamentos = 3;
  int _qtdObjetivo = 5;
  List<Lancamento> _lancamentos = List<Lancamento>();

  void _buscaLancamentosObjetivo() {
    List<Lancamento> _listaTemp = List<Lancamento>();

    Lancamento lanc = new Lancamento(1, "teste lanc", 1);
    Lancamento lanc2 = new Lancamento(1, "teste lanc", 1);
    Lancamento lanc3 = new Lancamento(1, "teste lanc", 1);
    Lancamento lanc4 = new Lancamento(1, "teste lanc", 1);

    _listaTemp.add(lanc);
    _listaTemp.add(lanc2);
    _listaTemp.add(lanc3);
    _listaTemp.add(lanc4);

    setState(() {
      _lancamentos = _listaTemp;
    });
  }

  @override
  void initState() {
    super.initState();
    _buscaLancamentosObjetivo();
  }

  @override
  Widget build(BuildContext context) {
//    TasksProvider tasksProvider = ModalRoute.of(context).settings.arguments as TasksProvider;
//    return ChangeNotifierProvider.value(
//      value: tasksProvider,
//      child: Consumer<TasksProvider>(
//        builder:(ctx,tasks,_){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _descricao.toUpperCase(),
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ),
        bottom: CustomAppBar(
          lancamento: _qtdLancamentos,
          total: _qtdObjetivo,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
            onPressed: () {
//                    showDialog(
//                      context: context,
//                      builder: (context){
//                        return NewTaskDialog(tasksProvider: tasksProvider,);
//                      }
//                    );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _lancamentos.length,
        itemBuilder: (context, index) {
          final lancamento = _lancamentos[index];
          return ListTile(
            leading: Text(lancamento.dtaLancamento.toString()),
            title: Text(
              lancamento.descricao,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(decoration: null, color: Colors.black)),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                size: 22,
                color: Colors.redAccent,
              ),
              onPressed: () {
//                      tasksProvider.removeTask(tasks.getTasks[i].id);
              },
            ),
          );
        },
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final int lancamento;
  final int total;

  CustomAppBar({
    this.lancamento,
    this.total,
  });

  final size = AppBar().preferredSize * 1.5;
  final TextStyle style = GoogleFonts.poppins(
      textStyle: TextStyle(fontSize: 17, color: Colors.white));

  @override
  Widget build(BuildContext context) {
    int left = total - lancamento;
    return Container(
      padding: EdgeInsets.only(left: 30, right: 20),
      height: size.height,
      width: AppBar().preferredSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
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
            //backgroundColor: Colors.white30,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            value: total == 0
                ? 1
                : lancamento == 0 ? 0 : (lancamento / total).toDouble(),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => size;
}

// ListTile(
//             leading: Checkbox(
//               value: tasks[i].isDone,
//               onChanged: (value){
//                 tasks[i].toggleDone();
//               },
//             ),
//             title: Text(tasks[i].name,style: TextStyle(decoration: tasks[i].isDone ? TextDecoration.lineThrough : null),),
//             trailing: tasks[i].isDone ? IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: (){},
//             ) : null,
//           );
