class Ember::ProjectsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  include Swagger::Docs::ImpotentMethods
  include CrudActionsMixin
  self.responder = ApplicationResponder
  respond_to  :json

  swagger_controller :projects, 'Projects Management'

  before_action :authenticate

  swagger_api :index do
    summary "Fetches all User items"
    param :header, 'Authorization', :string, :required, 'Authentication token'
    notes "This lists all the active users"
    response :ok
  end

  def index
    if @current_user.is_super_user?
      @items = Project.all
    elsif @current_user.is_franshise_admin?
      @items = Project.where(franchise_id: @current_user.franchise_id)
    else
      @items = Project.where(user_id: @current_user.id)
    end

    respond_with(paginate(@items),
                 root: 'projects',
                 each_serializer: serializer,
                 serializer: paginated? ? PaginationSerializer : nil)

  end

  def index_users
    if @current_user.can_read_owned_by_user?(params[:user_id])
      @items = Project.all user_id: params[:user_id]
      respond_with(@items,
                   root: 'projects',
                   each_serializer: serializer)
    else
      head 403
    end
  end

  def show
    @item = Project.find(params[:id])
    respond_with(@item, serializer: serializer, root: "project")
  end

  def create
    project = Project.new(params.permit(:event_name, :client_name, :company_name, :client_phone, :client_email))
    @current_user.projects << project
    project.save

    params[:visualisation_ids].each do |id|
      visualisation = Visualisation.find id
      if !visualisation.nil?
        project.visualisations << visualisation
      end
    end

    render json:{id: project.id}
  end

  def update
    #Project.update(params[:id], params.permit(:event_name, :client_name, :company_name, :client_phone, :client_email))
    pr = Project.find params[:id]
    pr.update(params.permit(:event_name, :client_name, :company_name, :client_phone, :client_email))
    pr.save

    visualisations = params[:visualisations]
    visualisations.each do |visualisation|
      cur = Visualisation.find visualisation['id']
      cur.update(visualisation.permit(:begin, :end))
    end
    render :nothing => true
  end

  def get_visualisations
    project = Project.find params[:id]
    @items = project.visualisations
    respond_with(@items,
                 root: 'visualisations',
                 each_serializer: "Ember::VisualisationSerializer".constantize)
  end

  def save
    project = Project.new(params[:project].permit(:event_name, :begin, :end, :client_name, :company_name))
    visualisation = Visualisation.new(params[:visualisation].permit(:data, :room, :begin, :end))

    project.visualisations << visualisation
    @current_user.projects << project

    visualisation.save

    render :nothing => true
  end

  def add_visualisation
    visualisation = Visualisation.new(params.permit(:data, :room, :begin, :end, :image_url, :guest_count, :arrangement_type))
    project = Project.find(params[:id])

    if visualisation.nil?
      head 404
    else
      project.visualisations << visualisation
    end

    render :nothing => true
  end

  def add_visualisation_by_id
    visualisation = Visualisation.find params[:visualisation_id]
    project = Project.find params[:project_id]

    if visualisation.nil? || project.nil
      head 404
    else
      project.visualisations << visualisation
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
