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
  version '0.0.1'
 
  # menu item 
  #menu :project_menu, :newissuealerts, { :controller => 'newissuealerts', :action => 'index' }, :caption => 'New Issue Alerts', :after => :activity, :param => :project_id
  menu :project_menu, :newissuealerts, { :controller => 'newissuealerts', :action => 'index' }, :caption => 'Email on New Issue', :param => :project_id
  project_module :newissuealerts do

    # permission
    # the following make all elements public
    #permission :newissuealerts, {:newissuealerts => [:index, :edit, :new]}, :public => true
    permission :view_newissuealerts, :newissuealerts => :index
    permission :edit_newissuealerts, :newissuealerts => :edit
    permission :new_newissuealerts, :newissuealerts => :new
  end
end
