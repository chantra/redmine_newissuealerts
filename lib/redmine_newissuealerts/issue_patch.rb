
module RedmineNewissuealerts
  # Patches Redmine's IssuesController dynamically
  module IssuePatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      # Same as typing in the class 
      base.class_eval do 
        unloadable # Send unloadable so it will not be unloaded in development

        after_create :newissue_created
      
        # Add visible to Redmine
        unless respond_to?(:visible)
          named_scope :visible, lambda {|*args| { :include => :project,
                                                  :conditions => Project.allowed_to_condition(args.first || User.current, :view_issues) } }
        end
      end 

    end
  end

  module ClassMethods
  end

  module InstanceMethods
    def newissue_created
      # Redmine 1.2+ return if issue is private
      if self.respond_to?("is_private")
        if self.is_private?
          # TODO debug logs
          return ''
        end
      end
      project=Project.find(self.project_id)
      subject = self.subject
      tracker = Tracker.find(self.tracker_id)
      aut = User.find_by_id(self.author_id)
      if aut
        author = aut.login
      else
        author = 'Anonymous'
      end
    
      newissuealerts = Newissuealert.find(:all, :conditions => { :project_id => project.id } )
      newissuealerts.each do |n|
        if n.enabled
          n.mail_addresses.split(",").each do |e|
            NewissuealertsMailer.newissuealert(e, self, n).deliver
          end
        end
      end 
      return ''
    end

  end
end
