import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

abstract class FakeModel<T> {
  static const List<String> images = [
    'https://images.unsplash.com/photo-1484501893812-f1923a3dd028?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=480&ixid=MnwxfDB8MXxyYW5kb218MHx8cmFuZG9tfHx8fHx8MTY5NzA0MzIwOA&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=640',
    'https://images.unsplash.com/photo-1513542789411-b6a5d4f31634?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=480&ixid=MnwxfDB8MXxyYW5kb218MHx8cmFuZG9tfHx8fHx8MTY5NzA0MjY4Ng&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=640',
    'https://images.unsplash.com/photo-1519145127298-00d5287fcdd3?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=480&ixid=MnwxfDB8MXxyYW5kb218MHx8cmFuZG9tfHx8fHx8MTY5NzA0ODkzMA&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=640',
    'https://images.unsplash.com/photo-1603290989063-b255b11b2525?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=480&ixid=MnwxfDB8MXxyYW5kb218MHx8cmFuZG9tfHx8fHx8MTY5NzA0ODk3MA&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=640',
    'https://images.unsplash.com/photo-1509909756405-be0199881695?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=480&ixid=MnwxfDB8MXxyYW5kb218MHx8cmFuZG9tfHx8fHx8MTY5NzA0ODk5Ng&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=640',
    'https://images.unsplash.com/photo-1621867822738-ba65f95a8eea?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=480&ixid=MnwxfDB8MXxyYW5kb218MHx8cmFuZG9tfHx8fHx8MTY5NzA0OTAxNA&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=640',
    'https://images.unsplash.com/photo-1524678714210-9917a6c619c2?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=480&ixid=MnwxfDB8MXxyYW5kb218MHx8cmFuZG9tfHx8fHx8MTY5NzA0OTAzMg&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=640',
    'https://images.unsplash.com/photo-1524856949007-80db29955b17?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=480&ixid=MnwxfDB8MXxyYW5kb218MHx8cmFuZG9tfHx8fHx8MTY5NzA0OTE2OA&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=640',
    'https://images.unsplash.com/photo-1432821596592-e2c18b78144f?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=480&ixid=MnwxfDB8MXxyYW5kb218MHx8cmFuZG9tfHx8fHx8MTY5NzA0OTA1OQ&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=640',
    'https://images.unsplash.com/photo-1485550409059-9afb054cada4?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=480&ixid=MnwxfDB8MXxyYW5kb218MHx8cmFuZG9tfHx8fHx8MTY5NzA0OTA3OQ&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=640',
  ];

  Faker get faker => Faker();

  /// Creates a fake uuid.
  String createFakeUuid() {
    return const Uuid().v4();
  }

  /// Generate fake list based on provided length.
  List<T> generateFakeList({required int length}) {
    return List.generate(
      length,
      (index) => generateFake(id: index, image: images[index % 10]),
    );
  }

  /// Generate a single fake model.
  T generateFake({int id = 0, String image});
}
