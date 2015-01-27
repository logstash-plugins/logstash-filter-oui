require "spec_helper"
require "logstash/filters/oui"

describe LogStash::Filters::Oui do
  describe "Set to OUI" do
    let(:config) do <<-CONFIG
      filter {
        oui {
        }
      }
    CONFIG
    end

    sample("message" => "00:50:56") do
      expect(subject["oui"]).to include( "id" => 20566)
      expect(subject["oui"]["organization"]).to eq("VMware, Inc.")
    end
  end
end
