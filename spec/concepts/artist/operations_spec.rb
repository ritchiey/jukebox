require 'rails_helper'

describe Artist::Create do

  it "creates an artist" do
    expect{
      artist = Artist::Create.(artist: {name: 'Bob'}).model
      artist.reload
      expect(artist.name).to eq('Bob')
    }.to change(Artist, :count).by(1)
  end

end
