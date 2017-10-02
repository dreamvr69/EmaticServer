class Ember::VisualisationsController < ApplicationController
  before_action :authenticate

  skip_before_filter :verify_authenticity_token
  include CrudActionsMixin
  self.responder = ApplicationResponder
  respond_to  :json

  def namespace
    'Ember::'
  end

  def show
    @item = Visualisation.find(params[:id])
    respond_with(@item, serializer: serializer, root: "visualisation")
  end

  def create
    visualisation = Visualisation.new(params.permit(:data, :room, :begin, :end, :image_url, :guest_count, :arrangement_type))

    @current_user.visualisations << visualisation
    visualisation.save

    render json:{id: visualisation.id}
  end

  def get_notes
    visualisation = Visualisation.find params[:id]
    @items = visualisation.notes
    respond_with(@items,
                 root: 'notes',
                 each_serializer: "Ember::NoteSerializer".constantize)
  end

  def index
    # if @current_user.is_super_user?
    #   @items = Visualisation.all
    # elsif @current_user.is_franshise_admin?
    #   @items = Visualisation.where(franchise_id: @current_user.franchise_id)
    # else
    #   @items = Visualisation.where(user_id: @current_user.id)
    # end

    @items = Visualisation.all
    respond_with(paginate(@items),
                 root: 'visualisation',
                 each_serializer: serializer)
  end

  def get_last_visualisation
    @item = @current_user.visualisations.max_by{|e|e.updated_at}
    respond_with(@item, serializer: 'Ember::VisualisationSerializer'.constantize, root: 'visualisation')
  end

  def destroy
    Visualisation.where(id: params[:id]).destroy
  end

  def update
    visualisation = Visualisation.find(params[:id])
    visualisation.update(params[:visualisation].permit(:begin, :data, :end, :room, :image_url))
    visualisation.save
  end

  def add_note
    note = Note.new(params.permit(:body, :creation_date))
    visualisation = Visualisation.find params[:id]
    note.save
    @current_user.notes << note
    visualisation.notes << note

    render json:{id: note.id, author_name: @current_user.name}
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
