class Ember::VisualisationSerializer < ActiveModel::Serializer
  attributes :id, :data, :room, :begin, :end, :project_id, :image_url,
  :updated_at, :guest_count, :arrangement_type, :note_ids
end
