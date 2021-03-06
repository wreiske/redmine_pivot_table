Redmine::Plugin.register :redmine_pivot_table do
  name 'Redmine Pivot Table plugin'
  author 'Daiju Kito'
  description 'Pivot table plugin for Redmine using pivottable.js'
  version '0.0.2'
  url 'http://example.com/path/to/plugin'

  project_module :pivottables do
    permission :pivottables, {:pivottables => [:index]}, :public => true
  end

  menu :project_menu, :pivottables, { :controller => 'pivottables', :action => 'index' }, :after => :activity, :param => :project_id

end
