require 'redmine'

# Patches to the Redmine core.
require 'dispatcher'
Dispatcher.to_prepare :redmine_newissuealerts do
  require_dependency 'issue'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  unless Issue.included_modules.include? RedmineNewissuealerts::IssuePatch
    Issue.send(:include, RedmineNewissuealerts::IssuePatch)
  end
end

Redmine::Plugin.register :redmine_newissuealerts do
  name 'Redmine Newissuealerts plugin'
  author 'Emmanuel Bretelle'
  description 'Send an email to a list of addresses when a new issue is created'
  version '0.0.2'
  author_url 'http://www.debuntu.org'
  url 'http://redmine.debuntu.org/projects/redmine-newissuealerts'
  
  # This plugin adds a project module
  # It can be enabled/disabled at project level (Project settings -> Modules)
  project_module :newissuealerts do
    # These permissions has to be explicitly given
    # They will be listed on the permissions screen
    # 
    # The commented line will make all elements public
    #permission :newissuealerts, {:newissuealerts => [:index, :edit, :new]}, :public => true
    permission :view_newissuealerts, :newissuealerts => :index
    permission :edit_newissuealerts, :newissuealerts => :edit
    permission :new_newissuealerts, :newissuealerts => :new
  end
  
  # A new item is added to the project menu
  #menu :project_menu, :newissuealerts, { :controller => 'newissuealerts', :action => 'index' }, :caption => 'New Issue Alerts', :after => :activity, :param => :project_id
  menu :project_menu, :newissuealerts, { :controller => 'newissuealerts', :action => 'index' }, :caption => :newissuealert_menuitem, :param => :project_id
end
