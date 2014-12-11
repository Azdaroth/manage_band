require 'rails_helper'

describe BandSerializer do

	let(:band) { build_stubbed(:band, name: "name", id: "10") }

	subject { BandSerializer.new(band) }

	it "returns valid json" do
		result = {
			"band" => {
				"id" => 10,
				"name" => "name"
			}
		}
		expect(result).to eq JSON.parse(subject.to_json)
	end

end