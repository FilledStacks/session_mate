import 'package:bookshelf/fake_data/fake_model.dart';
import 'package:bookshelf/models/book.dart';
import 'package:bookshelf/models/image_links.dart';

class FakeBook extends FakeModel<Book> {
  static int bookId = 0;

  @override
  Book generateFake() {
    final thumbnailImage = faker.image.image(random: true);
    return Book(
      id: bookId++,
      authors: [
        faker.person.name(),
        faker.person.name(),
      ],
      title: faker.company.name(),
      imageLinks: ImageLinks(
        smallThumbnail: thumbnailImage,
        thumbnail: thumbnailImage,
      ),
      description: faker.lorem.sentences(5).join(''),
    );
  }
}
