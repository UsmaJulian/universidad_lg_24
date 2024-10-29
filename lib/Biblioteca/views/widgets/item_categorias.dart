import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Biblioteca/bloc/biblioteca/biblioteca_bloc.dart';
import 'package:universidad_lg_24/Biblioteca/models/biblioteca_model.dart';
import 'package:universidad_lg_24/constants.dart';

class ItemCategorias extends StatefulWidget {
  const ItemCategorias({super.key, this.item, this.filtro});
  final List<FiltrosCate>? item;
  final String? filtro;
  @override
  _ItemCategoriasState createState() => _ItemCategoriasState();
}

class _ItemCategoriasState extends State<ItemCategorias> {
  String? dropdownValue;
  List<FiltrosCate> data = [];

  @override
  void initState() {
    super.initState();
    // data = widget.item;
    data = widget.item!;

    dropdownValue = data[0].tid;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BibliotecaBloc, BibliotecaState>(
      listener: (context, state) {
        if (state is BibliotecaChangeFilter) {
          setState(() {});
          dropdownValue = data[0].tid;
        }
      },
      child: BlocBuilder<BibliotecaBloc, BibliotecaState>(
        builder: (context, state) {
          final bibliotecaBloc = BlocProvider.of<BibliotecaBloc>(context);
          if (state is BibliotecaChangeFilter) {
            data = [];
            if (widget.filtro == 'none') {
              data = widget.item!;
            } else {
              data.add(widget.item!.first);
              for (final item in widget.item!) {
                if (widget.filtro == item.parent && widget.filtro != 'none') {
                  data.add(item);
                }
              }
            }
          }

          return DropdownButtonFormField<String>(
            value: dropdownValue,
            isExpanded: true,
            elevation: 16,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
            dropdownColor: mainColor,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue;
                bibliotecaBloc
                    .add(CategoriaBibliotecaEvent(categoria: newValue));
              });
            },
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: mainColor, width: 0),
              ),
              // hintText: Text('sss');
            ),
            items: data.map((e) {
              return DropdownMenuItem<String>(
                value: e.tid,
                child: Text(
                  e.name.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
