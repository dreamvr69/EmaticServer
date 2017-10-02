class Ember::NotesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  include CrudActionsMixin
  self.responder = ApplicationResponder
  respond_to  :json

  def namespace
    'Ember::'
  end

  def destroy
    Note.where(id: params[:id]).destroy
  end

  def show
    @item = Note.find(params[:id])
    respond_with(@item, serializer: serializer, root: "note")
  end
end
