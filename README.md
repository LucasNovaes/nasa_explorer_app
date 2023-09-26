## About:
A Flutter mobile app (iOS and Android) for displaying amazing astronomy photos by loading images with information via NASA's Astronomy Pictures Of Day API.

# Functionalities
- Main page listing 10 image items with title and date
- Details page that loads the image, title and description of the selected item on the main page
- Caching of items downloaded from the internet, giving the application the freedom to work offline.

# Architecture
The architecture adopted is Clean Arch, and also SOLID and Clean Code principles.
The base structure consists of the layers:
- Domain
- Data
- Presentation

# How to run
- 1 - Get an [API Key](https://api.nasa.gov/)
- 2 - Run the command: 
``flutter run -t lib/main.dart \
--dart-define=API_BASE_URL=https://api.nasa.gov \
--dart-define=API_ID_KEY=<your API Key>``
