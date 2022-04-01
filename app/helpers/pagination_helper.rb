# frozen_string_literal: true
module PaginationHelper

	def pagination_path page
		path ="#{instances_index_path}" 
		if page 
			path += "?page=#{page}"
		end
		if params.has_key?(:term)
			path += "&term=#{params[:term]}"
		end
		if params.has_key?(:sort_column)
			path += "&sort_column=#{params[:sort_column]}"
		end
		if params.has_key?(:sort_direction)
			path += "&sort_direction=#{params[:sort_direction]}"
		end
		return path
	end

	def active_page_class instances, page
		if instances.current_page == page 
			return 'current'.html_safe
		end
		return ''
	end

	def pagination_pages_array instances
		[*1..(instances.total_pages)]
	end
	
end
