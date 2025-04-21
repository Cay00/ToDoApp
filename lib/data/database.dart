import 'package:hive_flutter/hive_flutter.dart';

/// Klasa zarządzająca przechowywaniem danych zadań w Hive
/// Odpowiada za operacje CRUD na liście zadań
class ToDoDataBase {
  /// Lista przechowująca wszystkie zadania
  /// Każde zadanie reprezentowane jako List w formacie:
  /// [String title, bool isCompleted, bool isImportant, String? dueDate]
  List toDoList = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  /// Tworzy początkowe dane zadania (używane przy pierwszym uruchomieniu aplikacji)
  void createInitialData() {
    final nextDay = DateTime.now().add(const Duration(days: 1)).toString();

    toDoList = [
      ["Your first task", false, true, nextDay], // Pierwsze zadanie z datą na następny dzień
      ["Do Exercise", false, true, DateTime.now().toString()], // Drugie zadanie z aktualną datą
      ["My Actual Task", false, false, null],
      ["Done Task", true, false, null],
    ];
  }


  /// Tworzy początkowe dane zadania (używane przy pierwszym uruchomieniu aplikacji)
  void loadData() {
    toDoList = _myBox.get("TODOLIST");

    // Sprawdzenie i aktualizacja struktury danych dla starszych wersji
    for (int i = 0; i < toDoList.length; i++) {
      if (toDoList[i].length < 4) {
        toDoList[i].add(null); // Dodanie pola na datę jeśli go nie ma
      }
    }
  }

  /// Aktualizuje dane w bazie Hive na podstawie lokalnej listy zadań
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}