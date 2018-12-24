# WeatherInfoParser
This project is to demonstrate my coding skills.

REQUIREMENTS:
• Read about the following MetaWeather API here https://www.metaweather.com/api/
• Obtain the device’s GPS coordinates, if available, and pass them to the service.
(https://www.metaweather.com/api/location/search/?lattlong=(latt),(long))
• If coordinates are not available, pass user entered keyword/location name
(https://www.metaweather.com /api/location/search/?query=(query))
• Presently store all the search keyworks/location with a time stamp so that when the
user can see search history in the future
• In a list, display each location id, title and type
• On selecting a location from the list, open another page which would show weather
details for next 5 days
(https://www.metaweather.com/ /api/location/(woeid))


Below are some limatations for this coding challenge

1. Haven't really taken care of localization, string constants
2. Haven't handle any accessibility
3. Only minimal network error handling. Didn't handle the scenario where Html was being sent as error response.
4. Eventhough designed all the components to be unit testable, haven't really done any unit test cases.
5. Otherthan handling the outOfbox dynamic type, I haven't handled any dynamic type.
6. This app was tested on iOS 11 devices only and used Xcode 9. Tested on iPhone8.
