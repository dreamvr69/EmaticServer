class Ember::FranchiseSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_ids, :image_url

  def image_url
    if @object.image.file.try(:size).present?
      Rails.application.config.host + @object.image.url
    else
      nil
    end
  end
end
