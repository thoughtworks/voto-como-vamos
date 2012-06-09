require 'ostruct'
require 'yaml'

file       = "#{Rails.root}/config/application.yml"
yaml       = YAML.load(ERB.new(File.read(file)).result)
appconfig  = OpenStruct.new(yaml)
env_config = appconfig.send(Rails.env) rescue nil

appconfig.common.update(env_config) unless env_config.nil?

Settings = OpenStruct.new(appconfig.common)
