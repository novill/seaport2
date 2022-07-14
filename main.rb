require_relative 'config/global'
require_relative 'config/map'

require_relative 'lib/mouse'
require_relative 'lib/screen_info'

def main_circle
  wait_for_global_task_ready
  click_global_task
  click_cliam
  click_collect_all
  until (task_full? and top_ship_free?)
    click_top_ship
    click_send_top_ship
  end
  click_close_window_button
end

# require_relative 'main'

# loop do
#   main_circle
# end


