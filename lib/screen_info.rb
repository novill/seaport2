require_relative '../config/global'

class ScreenInfo
  def self.get_pixel_color(*args)
    if args[0].is_a?(Hash)
      x, y = args[0].values_at('x', 'y')
    else
      x, y = args.to_a.flatten
    end
    pixel_command = "/usr/bin/import -silent -window root -crop 1x1+#{x}+#{y} -depth 8 txt:-"
    `#{pixel_command}`.split(' ')[-2]
  end

  def self.check_pixel_color(*args)
    # puts args.to_s
    if args[0].is_a?(Hash)
      x, y = args[0].values_at('x', 'y')
    else
      x, y = args.to_a.flatten
    end

    state_colors = (args[-1].is_a?(String) or args[-1].is_a?(Array)) ? args[-1] :args[0]["#{args[-1]}_color"]
    current_color = get_pixel_color(x, y)

    res = [state_colors].flatten.any? do |state_color|
      raise "Bad color #{state_color}" unless state_color =~ /#[0-9A-F]{6}/
      similar_color?(state_color, current_color)
    end

    puts "Expected #{state_colors} get #{current_color} on #{x} #{y}" unless res
    res
  end

  private

  def self.similar_color?(color1, color2)
    raise "Bad color #{color1}" unless color1 =~ /#[0-9A-F]{6}/
    raise "Bad color #{color2}" unless color2 =~ /#[0-9A-F]{6}/

    rgb16 = [[color1[1..2], color2[1..2]],
      [color1[3..4], color2[3..4]],
      [color1[5..6], color2[5..6]]]
    rgb16.all? { |s2color| similar_simple_color?(s2color) }
  end

  def self.similar_simple_color?(s2color)
    (s2color[0].to_i(16) - s2color[1].to_i(16)).abs < Global[:max_color_delta]
  end
end
