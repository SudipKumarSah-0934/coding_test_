import 'package:get/get.dart';

import '../../../../config/theme/my_theme.dart';
import '../../../../utils/constants.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/models/weather_model.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../../services/location_service.dart';
import '../views/widgets/location_dialog.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  // hold current weather data
  late WeatherModel currentWeather;

  // hold the weather arround the world
  List<WeatherModel> weatherArroundTheWorld = [];
  late WeatherModel weatherByCity;

  // for update
  final dotIndicatorsId = 'DotIndicators';
  final themeId = 'Theme';

  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.loading;

  // for app theme
  var isLightTheme = MySharedPref.getThemeIsLight();

  // for weather slider and dot indicator
  var activeIndex = 1;

  var showSearchPane = false.obs;
  var searchResults = <WeatherModel>[].obs;
  var isSearching = false.obs; // New state for managing search state
  var searchError = ''.obs; // New state for managing search error

  void toggleSearchPane() {
    showSearchPane.value = !showSearchPane.value;
    if (!showSearchPane.value) {
      isSearching.value = false; // Reset search state when closing search pane
      searchError.value = '';
      searchResults.clear(); // Reset error state when closing search pane
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      searchError.value = 'Search query cannot be empty';
      isSearching.value = false;
    } else {
      searchResults.value = getWeatherByCity(query);
      isSearching.value = true;
      searchError.value = ''; // Clear error when search is successful
    }
  }

  void clearSearch() {
    searchResults.clear();
    isSearching.value = false;
    searchError.value = ''; // Clear error when search is cleared
  }

  @override
  void onInit() async {
    if (!await LocationService().hasLocationPermission()) {
      Get.dialog(const LocationDialog());
    } else {
      getUserLocation();
    }
    super.onInit();
  }

  /// get the user location
  getUserLocation() async {
    var locationData = await LocationService().getUserLocation();
    if (locationData != null) {
      await getCurrentWeather(
          '${locationData.latitude},${locationData.longitude}');
    }
  }

  /// get home screem data (sliders, brands, and cars)
  getCurrentWeather(String location) async {
    await BaseClient.safeApiCall(
      Constants.currentWeatherApiUrl,
      RequestType.get,
      queryParameters: {
        Constants.key: Constants.apiKey,
        Constants.q: location,
        Constants.lang: 'en',
      },
      onSuccess: (response) async {
        currentWeather = WeatherModel.fromJson(response.data);
        await getWeatherAroundTheWorld();
        apiCallStatus = ApiCallStatus.success;
        update();
      },
      onError: (error) {
        BaseClient.handleApiError(error);
        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }

  /// get weather arround the world
  getWeatherAroundTheWorld() async {
    weatherArroundTheWorld.clear();
    final cities = ['New Delhi', 'Mumbai', 'Kathmandu'];
    await Future.forEach(cities, (city) {
      BaseClient.safeApiCall(
        Constants.currentWeatherApiUrl,
        RequestType.get,
        queryParameters: {
          Constants.key: Constants.apiKey,
          Constants.q: city,
          Constants.lang: 'en',
        },
        onSuccess: (response) {
          weatherArroundTheWorld.add(WeatherModel.fromJson(response.data));
          update();
        },
        onError: (error) {
          BaseClient.handleApiError(error);
        },
      );
    });
  }

  /// get weather by city
  getWeatherByCity(String searchedCity) async {
    await BaseClient.safeApiCall(
      Constants.currentWeatherApiUrl,
      RequestType.get,
      queryParameters: {
        Constants.key: Constants.apiKey,
        Constants.q: searchedCity,
        Constants.lang: 'en',
      },
      onSuccess: (response) async {
        weatherByCity = WeatherModel.fromJson(response.data);
        await getWeatherAroundTheWorld();
        apiCallStatus = ApiCallStatus.success;
        update();
        searchResults.value = [weatherByCity]; // Update search results directly
        isSearching.value = true;
        searchError.value = ''; // Clear error when search is successful
      },
      onError: (error) {
        BaseClient.handleApiError(error);
        apiCallStatus = ApiCallStatus.error;
        update();
        clearSearch(); // Clear search results and error on error
      },
    );
  }

  /// when the user slide the weather card
  onCardSlided(index, reason) {
    activeIndex = index;
    update([dotIndicatorsId]);
  }

  /// when the user press on change theme icon
  onChangeThemePressed() {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update([themeId]);
  }

  onWeatherSearchByCity() {}
}
