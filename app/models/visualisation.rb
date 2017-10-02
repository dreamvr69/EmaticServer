class Visualisation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :data, type: String
  field :room
  field :begin, type: DateTime
  field :end, type: DateTime
  field :image_url
  field :guest_count, type: Integer
  field :arrangement_type

  #mount_uploader :image, ::Coach::PhotoUploader

  belongs_to :project, optional: true
  has_many :notes, dependent: :destroy
  belongs_to :user
end
