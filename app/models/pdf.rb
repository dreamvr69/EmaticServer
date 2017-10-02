require 'prawn'
class Pdf
  def self.generate_pdf(user, event_name, place, datetime, first_angle_image, second_angle_image,
    third_angle_image, first_additional_image, second_additional_image, third_additional_image, franchise_logo,
     creation_date, franchise_name)
    #Переменные, отвечающие за размеры в PDF
    page_height = 600
    page_width = 900

    logo_height = 28
    logo_width = 120

    franchise_logo_width = 175
    franchise_logo_height = 145

    font_size_small = 16

    #event_name = "Bosch family day 2017"
    #place = "Crystall ball room"
    #datetime = "20.07.2017 - 23.07.2017"

    top_margin_of_label = 10

    label_image = "./pdf/label.png"

    #first_angle_image = "./img.png"
    #second_angle_image = "./img.png"
    #third_angle_image = "./img.png"

    #first_additional_image = "./img.png"
    #second_additional_image = "./img.png"
    #third_additional_image = "./img.png"

    #franchise_logo = "./franchise_logo.png"

    first_additional_service_image = "./pdf/first_service.jpg"
    second_additional_service_image = "./pdf/second_service.jpg"

    black_rectangle_height = 65
    bottom_black_rectangle_height = 30

    #creation_date = "17.07.2017"

    #franchise_name = 'Ritz-Carlton Moscow'
    puts "GENERATE"
    relative_path = "./pdf/#{user.id}.pdf"
    Prawn::Document.generate(relative_path, :background => "./pdf/back.jpg", :page_size => [page_height, page_width],
     :page_layout => :landscape, :margin=>[0,0,0,0]) do

    	font_families.update("Arial" => {
    	    :normal => "./pdf/helvetica.ttf",
    	  })

      font_families.update("Helvetica" => {
            :normal => "./pdf/roboto_light.ttf",
          })

    	font "Arial"

      logo_x = (bounds.right/2) - (logo_width/2)
      logo_y = bounds.top - top_margin_of_label

    	# 1 страница

      if !franchise_logo.nil?
        image franchise_logo,
        :width => franchise_logo_width,
        :height => franchise_logo_height,
        :position=>:center,
        :at => [logo_x - 25,  bounds.top - 115]
      end


      text event_name, :align => :center, :valign => :center, size: 36, color: "FFFFFF", kerning: true
    	move_down 40

    	text place, :align => :center, :valign => :center, color: "FFFFFF",size: 30
    	move_down 40

    	text datetime, :align => :center, :valign => :center, color: "FFFFFF", size: 18


      move_down 375
      text creation_date, :align => :center, :valign => :center, size: 14, color: "FFFFFF", kerning: true

    	#Картинка наверху каждой pdf\
    	#150 - половина ширины картинки, 15 - отступ от верха


    	image label_image, :width => logo_width, :height => logo_height, :at => [logo_x, logo_y]

    	start_new_page

    	#Картинка наверху каждой pdf\
    	#150 - половина ширины картинки, 20 - отступ от верха

    	# 2 страница

    	image first_angle_image, :width => page_width, :height => page_height, :position => :left, :vposition => :top, :at => [0,page_height]
      fill_color "000000"
      transparent(0.8) do
        fill_rectangle [bounds.left, bounds.top], page_width, black_rectangle_height
      end

      transparent(0.8) do
        fill_rectangle [bounds.left, bounds.bottom + bottom_black_rectangle_height], page_width, bottom_black_rectangle_height
      end

      move_down 10
      text event_name, :align => :center, :valign => :top, size: 26, color: "FFFFFF", kerning: true
      move_down 5
      text place, color: "FFFFFF", :align => :center, :valign => :top, size: 20
      move_down page_height - 81
      if !franchise_name.nil?
        text franchise_name + " | "+creation_date, color: "FFFFFF", :align => :center, size: 14
      end

    	image label_image, :width => logo_width, :height => logo_height, :at => [bounds.right - 130, bounds.top]

    	start_new_page

    	# 3 страница
    	image second_angle_image, :width => page_width, :height => page_height, :position => :left, :vposition => :top, :at => [0,page_height]
      fill_color "000000"
      transparent(0.8) do
        fill_rectangle [bounds.left, bounds.top], page_width, black_rectangle_height
      end

      transparent(0.8) do
        fill_rectangle [bounds.left, bounds.bottom + bottom_black_rectangle_height], page_width, bottom_black_rectangle_height
      end

      move_down 10
      text event_name, :align => :center, :valign => :top, size: 26, color: "FFFFFF", kerning: true
      move_down 5
      text place, color: "FFFFFF", :align => :center, :valign => :top, size: 20
      move_down page_height - 81
      if !franchise_name.nil?
        text franchise_name + " | "+creation_date, color: "FFFFFF", :align => :center, size: 14
      end

      image label_image, :width => logo_width, :height => logo_height, :at => [bounds.right - 130, bounds.top]

    	start_new_page

    	# 4 страница

    	image third_angle_image, :width => page_width, :height => page_height, :position => :left, :vposition => :top, :at => [0,page_height]

      fill_color "000000"
      transparent(0.8) do
        fill_rectangle [bounds.left, bounds.top], page_width, black_rectangle_height
      end

      transparent(0.8) do
        fill_rectangle [bounds.left, bounds.bottom + bottom_black_rectangle_height], page_width, bottom_black_rectangle_height
      end

      move_down 10
      text event_name, :align => :center, :valign => :top, size: 26, color: "FFFFFF", kerning: true
      move_down 5
      text place, color: "FFFFFF", :align => :center, :valign => :top, size: 20
      move_down page_height - 81
      if !franchise_name.nil?
        text franchise_name + " | "+creation_date, color: "FFFFFF", :align => :center, size: 14
      end

      image label_image, :width => logo_width, :height => logo_height, :at => [bounds.right - 130, bounds.top]

    	# 5 страница
    	if !first_additional_image.nil?
        start_new_page
        image first_additional_image, :width => page_width, :height => page_height, :position => :left, :vposition => :top, :at => [0,page_height]

        fill_color "000000"
        transparent(0.8) do
          fill_rectangle [bounds.left, bounds.top], page_width, black_rectangle_height
        end

        transparent(0.8) do
          fill_rectangle [bounds.left, bounds.bottom + bottom_black_rectangle_height], page_width, bottom_black_rectangle_height
        end

        move_down 10
        text event_name, :align => :center, :valign => :top, size: 26, color: "FFFFFF", kerning: true
        move_down 5
        text place, color: "FFFFFF", :align => :center, :valign => :top, size: 20
        move_down page_height - 81
        if !franchise_name.nil?
          text franchise_name + " | "+creation_date, color: "FFFFFF", :align => :center, size: 14
        end

        image label_image, :width => logo_width, :height => logo_height, :at => [bounds.right - 130, bounds.top]

    	end

    	# 6 страница

    	if !second_additional_image.nil?
        start_new_page
        image second_additional_image, :width => page_width, :height => page_height, :position => :left, :vposition => :top, :at => [0,page_height]

        fill_color "000000"
        transparent(0.8) do
          fill_rectangle [bounds.left, bounds.top], page_width, black_rectangle_height
        end

        transparent(0.8) do
          fill_rectangle [bounds.left, bounds.bottom + bottom_black_rectangle_height], page_width, bottom_black_rectangle_height
        end

        move_down 10
        text event_name, :align => :center, :valign => :top, size: 26, color: "FFFFFF", kerning: true
        move_down 5
        text place, color: "FFFFFF", :align => :center, :valign => :top, size: 20
        move_down page_height - 81
        if !franchise_name.nil?
          text franchise_name + " | "+creation_date, color: "FFFFFF", :align => :center, size: 14
        end

        image label_image, :width => logo_width, :height => logo_height, :at => [bounds.right - 130, bounds.top]

    	end
    	#7 страница

    	if !third_additional_image.nil?
        start_new_page
        image third_additional_image, :width => page_width, :height => page_height, :position => :left, :vposition => :top, :at => [0,page_height]

        fill_color "000000"
        transparent(0.8) do
          fill_rectangle [bounds.left, bounds.top], page_width, black_rectangle_height
        end

        transparent(0.8) do
          fill_rectangle [bounds.left, bounds.bottom + bottom_black_rectangle_height], page_width, bottom_black_rectangle_height
        end

        move_down 10
        text event_name, :align => :center, :valign => :top, size: 26, color: "FFFFFF", kerning: true
        move_down 5
        text place, color: "FFFFFF", :align => :center, :valign => :top, size: 20
        move_down page_height - 81
        if !franchise_name.nil?
          text franchise_name + " | "+creation_date, color: "FFFFFF", :align => :center, size: 14
        end

        image label_image, :width => logo_width, :height => logo_height, :at => [bounds.right - 130, bounds.top]

    	 end
       #9 страница
      	start_new_page
        image label_image, :width => logo_width, :height => logo_height, :at => [bounds.right - 130, bounds.top]
        text "Добавь красок в проект!", :align => :center, :valign => :center, size: 28, color: "FFFFFF", kerning: true

        image "./pdf/down.png", :width => 55, :height => 25, :at => [logo_x + 35, bounds.bottom + 80]

        start_new_page

    	 #10 страница

      	image first_additional_service_image, :width => page_width, :height => page_height, :position => :left, :vposition => :top, :at => [0,page_height]

      	fill_color "000000"
      	transparent(0.6) do
      		fill_rectangle [bounds.left, bounds.bottom + 150], page_width, 150

    	  end


      	fill_color "FFFFFF"

      	fill_color "FFFFFF"
      	text_box "7 990 ", size: 32,  at: [bounds.left + 60, bounds.bottom + 90],  width: 300, leading: 5, align: :center

        #text_box "\u2713", size: 32,  at: [bounds.right - 565, bounds.bottom + 80],  width: 300, leading: 5, align: :center
        font "Helvetica"
        text_box "₽", size: 32,  at: [120, bounds.bottom + 90],  width: 300, leading: 5, align: :center
        font "Arial"
        text_box "*", size: 26,  at: [135, bounds.bottom + 90],  width: 300, leading: 5, align: :center

      	text_box "Сделаем эксклюзивную рассадку!
      	Расставим любое оборудование!
      	Добавим планируемые декорации!
      	Нанесем требуемый брендинг!", size: 14,  at: [bounds.right - 290, bounds.bottom + 140],  width: 300, align: :left, leading: 20

        image "./pdf/galochka.png", :width => 22, :height => 22, at: [bounds.right - 320, bounds.bottom + 145]
        image "./pdf/galochka.png", :width => 22, :height => 22, at: [bounds.right - 320, bounds.bottom + 112]
        image "./pdf/galochka.png", :width => 22, :height => 22, at: [bounds.right - 320, bounds.bottom + 78]
        image "./pdf/galochka.png", :width => 22, :height => 22, at: [bounds.right - 320, bounds.bottom + 45]

      	stroke_color "FFFFFF"
      	line [bounds.right - page_width/2, bounds.bottom + 15], [bounds.right - page_width/2, bounds.bottom + 150]
        line [bounds.left, bounds.bottom + 15], [bounds.right, bounds.bottom + 15]
      	stroke

        text_box "без НДС 18%. Более подробная информация размещена на официальном сайте: ",
        size: 10,  at: [bounds.right - 520, bounds.bottom + 11],  width: 500, leading: 5, align: :center

        formatted_text_box([{:text => 'ematicvr.com', :link => 'http://ematicvr.com/'}],size: 10,  at: [bounds.right - 103, bounds.bottom + 11],  width: 100, leading: 5, align: :center)

      	start_new_page

    	#11 страница

      image second_additional_service_image, :width => page_width, :height => page_height, :position => :left, :vposition => :top, :at => [0,page_height]

    	fill_color "000000"
      transparent(0.6) do
    		fill_rectangle [bounds.left, bounds.bottom + 150], page_width, 150

    	end


    	fill_color "FFFFFF"
      text_box "14 990", size: 32,  at: [70, bounds.bottom + 100], inline_format: true

      font "Helvetica"
      text_box "₽", size: 32,  at: [38, bounds.bottom + 100],  width: 300, leading: 5, align: :center
      font "Arial"
      text_box "*", size: 26,  at: [53, bounds.bottom + 100],  width: 300, leading: 5, align: :center

    	fill_color "FFFFFF"
    	text_box "Добавим подвесные конструкции!
      Воссоздадим натуральное освещение!
      Рассадим гостей по местам
      Добавим флористические композиции", size: 14,  at: [330, bounds.bottom + 130],  width: 300, leading: 15, align: :left

      text_box "Сделаем эксклюзивную рассадку!
      Расставим любое оборудование!
      Добавим планируемые декорации!
      Нанесем требуемый брендинг!", size: 14,  at: [650, bounds.bottom + 130],  width: 300, leading: 15, align: :left


      image "./pdf/galochka.png", :width => 22, :height => 22, at: [300, bounds.bottom + 135]
      image "./pdf/galochka.png", :width => 22, :height => 22, at: [300, bounds.bottom + 107]
      image "./pdf/galochka.png", :width => 22, :height => 22, at: [300, bounds.bottom + 78]
      image "./pdf/galochka.png", :width => 22, :height => 22, at: [300, bounds.bottom + 48]

      image "./pdf/galochka.png", :width => 22, :height => 22, at: [620, bounds.bottom + 135]
      image "./pdf/galochka.png", :width => 22, :height => 22, at: [620, bounds.bottom + 107]
      image "./pdf/galochka.png", :width => 22, :height => 22, at: [620, bounds.bottom + 78]
      image "./pdf/galochka.png", :width => 22, :height => 22, at: [620, bounds.bottom + 48]

      font "Courier"

      font "Arial"
      text_box "без НДС 18%. Более подробная информация размещена на официальном сайте: ",
      size: 10,  at: [bounds.right - 520, bounds.bottom + 11],  width: 500, leading: 5, align: :center

      formatted_text_box([{:text => 'ematicvr.com', :link => 'http://ematicvr.com/'}],size: 10,  at: [bounds.right - 103, bounds.bottom + 11],  width: 100, leading: 5, align: :center)

    	stroke_color "FFFFFF"
    	line [280, bounds.bottom + 15], [280, bounds.bottom + 150]
      line [0, 15], [bounds.right, 15]
    	stroke

    end
  end
end
