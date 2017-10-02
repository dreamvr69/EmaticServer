class Note
  include Mongoid::Document

  belongs_to :visualisation
  belongs_to :user

  field :body
  field :creation_date, type: DateTime
end
