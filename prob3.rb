require 'httparty'

def get_current_time(area, location)
    url = "http://worldtimeapi.org/api/timezone/#{area}/#{location}"
    response = HTTParty.get(url)
    if response.success?
        return JSON.parse(response.body)
    else
        puts "Error: #{response.code} - #{response.message}"
        return nil
    end
end

def display_current_time(area, location, current_time)
    puts "The current time in #{area}/#{location} is #{current_time['datetime']}"
end

area = 'Europe'
location = 'London'
current_time_data = get_current_time(area, location)

if current_time_data
    display_current_time(area, location, current_time_data)
end
