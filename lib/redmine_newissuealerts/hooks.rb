module RedmineNewissuealerts
  class Hooks  < Redmine::Hook::ViewListener
    def newissuealerts_settings_tabs(context = {})
      @project = context[:project]
      if @project.module_enabled?('newissuealerts') and User.current.allowed_to?({:controller => :newissuealerts, :action => :index}, context[:project])
        context[:tabs].push({ :name    => 'newissuealerts',
                              :action  => :view_newissuealerts,
                              :partial => 'projects/settings/newissuealerts',
                              :label => :newissuealert_menuitem})
      end
    end 
  end
end
