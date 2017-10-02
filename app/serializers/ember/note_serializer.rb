class Ember::NoteSerializer < ActiveModel::Serializer
  attributes :id, :body, :creation_date, :visualisation_id, :user_id, :author_name
  def author_name
    if !User.find object.user_id.nil?
      User.find(object.user_id).name
    end
  end
end
