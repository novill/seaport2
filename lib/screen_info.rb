require_relative '../config/global'

class ScreenInfo
  def self.get_pixel_color(*args)
    x, y = args.to_a.flatten
    pixel_command = "/usr/bin/import -silent -window root -crop 1x1+#{x}+#{y} -depth 8 txt:-"
    `#{pixel_command}`.split(' ')[-2]
  end

  def self.check_pixel_color(*args)
    raise "Bad color #{args[-1]}" unless args[-1] =~ /#[0-9A-F]{6}/
    similar_color?(args[-1], get_pixel_color(args[0..-2]))
  end

  private
  
  def self.similar_color?(color1, color2)
    rgb16 = [[color1[1..2], color2[1..2]],
      [color1[3..4], color2[3..4]],
      [color1[5..6], color2[5..6]]]
    rgb16.all? { |s2color| similar_simple_color?(s2color) }
  end

  def self.similar_simple_color?(s2color)
    (s2color[0].to_i(16) - s2color[1].to_i(16)).abs < Global[:max_color_delta]
  end
end
