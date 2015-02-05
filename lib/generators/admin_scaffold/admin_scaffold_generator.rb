class AdminScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  hook_for :scaffold, in: :rails, default: true do |instance, generator|
    attributes = instance.name.camelize.constantize.columns
                  .reject{|c| %w[id updated_at created_at].include? c.name }
                  .map!{|c| "#{c.name}:#{c.type}"}
    arguments = ["admin/#{instance.name}"] + (instance.args.presence || attributes)
    instance.invoke generator, arguments, force: true, test_framework: false, migration: false, parent: instance.name
  end

  def inherit_admin_controller
    gsub_file "app/controllers/admin/#{plural_name}_controller.rb", 'ApplicationController', 'AdminController'
  end
end
