# Weather Application

## Getting Started

1. Clone the repository
2. Get an API key from [WeatherAPI.com](https://www.weatherapi.com/)
3. Add your API key to the `api_source.dart` file
4. Run `flutter pub get` to install dependencies
5. Run the app using `flutter run`

## Project Overview

This is a feature-rich Flutter weather application that provides detailed weather information based on the user's current location or a searched city. The app offers a beautiful UI with dynamic theming based on current weather conditions.

### Features

### Current Weather Information

- Real-time temperature display with min/max values
- Detailed weather condition descriptions
- Dynamic weather icons that change based on conditions and time of day
- Location-based weather data using device GPS

### Hourly Forecast

- Scrollable hourly weather forecast
- Temperature and condition information for each hour
- Visual weather condition icons for each hour

### Astronomical Information

- Sunrise and sunset times
- Moonrise and moonset times
- Moon phase visualization with illumination percentage
- Interactive moon phase display with stars animation

### Location Services

- Automatic weather data based on current GPS location
- Search functionality to get weather for any city worldwide
- Permission handling for location services

### UI Features

- Dynamic theming based on current weather conditions
- Custom gradient backgrounds that adapt to weather
- Beautiful animations and transitions
- Custom card components with backdrop blur effects
- Loading screen with animations

## Packages Used

### State Management

- **provider (^6.1.2)**: Implements the Provider pattern for state management, used to share weather data across the app.

### Networking

- **http (^1.2.2)**: Handles HTTP requests to the weather API for fetching weather data.

### Location Services

- **geolocator (^13.0.1)**: Provides geolocation functionality to get the user's current location coordinates.

### UI Enhancements

- **cupertino_icons (^1.0.8)**: Provides iOS-style icons for a consistent look across platforms.
- **glitters (^0.4.0)**: Creates glitter/particle effects for visual enhancements.
- **starsview (^0.0.2)**: Implements the starry background for the moon phase display.

## API Integration

- The app uses the [WeatherAPI.com](https://www.weatherapi.com/) service to fetch weather data.
- Features include current weather, forecasts, and astronomical data.
