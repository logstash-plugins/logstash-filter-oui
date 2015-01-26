require "logstash/devutils/rspec/spec_helper"
require "logstash/filters/oui"

describe LogStash::Filters::Oui do
  describe "Set to OUI" do
    config <<-CONFIG
      filter {
        tld {
        }
      }
    CONFIG

    sample("message" => "") do
      insist { subject["message"] } == ""
    end
  end
end
