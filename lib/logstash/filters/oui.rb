# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

# Logstash filter to parse OUI data from MAC addresses
class LogStash::Filters::Oui < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   example {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "oui"

  # The source field to parse
  config :source, :validate => :string, :default => "message"

  # The target field to place all the data
  config :target, :validate => :string, :default => "oui"

  public
  def register
    require 'oui'
  end # def register

  public
  def filter(event)

    oui = OUI.find event.get(@source)
    if ! oui.nil?
      event.set(@target, Hash.new)
      oui.each do |key, value|
        event.set("[#{@target}][#{key.to_s}]", value)
      end

      # filter_matched should go in the last line of our successful code
      filter_matched(event)
    end
  end # def filter
end # class LogStash::Filters::Oui
