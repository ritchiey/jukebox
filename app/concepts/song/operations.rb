class Song < ApplicationRecord

  class Create < Trailblazer::Operation
    include Model
    model Song, :create

    contract do
      property :name
      property :guid
      property :artist
    end

    def setup_model!(params)
      model.artist = Artist.where(id:(params[:song]||{})[:artist_id]).first
    end

    def process(params)
      validate(params[:song]) do |form|
        form.save
      end
    end
  end

end
