import 'package:interact/interact.dart';
import 'package:zoo/animal.dart';
import 'package:zoo/terrestrial_animal.dart';

class ZooException implements Exception {
  String message;
  ZooException(this.message);
}

class Zoo {
  Map<String, Animal> animals = {};

  // Tier erstellen:
  // - Spezies und Name abfragen
  // - Tier instanziieren und speichern
  void createAnimal() {
    // Hier müssen alle Tierklassen eingetragen werden,
    // die erstellt werden können.
    List species_options = [
      Dog.new,
    ];
    // Tierklassen in lesbare Namen umwandeln
    List<String> species_options_labels = species_options.map((x) {
      return x.runtimeType.toString().replaceAll('(dynamic) => ', '');
    }).toList();
    // Spezies auswählen
    int species_choice =
        Select(prompt: "Choose a species:", options: species_options_labels)
            .interact();
    // Name abfragen
    String name = Input(
      prompt: 'Please enter a name:',
      validator: (String x) {
        if (x.isEmpty) {
          throw ValidationError('Name cannot be empty.');
        } else if (animals.containsKey(x)) {
          throw ValidationError('There is already an animal with that name.');
        } else {
          return true;
        }
      },
    ).interact();
    // Tier erstellen und speichern
    Animal animal = species_options[species_choice](name);
    animals[name] = animal;
  }

  // zeigt ein Auswahlmenü mit allen Tieren an, außer
  // dem übergebenen, falls eines übergeben wurde.
  Animal chooseAnimalExcept(Animal? animal) {
    List<String> animal_names =
        animals.keys.where((e) => e != animal?.name).toList();
    List<String> animal_labels =
        animal_names.map((e) => "${animals[e]}").toList();
    int index =
        Select(prompt: "Choose an animal:", options: animal_labels).interact();
    return animals[animal_names[index]]!;
  }

  // Tier auswählen und Aktion ausführen
  void selectAnimal() {
    if (animals.isEmpty) {
      print("There are currently no animals.");
      return;
    }
    Animal animal = chooseAnimalExcept(null);
    int choice = Select(prompt: "Choose a command:", options: [
      /* 0 */ 'Status',
      /* 1 */ 'Make a noise',
      /* 2 */ 'Feed',
      /* 3 */ 'Exercise',
      /* 4 */ 'Train',
      /* 5 */ 'Chase another animal',
      /* 6 */ 'Eat another animal',
    ]).interact();
    switch (choice) {
      case 0:
        animal.report();
      case 1:
        animal.makeNoise();
      case 3:
        animal.exercise();
      default:
        throw ZooException("not implemented yet!");
    }
  }

  // Hauptteil des Programms, zeigt ein Auswahlmenü an
  // und führt die gewählte Aktion aus.
  void run() {
    print("Welcome to my zoo!");
    bool quit = false;
    int choice = 0;
    while (!quit) {
      try {
        List<String> options = [
          'Roll call',
          'Create animal',
          'Select animal',
          'Quit',
        ];
        choice = Select(
          prompt: "Choose a command:",
          options: options,
          initialIndex: choice,
        ).interact();
        switch (choice) {
          case 1:
            createAnimal();
          case 2:
            selectAnimal();
          case 3:
            quit = true;
        }
      } on ZooException catch (e) {
        print("Oops, there was a problem:");
        print(e.message);
      }
    }
    print("👋 Have a nice day!");
  }
}

void main() {
  Zoo zoo = Zoo();
  zoo.run();
}
