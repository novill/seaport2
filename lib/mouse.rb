class Mouse
  def self.move_to(x,y = nil)
    if x.is_a?(Array)
      y = x[1]
      x = x[0]
    end
    `xdotool mousemove #{x} #{y} `
  end

  def self.left_click
    `xdotool click 1`
  end

  def self.location
    `xdotool getmouselocation`.split(' ')[0..1].map { |s| s.split(':')[1].to_i }
  end

end
