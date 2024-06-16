import 'location.dart';
import 'networking.dart';


const leftparturl='https://api.openweathermap.org/data/2.5/weather';
const  acesskey = '20c5be9145c63e1118d9f13e5f483272';


class Weadhermodel{

  Future<dynamic> getcityweadher(String cityname) async{
  networking networkhelper = networking(
      '$leftparturl?q=$cityname&appid=$acesskey&units=metric');
  return await networkhelper.getdata();

}

  Future<dynamic> getlocationweadher() async{
    await location().getcurrentlocation();
    networking networkhelper = networking(
        '$leftparturl?lat=${location().latitude}&lon=${location().longitude}&appid=$acesskey&units=metric');
    //22.300039
    //70.746540
    return await networkhelper.getdata();

  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}