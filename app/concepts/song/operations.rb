class Song < ApplicationRecord

  class Create < Trailblazer::Operation
    include Model
    model Song, :create

    contract do
      property :name
      property :guid
    end

    def setup_model!(params)
      model.artist = Artist.find(params[:song][:artist_id])
    end

    def process(params)
      validate(params[:song]) do |form|
        form.save
      end
    end
  end

end
