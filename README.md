# **News Application**

A simple and elegant News App built with **Flutter** and **BLoC architecture**, that fetches news from an external API and displays them in a scrollable list. Each article can be tapped get an expanded view of the image. The app includes a splash screen, a listing screen that handles loading/error states, and supports pull-to-refresh functionality.


## **Features**

- Clean architecture using **BLoC (Business Logic Component)**
- Splash screen
- Scrollable list of top news articles
- Pull-to-refresh functionality
- Pinch-to-zoom to expand the image


## **Getting Started**

### **Prerequisites**

Before you begin, ensure you have Flutter installed on your machine. You can follow the [official installation guide](https://flutter.dev/docs/get-started/install) to set it up.

This is project is build upon flutter 3.7.3 and related dependencies.

### **Running the Application**

1. **Clone the Repository**

   ```bash
   git clone https://github.com/RutujaKulkarni29/News-App
   cd news-app

2. **Run the Application**
  
   ```bash
   #Choose your preferred method to run the application
   #Using Flutter CLI
   #Install the necessary dependencies
   flutter pub get
   flutter run


4. **Testing**

    This project includes unit and widget tests to ensure the application functions as expected. The tests cover:

    - Unit Test cases.
    - Widget interactions.

    To run the tests:
     ```bash
     flutter test

5. **Project Structure**

  ```plaintext
  lib/
  │
  ├── bloc/
  │   └── news_bloc.dart
  │   └── news_event.dart
  │   └── news_state.dart
  │
  ├── models/
  │   └── news_model.dart
  │
  ├── src/core/network
  │   └── api_client.dart
  │
  └── widgets/
  │   └── api_client.dart
  │   └── loading_widget.dart
  │
  └── screens/
      └── splash_screen.dart
      └── listing_screen.dart
      └── expanded_screen.dart
      
```

**bloc/:** Contains the BLoC files (news_bloc.dart, news_event.dart, news_state.dart) that manage the business logic and state of the application.

**model/:** Contains the NewsArticles model class, which defines the structure of a news article.

**src/core/network/:** Contains the ApiClient class, which handles fetching of news articles.

**widget/:** Contains the UI components.

  ```plaintext
  test/
  │
  └── api_client_test.dart
  └── widget
      └── loading_widget.dart
```

**test/:** Unit and widget tests for the BLoC, widgets.
