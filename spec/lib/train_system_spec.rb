require './lib/underground_system'

RSpec.describe UndergroundSystem do
  it 'works' do
    tube = UndergroundSystem.new
    tube.check_in(45, 'Layton', 3)
    tube.check_in(32, 'Paradise', 8)
    tube.check_out(45, 'Waterloo', 15)
    tube.check_out(32, 'Cambridge', 22)
    ans = tube.get_average_time('Paradise', 'Cambridge')
    expect(ans).to eq 14
  end
end
