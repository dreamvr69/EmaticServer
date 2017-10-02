class Ember::ProjectSerializer < ActiveModel::Serializer
  attributes :id, :author_name, :rooms, :visualisation_ids, :begin, :end,
  :event_name, :client_name, :company_name, :client_phone, :client_email, :state

  def author_name
    if !User.find object.user_id.nil?
      User.find(object.user_id).name
    end
  end

  def rooms
    set = Set.new
    object.visualisations.each {|v| set.add(v.room)}
    return set
  end

  def begin
    return object.begin
  end

  def end
    return object.end
  end

end
