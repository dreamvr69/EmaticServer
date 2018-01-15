class Ember::PdfController < ApplicationController
  before_action :authenticate

  skip_before_filter :verify_authenticity_token

  def generate
    data = JSON.parse(params[:data].read)
    puts "OK"
    datetime = ""

    if @current_user.has_attribute?(:franchise_id)
      franchise_logo = @current_user.franchise.image.current_path
      franchise_name = @current_user.franchise.name
    end

    creation_date = Time.now.strftime("%d.%m.%Y")

    datetime = ""
    if(data.key?("begin") && data.key?("end"))
      datetime = "#{Date.parse(data["begin"]).strftime("%d.%m.%Y")} - #{Date.parse(data["end"]).strftime("%d.%m.%Y")}"
    end

    start = data.key?("begin") ? Date.parse(data["begin"]).strftime("%d.%m.%Y") : creation_date

    status = data.key?("status") ? data["status"] : ""

    puts "USER ID"
    puts @current_user.id
    Pdf.generate_pdf(@current_user, data["event_name"], data["place"], datetime,
    params[:file1], params[:file2], params[:file3],
    params[:file4],params[:file5],params[:file6],
    franchise_logo, creation_date, franchise_name)


    send_emails(["./pdf/#{@current_user.id}.pdf"], data["emails_list"], data["event_name"], data["place"], start, status)
    File.delete("./pdf/#{@current_user.id}.pdf")
    head 200
  end

  def send_emails(attached_filenames, emails_list, event_name, place, start, status)

    options = { :address        => "smtp.gmail.com",
          :port                 => 587,
          :domain               => 'your.host.name',
          :user_name            => Rails.application.secrets.email_login,
          :password             => Rails.application.secrets.email_password,
          :authentication       => 'plain',
          :enable_starttls_auto => true  }

    status_hash = {"booked"=>"Забронировано", "confirmed"=>"Подтверждено", "framed"=>"Оформлено"}

    subject = "3D визуализации #{event_name} (зал #{place}, #{start})"
    body = ""
    if !event_name.empty?
      body+= "Название мероприятия - #{event_name}\n"
    end
    body+= "Название зала - #{place}\n"
    body+= "Дата мероприятия: #{start}\n"
    body+= "Менеджер - #{@current_user.name}"
    if !status.empty?
      body+= "\nСтатус - #{status_hash[status]}"
    end


    Mail.defaults do
      delivery_method :smtp, options
    end

    for email in emails_list
      mail = Mail.new do
        from    Rails.application.secrets.email_login
        to      email
        subject subject
        body body
        for filename in attached_filenames
          add_file :filename => filename, :content => File.read(filename)
        end
      end

      mail.deliver!
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
