require "logstash/devutils/rspec/spec_helper"
require "logstash/filters/oui"

describe LogStash::Filters::Oui do
  describe "Set to OUI" do
    config <<-CONFIG
      filter {
        oui {
        }
      }
    CONFIG

    sample("message" => "00:50:56") do
      insist { subject["oui"]["id"] } == 20566
      insist { subject["oui"]["organization"] } == "VMware, Inc."
    end
  end
end
