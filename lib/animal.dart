abstract class Animal {
  final String name;

  int _energy = 80;
  int _health = 80;
  int _happiness = 80;

  abstract final String emoji;

  Animal(this.name) {
    say("Hello, world!");
  }

  String get kingdom;

  String get species => this.runtimeType.toString().toLowerCase();

  int get energy => _energy;
  int get health => _health;
  int get happiness => _happiness;

  String toString() {
    return "${mood()} $name the $species";
  }

  void say(String s) {
    print("$name says: $s");
  }

  String mood() {
    if (_energy < 50) return "😩";
    if (_health < 50) return "🤒";
    if (_happiness < 50) return "😟";
    return emoji;
  }

  void report() {
    say("${mood()} Hello, I am $name the ${species} and I roam the ${kingdom}! ($_energy% energy, $_health% health, $_happiness% happy)");
  }

  void changeEnergy(int delta) {
    _energy += delta;
    if (_energy < 0) _energy = 0;
    if (_energy > 100) _energy = 100;
  }

  void changeHealth(int delta) {
    _health += delta;
    if (_health < 0) _health = 0;
    if (_health > 100) _health = 100;
  }

  void changeHappiness(int delta) {
    _happiness += delta;
    if (_happiness < 0) _happiness = 0;
    if (_happiness > 100) _happiness = 100;
  }

  void makeNoise();

  void exercise() {
    print("$name is exercising...");
    changeEnergy(-20);
    changeHappiness(20);
    changeHealth(20);
  }
}
