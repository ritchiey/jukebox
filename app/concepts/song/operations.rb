class Song < ApplicationRecord

  class Create < Trailblazer::Operation
    include Model
    model Song, :create

    contract do
      property :name
      property :guid
      property :artist

      validation :default do
        required(:name).filled
        required(:guid).filled
      end

      validation :unique, if: :default do
        configure do
          config.messages_file = 'config/error_messages.yml'
          def unique?(value)
            !Song.where(guid: value).exists?
          end
        end
        required(:guid, &:unique?)
      end
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
