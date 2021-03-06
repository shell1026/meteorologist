require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url= ("https://api.forecast.io/forecast/865b35a2d037f196c8036ff2f8eda3e9/"+@lat.to_s+","+@lng.to_s)

    parsed_data = JSON.parse(open(url).read)


    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    if parsed_data["minutely"]!=nil
      @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]
    end

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]
    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
