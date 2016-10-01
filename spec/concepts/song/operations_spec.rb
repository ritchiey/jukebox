require 'rails_helper'

describe Song::Create do
  let(:artist) { Artist::Create.(artist: {name: 'Bob'}).model }

  it "creates a song" do
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

describe Song::Update do
  let(:artist) { Artist::Create.(artist: {name: 'Bob'}).model }
  let(:murray) { Artist::Create.(artist: {name: 'Murray'}).model }
  let(:song) { Song::Create.(song: {
    name: "I'm Bob",
    guid: '123',
    artist_id: artist.id
  }).model
  }

  it "changes a song" do
    Song::Update.(id: song.id, song: {
      name: "I'm Murray",
      guid: '456',
      artist_id: murray.id
    })
    song.reload
    expect(song.name).to eq("I'm Murray")
    expect(song.guid).to eq("456")
    expect(song.artist).to eq(murray)
  end

  it "can keep the same guid" do
    Song::Update.(id: song.id, song: {
      name: "I'm Murray",
      artist_id: murray.id
    })
    song.reload
    expect(song.name).to eq("I'm Murray")
    expect(song.guid).to eq("123")
    expect(song.artist).to eq(murray)
  end

end
