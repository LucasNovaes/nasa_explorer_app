# NASA Explorer App
## About:
A Flutter mobile app (available on iOS and Android) designed to showcase stunning astronomy photos. These images are retrieved along with relevant information through NASA's Astronomy Pictures Of The Day API.

## Functionalities
- Main page featuring a list of image items, each displaying a title and date.
- Details page that loads the selected item's image, title, and description from the main page.
- Caching of items downloaded from the internet, enabling the application to function offline.

## Architecture
The adopted architecture follows Clean Architecture principles, as well as SOLID and Clean Code principles. The core structure comprises the following layers:
- Domain
- Data
- Presentation

## How to Run
- 1 - Obtain an [API Key](https://api.nasa.gov/).
- 2 - Run the script ``flutter_clean_get.sh``.
- 3 - Execute the following command:
```flutter run -t lib/main.dart \
--dart-define=API_BASE_URL=https://api.nasa.gov \
--dart-define=API_ID_KEY=<your API Key>
```

## Extras
To run test coverage, execute the shell script ```flutter_run_coverage_test.sh```.