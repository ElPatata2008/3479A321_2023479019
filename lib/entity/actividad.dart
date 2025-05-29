
class Actividad {
  int _id;
  String _fecha;
  String _nombre;

  Actividad(this._id, this._fecha, this._nombre);

  int get id { return _id; }
  String get fecha { return _fecha; }
  String get nombre { return _nombre; }

  void editFecha(String nuevaFecha) => _fecha = nuevaFecha;
  void editNombre(String nuevoNombre) => _nombre = nuevoNombre;


  Map<String, Object?> toMap() {
    return <String, Object?>{
      'id': id,
      'fecha': fecha,
      'nombre': nombre
    };
  }
    


}

