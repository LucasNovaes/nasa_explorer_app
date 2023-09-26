# NASA Explorer App
## About:
A Flutter mobile app (available on iOS and Android) designed to showcase stunning astronomy photos. These images are retrieved along with relevant information through [NASA's Astronomy Pictures Of The Day API](https://api.nasa.gov/).

## Functionalities
- Main page featuring a list of image items, each displaying a title and date.
- Details page that loads the selected item's image, title, and description from the main page.
- Caching of items downloaded from the internet, enabling the application to function offline.
- Button to refresh load data
- Input to search image items by title or date

## Getting Started
- This project uses Flutter version 3.13.5.
### Prerequisites
To run the NASA Explorer App project, you will need the following:

- Dio package version 5.3.2 or higher.
- Shared Preferences package version 2.2.1 or higher.
- Get It package version 7.0.3 or higher.
- Mocktail package version 1.0.0 or higher.
You can install Flutter and Dart from the Flutter website. You can install the other packages using the following command:
``flutter pub get``
### Additional notes
The NASA Explorer App project uses the Material Design widget library.
The project also has an assets folder containing images that are used in the app.

### Steps for run this project:
- 1 - Obtain an [API Key](https://api.nasa.gov/).
- 2 - Run the script ``flutter_clean_get.sh``.
- 3 - Execute the following command:
```flutter run -t lib/main.dart \
--dart-define=API_BASE_URL=https://api.nasa.gov \
--dart-define=API_ID_KEY=<your API Key>
```
## Architecture
The adopted architecture follows Clean Architecture principles, as well as SOLID and Clean Code principles. The core structure comprises the following layers:
- Domain
- Data
- Presentation
## State Management
The library for managing states was ValueNotifier. That allows you to store a value and notify any listeners when the value changes.