ActionController::Routing::Routes.draw do |map|
	map.connect 'projects/:project_id/newissuealerts/:action', :controller => 'newissuealerts'
	map.connect 'projects/:project_id/newissuealerts/:action/:id', :controller => 'newissuealerts'
end
