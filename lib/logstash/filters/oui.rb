# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

# This example filter will replace the contents of the default 
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an example.
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
  milestone 1
  
  # The source field to parse
  config :source, :validate => :string, :default => "message"

  # The target field to place all the data
  config :target, :validate => :string, :default => "oui"

  public
  def register
    # Add instance variables 
    require 'oui'
  end # def register

  public
  def filter(event)

    oui = OUI.find event[@source]
    if ! oui.nil?
      event[@target] = Hash.new
      oui.each do |key, value|
        event[@target][key.to_s] = value
      end

      # filter_matched should go in the last line of our successful code
      filter_matched(event)
    end
  end # def filter
end # class LogStash::Filters::Example
