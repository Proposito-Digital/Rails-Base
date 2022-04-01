# frozen_string_literal: true
module SortableHelper
	def sort_link(column, title = nil)
	  	title ||= column.titleize
	    icon = params[:sort_direction] == "asc" ?  "bi bi-chevron-down" :  "bi bi-chevron-up"
	    sort_direction = params[:sort_direction] == "asc" ? "desc" : "asc"
	    show_icon = params[:sort_column] == column ? "<span class='#{icon}'></span>" : ''
	    link_to "#{title} #{show_icon}".html_safe, params.slice(:term, :page).merge(sort_direction: sort_direction, sort_column: column ).permit!
	end
end
