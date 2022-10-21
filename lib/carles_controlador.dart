import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:horariov1/Model.dart';

void main() => runApp(SettingsPage());

class SettingsPage extends StatefulWidget {
  final SettingsController _controller = SettingsController();

  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuració"),
      ),
      body: getFormulari(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          if (_formKey.currentState != null &&
              _formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            widget._controller.save();
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Widget getFormulari() {
    return Form(key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text("Títol")),
              onSaved: (valor) => widget._controller.setTitle(valor ?? ""),
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text("Nombre de sessions"),
              ),
              keyboardType: TextInputType.number,
              validator: (valor) {
                if (int.tryParse(valor ?? "") == null ||
                    int.parse(valor!) < 1) {
                  return "Número mayor que 0";
                }
              },
              onSaved: (valor) =>
                  widget._controller.setNSesiones(int.parse(valor!)),
            ),
            FormField<TimeOfDay>(
              builder: (formFieldState) {
                return TextButton(
                  onPressed: () async {
                    TimeOfDay? theTime = await showTimePicker(
                        initialTime: const TimeOfDay(hour: 21, minute: 20),
                        context: context);
                    if (theTime != null) {
                      formFieldState.didChange(theTime);
                    }
                  },
                  child: Text(
                      "Hora inici: ${formFieldState.value?.format(context) ??
                          "Tap to define"}"),
                );
              },
              onSaved: (valor) => widget._controller.setInitialTime(valor!),
              validator: (valor) => valor == null ? "Requerido" : null,
            ),
            FormField<TimeOfDay>(
              builder: (formFieldState) {
                return TextButton(
                  onPressed: () async {
                    TimeOfDay? theTime = await showTimePicker(
                        initialTime: const TimeOfDay(hour: 21, minute: 20),
                        context: context);
                    if (theTime != null) {
                      formFieldState.didChange(theTime);
                    }
                  },
                  child: Text(
                      "Hora final: ${formFieldState.value?.format(context) ??
                          "Tap to define"}"),
                );
              },
              onSaved: (valor) => widget._controller.setEndTime(valor!),
              validator: (valor) => valor == null ? "Requerido" : null,
            ),
          ],
        ));
  }
}

class SettingsController {
  //Se definene variables para los diferentes inputs (Titulos, sesiones, hora inicio,hora final)
  String? _titulo;
  int? _nSesiones;
  TimeOfDay? _initTime;
  TimeOfDay? _endTime;

//Setter de titulo
  void setTitle(String elTitulo) {
    _titulo = elTitulo;
  }
//Setter del numero de sesiones
  void setNSesiones(int nSesiones) {
    _nSesiones = nSesiones;
  }
//Setter inicio de las clases
  void setInitialTime(TimeOfDay initTime) {
    _initTime = initTime;
  }
//Setter final clases
  void setEndTime(TimeOfDay endTime) {
    _endTime = endTime;
  }

  @override
  String toString() {
    return "$_titulo: ${_initTime?.hour ?? "null"}:${_initTime?.minute ??
        "null"} - ${_endTime?.hour ?? "null"}:${_endTime?.minute ??
        "null"} $_nSesiones sesiones";
  }

//Esto guarda las variables para poder usarlo en el punto del horario
  void save() {
    HorarioModel().setConfiguracion(title: _titulo,
        nSesiones: _nSesiones,
        horaFinal: _endTime,
        horaInicial: _initTime);
  }


}
