import 'package:mocktail/mocktail.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/media_entity.dart';

class MockMediaEntity extends Mock implements MediaEntity {
  static makeEntity() {
    return const MediaEntity(
      date: "12-12-2021",
      explanation:
          "On September 18, 1997, many stargazers in the U. S. were able to watch a lovely early morning lunar occultation as a bright Moon passed in front of Saturn. Using a 1.2 meter reflector, astronomer Kris Stanek had an excellent view of this dream-like event from the Whipple Observatory atop Arizona's Mount Hopkins. This animated gif image was constructed by Wes Colley from 4 frames taken by Stanek at 35 second intervals as the ringed planet emerged from behind the Moon's dark limb. While lunar occultations of fairly bright stars and planets are not extremely rare events, their exact timing depends critically on the observer's location. For observers in western North America, the Moon will next occult Saturn on Monday morning, September 10.",
      title: "Estrela de neutrons supermassiva",
      mediaType: "image",
      url: "https://apod.nasa.gov/apod/image/0701/KrakowMcNaught2_sawow.jpg",
    );
  }
}
