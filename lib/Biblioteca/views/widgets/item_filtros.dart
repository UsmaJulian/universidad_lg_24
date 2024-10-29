import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Biblioteca/bloc/biblioteca/biblioteca_bloc.dart';
import 'package:universidad_lg_24/Biblioteca/models/biblioteca_model.dart';
import 'package:universidad_lg_24/constants.dart';

class ItemFiltros extends StatefulWidget {
  const ItemFiltros({super.key, this.item});
  final List<Filtro>? item;

  @override
  _ItemFiltrosState createState() => _ItemFiltrosState();
}

class _ItemFiltrosState extends State<ItemFiltros> {
  String? dropdownValueFiltro;
  @override
  void initState() {
    super.initState();
    dropdownValueFiltro = widget.item![0].tid;
  }

  @override
  Widget build(BuildContext context) {
    final bibliotecaBloc = BlocProvider.of<BibliotecaBloc>(context);

    return DropdownButtonFormField<String>(
      value: dropdownValueFiltro,
      isExpanded: true,
      elevation: 16,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      dropdownColor: mainColor,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValueFiltro = newValue;

          bibliotecaBloc.add(FiterBibliotecaEvent(filtro: newValue));
        });
      },
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: mainColor, width: 0),
        ),
      ),
      items: widget.item!.map((e) {
        return DropdownMenuItem<String>(
          value: e.tid,
          child: Text(
            e.name.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }
}
