import 'package:flutter/material.dart';
// ARCHIVO CONTROLADOR
// PRIMERA PANTALLA ARCHIVO DE SETTINGS
// ARCHIVO QUE CONTIENE LA PRIMERA PAGINA FORMULARIO
// ESTE ARCHIVO CONTIENE DOS CAMPOS DE TEXTO PARA EL TITULO Y NUMERO DE SESIONES
// DOS TIMEPICKERS EL PRIMERO PARA EL INICIO DE HORA Y EL SEGUNDO PARA LA HORA DE SALIDA


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Formulario';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: Formulario(),
      ),
    );
  }
}

// Crea un Widget Form
class Formulario extends StatefulWidget {



  @override
  FormularioState createState() {
    return FormularioState();
  }
}

// Crea una clase State correspondiente. Esta clase contendrá los datos relacionados con
// el formulario.
class FormularioState extends State<Formulario> {
  // Crea una clave global que identificará de manera única el widget Form
  // y nos permita validar el formulario
  //
  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Crea un widget Form usando el _formKey que creamos anteriormente
    return Form(key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: (const InputDecoration(
              labelText: 'Titulo',
            )),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
            },
          ),
          TextFormField(
            decoration: (const InputDecoration(
              labelText: 'Numero de clases al dia',
            )),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
            },
          ),
/*
          FormField(TimeOfDay)(
            builder:(FormFieldState){
              return TextButton(
                  onPressed: () async {
                    TimeOfDay? theTime = await showTimePicker(
                        initialTime: const TimeOfDay(hour: 21, minute: 20)
                      context: context);
                    if (theTime != null){
                      formFieldState.didChange(theTime);
                    }
                  },
                child: Text(
                  "Hora inicio: ${formFieldState.value?.format(context)??
                    "tap to define"}"
                ),
              )
            }
          */
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // devolverá true si el formulario es válido, o falso si
                // el formulario no es válido.
                if (_formKey.currentState!.validate()) {
                  // Si el formulario es válido, queremos mostrar un Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}