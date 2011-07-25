
module RedmineNewissuealerts
  module ProjectsHelperPatch
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method_chain :project_settings_tabs, :hook
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      def project_settings_tabs_with_hook
        tabs = project_settings_tabs_without_hook
        call_hook(:newissuealerts_settings_tabs, { :tabs => tabs })
        return tabs
      end
    end
  end 
end
