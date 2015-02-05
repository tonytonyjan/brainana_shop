module AdminScaffold
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def install
        copy_file 'admin_controller.rb', 'app/controllers/admin_controller.rb'
        template 'admin.html.erb', 'app/views/layouts/admin.html.erb'
        gsub_file 'app/assets/javascripts/application.js', /require_tree.*/, 'require_tree ./application'
        gsub_file 'app/assets/stylesheets/application.css', /require_tree.*/, 'require_tree ./application'
        copy_file 'admin.js', 'app/assets/javascripts/admin.js'
        copy_file 'admin.css', 'app/assets/stylesheets/admin.css'
        create_file 'app/assets/javascripts/admin/.keep'
        create_file 'app/assets/stylesheets/admin/.keep'
        insert_into_file 'config/initializers/assets.rb', 'Rails.application.config.assets.precompile += %w[admin.js admin.css]', after: /\Z/
      end
    end
  end
end