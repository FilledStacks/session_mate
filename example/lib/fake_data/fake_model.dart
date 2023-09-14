import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

abstract class FakeModel<T> {
  Faker get faker => Faker();

  /// Creates a fake uuid.
  String createFakeUuid() {
    return const Uuid().v4();
  }

  /// Generate fake list based on provided length.
  List<T> generateFakeList({required int length}) {
    return List.generate(length, (index) => generateFake(id: index));
  }

  /// Generate a single fake model.
  T generateFake({int id = 0});
}
