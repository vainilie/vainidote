#    3-simple-weather  Copyright (C) 2020  BrutalWizard (https://github.com/bru74lw1z4rd).
#    This program comes with ABSOLUTELY NO WARRANTY;
#    This is free software, and you are welcome to redistribute it
#    under certain conditions;

# More info about wether at - https://openweathermap.org/weather-conditions
# To show icons from this script you will need to buy "Font Awesome Pro" font - https://fontawesome.com/
# Also you can change icon in arrays to yours icons

# Configured for NerdFonts - GitHub raven2cz @raven2cz

import requests
import json

# Settings
city = "Tlalpan" # Your town
api_key = "f6aa22de7be608bc5db7b12784e26ca9" # Your openweather api key
units = "metric" # Unit system {imperial or metric}
temperature_unit = "C" # Units of measurement. That will be showed in UI. Does not affect on API.

icons_list = {
    "01d": "%{T6} %{T-} ", # Clear sky day.
    "01n": "%{T6} %{T-} ", # Clear sky night.
    "02d": "%{T6} %{T-} ", # Few clouds day.
    "02n": "%{T6} %{T-} ", # Few clouds night.
    "03d": "%{T6} %{T-} ", # Scattered clouds day.
    "03n": "%{T6} %{T-} ", # Scattered clouds night.
    "04d": "%{T6} %{T-} ", # Broken clouds day.
    "04n": "%{T6} %{T-} ", # Broken clouds night.
    "09d": "%{T6} %{T-} ", # Shower rain day.
    "09n": "%{T6} %{T-} ", # Shower rain night.
    "10d": "%{T6} %{T-} ", # Rain day.
    "10n": "%{T6} %{T-} ", # Rain night
    "11d": "%{T6} %{T-} ", # Thunderstorm day.
    "11n": "%{T6} %{T-} ", # Thunderstorm night
    "13d": "%{T6} %{T-} ", # Snow day. Snowflake alternative: 
    "13n": "%{T6} %{T-} ", # Snow night. Snowflake alternative: 
    "50d": "%{T6} %{T-} ", # Mist day.
    "50n": "%{T6} %{T-} " # Mist night.
}

atmophere_icons_list = {
    701: "%{T6} %{T-} ", # Mist
    711: "%{T6} %{T-} ", # Smoke
    721: "%{T6} %{T-} ", # Haze
    731: "%{T6} %{T-} ", # Dust (Sand / dust whirls)
    741: "%{T6} %{T-} ", # Fog
    751: "%{T6} %{T-} ", # Sand
    761: "%{T6} %{T-} ", # Dust
    762: "%{T6} %{T-} ", # Ash
    771: "%{T6} %{T-} ", # Squalls
    781: "%{T6} %{T-} "  # Tornado
}

def main():
    try:
        # Get data from openweather
        url = ('http://api.openweathermap.org/data/2.5/weather?q={}&units={}&appid={}').format(city, units, api_key)
        result = requests.get(url)

        # If result was received
        if(result.status_code == requests.codes['ok']):
                # Read json
                weather = result.json()

                # Get info from array
                id = int(weather['weather'][0]['id'])
                group = weather['weather'][0]['main'].capitalize()
                icon = weather['weather'][0]['icon'].capitalize()
                temp = int(float(weather['main']['temp']))

                # Load another icons for Atmosphere group
                if(group == "Atmosphere"):
                    return atmophere_icons_list[id] + ' {}°{}'.format(temp, temperature_unit)
                return icons_list[icon] + ' {}°{}'.format(temp, temperature_unit) + '%{F-}'
        else:
            return "" # Return reload icon
    except:
        return "" # Return reload icon

if __name__ == "__main__":
	print(main())
