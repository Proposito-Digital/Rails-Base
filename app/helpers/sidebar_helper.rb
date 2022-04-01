# frozen_string_literal: true
module SidebarHelper

	def menu_active? current_menu, text = false
    if controller_name.to_sym == current_menu[:url][:controller].to_sym
      if text 
        return 'active'
      else
        return true
      end
    end
	end
	
end
