class Cars {
  final String name;
  final int? year;

  Cars({required this.name, this.year});
}

void main() {
  final cars = [Cars(name: 'BMW', year: 2002), Cars(name: 'OPEL')];

  cars.map((car) {
    return print(
      'Logo: ${car.name} ${car.year != null ? ', Year: ${car.year}' : " "}',
    );
  }).toList();
}
