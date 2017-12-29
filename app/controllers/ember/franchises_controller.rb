class Ember::FranchisesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate

  def get_vr_data
    if @current_user.has_attribute?(:franchise_id) && (BSON::ObjectId.from_string(params[:id]) == @current_user.franchise_id)
      render json:{:vr_data => Franchise.find(params[:id]).vr_data}
    else
      head 403
    end
  end

  def post_vr_data
    if @current_user.has_attribute?(:franchise_id) && (BSON::ObjectId.from_string(params[:id]) == @current_user.franchise_id)
      fr = Franchise.find(params[:id])
      fr.vr_data = params[:vr_data]
      fr.save
    else
      head 403
    end
  end

  protected
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      begin
        @current_user = User.find_by(authentication_token: token)
      rescue Mongoid::Errors::DocumentNotFound
        render status: 401
      end
    end
  end
end
