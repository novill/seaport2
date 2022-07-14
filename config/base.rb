require 'yaml'
class Base

  def self.[](*args)
    args.map!(&:to_s)
    full_config.dig(*args)
  end

  def self.full_config
    @settings || reload_config
  end

  def self.yaml_file_name
    raise 'Undefined'
  end

  def self.reload_config
    @settings = YAML.load(File.read(yaml_file_name))
  end
end

