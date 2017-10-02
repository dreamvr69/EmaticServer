# class Swagger::Docs::Config
#   def self.base_api_controller; ApplicationController end
# end
Swagger::Docs::Config.register_apis({
    '1.0' => {
        :api_file_path => 'public/swagger/',
        :base_path => "http://192.168.2.97:3000",
        :clean_directory => true,
        :api_extension_type => :json,
        :parent_controller => ApplicationController,
        :attributes => {
            :info => {
                'title' => 'Swagger FITCLUBS App',
            }
        }
    }
})
