Redmine::Plugin.register :lookouts do
  name 'Look Out'
  author 'Mehmet Yılmaz'
  description 'This is a plugin for Redmine'
  version '0.0.1'

  project_module :lookouts do
    permission :view_lookouts, :lookouts => :index
  end

  menu :project_menu, :lookouts, { :controller => 'lookouts', :action => 'index' }, :caption => :label_plugin_plural, :after => :activity
end
