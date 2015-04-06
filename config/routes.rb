RedmineApp::Application.routes.draw do
	match 'projects/:project_id/newissuealerts/:action', :controller => 'newissuealerts'
	match 'projects/:project_id/newissuealerts/:action/:id', :controller => 'newissuealerts'
end
