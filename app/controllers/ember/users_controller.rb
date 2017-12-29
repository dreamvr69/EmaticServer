class Ember::UsersController < ApplicationController

  skip_before_filter :verify_authenticity_token
  include CrudActionsMixin
  self.responder = ApplicationResponder
  respond_to  :json

  def namespace
    'Ember::'
  end

  #before_action :authenticate_user!, except: :authenticate
  before_action :authenticate_from_token, except: :authenticate

  # def authenticate
  #   user = User.find_by(email: params[:user][:email])
  #   if user.nil?
  #     head 404
  #   else
  #     if user.valid_password?(params[:user][:password])
  #       if user.has_role?(:client)
  #         head 401
  #       else
  #         if user.auth_date.nil?
  #           user.auth_date = DateTime.now
  #           user.save
  #         end
  #         data = {
  #             token: user.authentication_token,
  #             user_id: user.id.to_s,
  #             email: user.email
  #         }
  #         render json: data, status: :ok
  #       end
  #     else
  #       head 401
  #     end
  #   end
  # end

  def authenticate
    user = User.find_by(email: params[:user][:email])

    if user.nil?
      head 401
    else
      if user.valid_password?(params[:user][:password])
              data = {
                  token: user.authentication_token,
                  user_id: user.id.to_s,
                  email: user.email,
                  name: user.name,
                  image_url: "http://www.imagespng.com/Data/Logo/Colorful_Parrot.png"
              }
              render json: data, status: :ok
      else
        head 401
      end
    end

  end

  def show
    if can_manipulate_user params[:id]
      @item = User.find(params[:id])
      respond_with(@item, serializer: serializer, root: "users")
    else
      head 403
    end
  end

  def delete
    if can_manipulate_user params[:id]
      @item = User.delete(params[:id])
    else
      head 403
    end
  end

  def update
    if can_manipulate_user params[:id]
      user = User.find params[:id]
      user.update(params[:user].permit(:email,:password,:name,:mobile))
      if @current_user.user_role == 'manager' && params[:user][:user_role]!='manager'
        head 403
      elsif @current_user.user_role == 'franchise_administrator' && !["manager","franchise_administrator"].include?(user_role)
        head 403
      else
        user.user_role = params[:user_role]
        user.save
      end
    else
      head 403
    end
  end

  def create
    puts @current_user.user_role
    if @current_user.user_role == 'manager'
      head 403
    elsif @current_user.user_role == 'franchise_administrator'
      user = User.new(params[:user].permit(:email,:password,:name,:mobile))
      user_role = params[:user][:user_role]
      if !user_role.empty? && !["manager","franchise_administrator"].include?(user_role)
        head 403
      else
        user.user_role = user_role
        franchise = @current_user.franchise
        franchise.users << user
        puts user.save
        render json:{user:{id: user.id}}
      end
    end
  end

  def can_manipulate_user(user_id)
    if @current_user.user_role == 'super_user'
      return true
    elsif @current_user.user_role == 'franchise_administrator' && User.find(params.id).franchise_id == @current_user.franchise_id
      return true
    elsif BSON::ObjectId.from_string(params[:id]) == @current_user.id
      return true
    else
      return false
    end
  end

  # def quick_load
  #   respond_with(Visualisation.find(@current_user.quick_save_id), serializer: 'Ember::VisualisationSerializer'.constantize, root: 'visualisation')
  # end

  protected
  def authenticate_from_token
    authenticate_or_request_with_http_token do |token, options|
      begin
        @current_user = User.find_by(authentication_token: token)
        return @current_user.id = params[:id]
      rescue Mongoid::Errors::DocumentNotFound
        render status: 401
      end
    end
  end

  def show_user_by_id(id)

  end

end
