class Ember::ImagesController < ApplicationController

  skip_before_filter :verify_authenticity_token

   def create
     image = Image.create(params.permit(:image))
     render json:{image_url: Rails.application.config.host + image.image.url}
     image.save
    #  attached_filenames = []
     #
    #  i = 1
    #  while params.has_key?(("file%d". % [i]).to_sym) do
    #    puts "Request body"
    #    #puts request.body.to_a
    #    file = params[("file%d". % [i]).to_sym]
    #    #puts params
    #    #puts file.content_type
    #    file_type = file.original_filename.split('.')[1]
    #    f = File.open('file%d.%s' % [i, file_type],'wb+')
    #    attached_filenames.append('file%d.%s' % [i, file_type])
    #    f.write(file.read)
    #    f.close
    #    puts "Close file"
    #    i+=1
    #  end

    # file = params[:file]
    # file_type = file.original_filename.split('.')[1]
    # f = File.open('file%d.%s' % [i, file_type],'wb+')
    # attached_filenames.append('file%d.%s' % [i, file_type])
    # f.write(file.read)
    # f.close


    #  data_hash = JSON.parse(params[:json_data].read)
    #  puts data_hash
     #
    #  send_email(attached_filenames)
    #  render :nothing => true
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
