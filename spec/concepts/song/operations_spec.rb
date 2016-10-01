require 'rails_helper'

describe Song::Create do

  it "creates an song" do
    artist = Artist::Create.(artist: {name: 'Bob'}).model
    expect{
      song = Song::Create.(song: {
        name: "I'm Bob",
        guid: '123',
        artist_id: artist.id
      }).model
      song.reload
      expect(song.name).to eq("I'm Bob")
      expect(song.guid).to eq("123")
      expect(song.artist).to eq(artist)
    }.to change(Song, :count).by(1)
  end

end
