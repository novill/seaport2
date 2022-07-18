require_relative 'config/global'
require_relative 'config/map'

require_relative 'lib/mouse'
require_relative 'lib/screen_info'
require_relative 'lib/waiter'

def main_circle
  # wait_for_global_task_ready
  wait_for(Map, [:quest, :ready_sign], :active)

  # click_global_task
  Mouse.click_to(Map, [:quest, :ready_sign])

  # click_claim
  Mouse.click_to(Map, [:quest, :window, :claim_btn])

  # click_collect_all
  Mouse.click_to(Map, [:quest, :window, :collect_all_ships_btn])

  # click_collect_all
  Mouse.click_to(Map, [:quest, :window, :collect_ok_btn])

  while
    !ScreenInfo.check_pixel_color(Map[:quest, :window, :task_full_sign], :active) or
    !ScreenInfo.check_pixel_color(Map[:quest, :window, :task_bar], :full) do
    # click_top_ship
    Mouse.click_to(Map, [:quest, :window, :top_ship])
    #   click_send_top_ship
    Mouse.click_to(Map, [:quest, :window, :sail_btn])
    sleep(1)
  end
  # click_close_window_button
  Mouse.click_to(Map, [:quest, :window, :close_btn])

  Mouse.click_to(Global, [:second_tab])
  28.times do |i|
    puts "wait #{i} minutes"
    sleep(60)
  end
  Mouse.click_to(Global, [:first_tab])
end



