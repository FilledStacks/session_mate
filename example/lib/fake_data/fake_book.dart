import 'package:bookshelf/fake_data/fake_model.dart';
import 'package:bookshelf/models/book.dart';
import 'package:bookshelf/models/image_links.dart';

const defaultImage =
    'https://images.unsplash.com/photo-1583589264978-d440c84bd017?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=480&ixid=MnwxfDB8MXxyYW5kb218MHx8d29sdmVzLHJhbmRvbXx8fHx8fDE2OTcwNDk4MzM&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=640';

class FakeBook extends FakeModel<Book> {
  @override
  Book generateFake({int id = 0, String image = defaultImage}) {
    return Book(
      id: id,
      authors: [faker.person.name(), faker.person.name()],
      title: faker.company.name(),
      imageLinks: ImageLinks(smallThumbnail: image, thumbnail: image),
      description: faker.lorem.sentences(5).join(''),
    );
  }
}
