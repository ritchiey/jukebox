
class Artist < ApplicationRecord

  class Create < Trailblazer::Operation
    include Model
    model Artist, :create

    contract do
      property :name
    end

    def process(params)
      validate(params) do |form|
        form.save
      end
    end
  end

end
