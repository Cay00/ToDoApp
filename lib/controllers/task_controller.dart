import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/database.dart';

/// Kontroler zarządzający operacjami na zadaniach (dodawanie, usuwanie, zmiana statusu)
/// Komunikuje się z warstwą danych (ToDoDataBase) i udostępnia metody dla warstwy UI
class TaskController {
  final _myBox = Hive.box('mybox');
  final controller = TextEditingController();
  final ToDoDataBase db = ToDoDataBase();
  DateTime? selectedDate; // Zmienna przechowująca wybraną datę

  /// Inicjalizuje bazę danych - tworzy dane początkowe jeśli baza jest pusta,
  /// w przeciwnym razie ładuje istniejące dane
  void initDatabase() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  /// Lista wszystkich zadań (tylko do odczytu)
  List get toDoList => db.toDoList;

  /// Zmienia status wykonania zadania o podanym indeksie
  /// [index] - pozycja zadania w liście
  void toggleTask(int index) {
    db.toDoList[index][1] = !db.toDoList[index][1];
    db.updateDataBase();
  }

  /// Zmienia status ważności zadania o podanym indeksie
  /// [index] - pozycja zadania w liście
  void toggleImportant(int index) {
    db.toDoList[index][2] = !db.toDoList[index][2]; // toggle ważności
    db.updateDataBase();
  }

  /// Dodaje nowe zadanie na podstawie tekstu z kontrolera i wybranej daty
  /// Czyści pole tekstowe po dodaniu zadania
  void addTask() {
    // Dodanie zadania z tekstem, statusem wykonania, ważnością oraz datą
    db.toDoList.add([controller.text, false, false, selectedDate?.toString()]);
    controller.clear();
    selectedDate = null; // Resetowanie wybranej daty po dodaniu zadania
    db.updateDataBase();
  }

  /// Usuwa zadanie o podanym indeksie
  /// [index] - pozycja zadania w liście do usunięcia
  void deleteTask(int index) {
    db.toDoList.removeAt(index);
    db.updateDataBase();
  }

  /// Ustawia datę wykonania zadania
  void setTaskDate(DateTime? date) {
    selectedDate = date;
  }

  /// Zwraca datę wykonania zadania jako String lub "Null" jeśli data nie jest ustawiona
  String getTaskDateString(int index) {
    if (db.toDoList[index].length > 3 && db.toDoList[index][3] != null) {
      try {
        DateTime dateTime = DateTime.parse(db.toDoList[index][3]);
        return '${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year}';
      } catch (e) {
        return '';
      }
    }
    return '';
  }
}
