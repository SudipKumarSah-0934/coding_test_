# coding_test_
Weather App
- A simple weather app using Flutter that displays current weather information
## Features
 1. Use [weatherapi](https://www.weatherapi.com/docs/) to fetch weather data.
 2. The app should have two screens: 
    - Home screen with a search bar to enter a city name 
    - Weather details screen to display the weather information
 3. On the home screen:
    - Implementasearchbar where users can enter a city name
    - Addabuttontotrigger the weather search
    - Displayaloading indicator while fetching data
 4. On the weather details screen, display the following information:
    - Cityname,Current temperature (in Celsius), Weather condition (e.g., cloudy, sunny,rainy), 
    - An icon representing the weather condition,Humidity percentage, Wind speed
 5. Implemented proper error handling for API requests and displays user-friendly error messages.
 6. Used appropriate Getx state management to manage the app's state.
 7. Implemented a basic responsive design that works on both mobile and tablet devices.
 8. Added a "Refresh" button on the weather details screen to fetch updated weather data.
 9. Implemented shared prefrence for data persistence  to save the last searched city
## Installation
 - Clone and run`