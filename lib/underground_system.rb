class User
  def initialize(id)
    @id = id
    @routes = []
    @current_route = {
      in_station: nil,
      in_time: nil,
      out_station: nil,
      out_time: nil,
    }
  end

  def check_in(station_name, time)
    current_route[:in_station] = station_name
    current_route[:in_time] = time
  end

  def check_out(station_name, time)
    current_route[:out_station] = station_name
    current_route[:out_time] = time

    build_route
  end

  private

  def build_route
    @routes << current_route
    @current_route = {
      in_station: nil,
      in_time: nil,
      out_station: nil,
      out_time: nil,
    }
  end
end

class UndergroundSystem
  attr_reader :users, :route_intervals, :active_routes

  def initialize
    @users = {}
    @route_intervals = {}
    @active_routes = {}
  end

  def check_in(user_id, station_name, time)
    active_routes[user_id] = { name: station_name, time: time }
  end

  def check_out(user_id, station_name, time)
    in_station = active_routes.delete(user_id)
    build_route(in_station[:name], in_station[:time], station_name, time)
  end

  def get_average_time(start_station, end_station)
    key = "#{start_station}-#{end_station}"
    intervals = route_intervals[key]
    intervals.sum { |interval| interval[1] - interval[0] } / intervals.size
  end

  private

  def build_route(in_station, in_time, out_station, out_time)
    key = "#{in_station}-#{out_station}"
    route_intervals[key] ||= []
    route_intervals[key] << [in_time, out_time]
  end

  def user(id)
    @users[id] ||= User.new(id)
  end

end
