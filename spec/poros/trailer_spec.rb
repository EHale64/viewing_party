require 'rails_helper'

RSpec.describe Trailer do
  it "exists" do
    attributes = {
      "id": "58fa2a55c3a3687c7300cdc6",
      "iso_639_1": "en",
      "iso_3166_1": "US",
      "key": "9O1Iy9od7-A",
      "name": "The Godfather Part II - Trailer",
      "site": "YouTube",
      "size": 720,
      "type": "Trailer"
    }

    trailer = Trailer.new(attributes)

    expect(trailer).to be_a(Trailer)
    expect(trailer.key).to eq(attributes[:key])
  end
end
