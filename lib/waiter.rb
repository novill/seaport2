require_relative '../config/global'
require_relative '../lib/screen_info'

def wait_for(namespace, screen_ids, state)
  screen_object = namespace[*screen_ids]
  state_color = screen_object["#{state}_color"]
  raise "No requested color #{state} for #{screen_object}" unless state_color

  return true if ScreenInfo.check_pixel_color(screen_object, state_color)

  waiter = Global[:waiting, :first]
  until ScreenInfo.check_pixel_color(screen_object, state_color)
    puts "#{Time.now.strftime('%H:%M:%S')} wait #{namespace.name}, #{screen_ids} for #{waiter} seconds"
    logged_sleep(waiter)
    waiter += Global[:waiting, :increase] if waiter <= Global[:waiting, :max]
  end
  false
end

def logged_sleep(seconds = 1)
  return sleep(seconds) if seconds <= 5

  seconds.to_i.times do |i|
    remain = seconds - i
    sleep 1
    puts "sleep for #{remain}" if (remain < 0) || (remain % 10).zero?
  end
end

