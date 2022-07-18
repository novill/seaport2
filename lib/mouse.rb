require_relative '../config/global'

class Mouse
  def self.click_to(namespace, screen_ids)
    screen_object = namespace[*screen_ids]
    mouse_sleep
    move_to(screen_object)
    left_click
    mouse_sleep
  end

  def self.move_to(*args)
    if args[0].is_a?(Hash)
      x, y = args[0].values_at('x', 'y')
    else
      x, y = args.to_a.flatten
    end
    `xdotool mousemove #{x} #{y} `
  end

  def self.left_click
    `xdotool click 1`
  end

  def self.location
    `xdotool getmouselocation`.split(' ')[0..1].map { |s| s.split(':')[1].to_i }
  end

  def self.mouse_sleep
    sleep(rand(Global[:mouse_sleep, :min]...Global[:mouse_sleep, :max]))
  end
end
