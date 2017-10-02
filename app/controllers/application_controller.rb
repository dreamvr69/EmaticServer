require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :json

  protect_from_forgery with: :exception

  # rescue_from Exception do |e|
  #   head 400
  # end

  def routing_error
    head 400
  end
end
