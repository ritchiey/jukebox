require 'rails_helper'

describe Song::Create do
  let(:artist) { Artist::Create.(artist: {name: 'Bob'}).model }

  it "creates an song" do
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

  it "requires a name" do
    expect{
      Song::Create.(song: {
        guid: '123',
        artist_id: artist.id
      }).model
    }.to raise_error(Trailblazer::Operation::InvalidContract)
  end
 
  it "requires a guid" do
    expect{
      Song::Create.(song: {
        name: "I'm Bob",
        artist_id: artist.id
      }).model
    }.to raise_error(Trailblazer::Operation::InvalidContract)
  end

  it "requires the guid to be unique" do
      Song::Create.(song: {
        name: "I'm Bob",
        guid: '123',
        artist_id: artist.id
      })
    expect{
      Song::Create.(song: {
        name: "Me Too",
        guid: '123',
        artist_id: artist.id
      })
    }.to raise_error(Trailblazer::Operation::InvalidContract)
  end


end

