# frozen_string_literal: true
module IconsHelper
	def feather_icon width: 24, height: 24, color: 'currentColor', line_width: 2, _class: nil, lines: nil
		"<svg aria-hidden='true' xmlns='http://www.w3.org/2000/svg' width='#{width}' height='#{height}' viewBox='0 0 #{width} #{height}' fill='none' stroke='#{color}' stroke-width='#{line_width}' stroke-linecap='round' stroke-linejoin='round' class='feather #{_class}'>#{lines}</svg>".html_safe
	end

	def feather_close_icon width: 24, height: 24, color: 'currentColor', line_width: 2
		feather_icon(
			width: width, 
			height: height, 
			color: color, 
			line_width: line_width, 
			lines: "<line x1='18' y1='6' x2='6' y2='18'></line><line x1='6' y1='6' x2='18' y2='18'></line>",
			_class: 'feather-x'
		)
	end

	def feather_arrow_left_icon width: 24, height: 24, color: 'currentColor', line_width: 2
		feather_icon(
			width: width, 
			height: height, 
			color: color, 
			line_width: line_width, 
			lines: "<line x1='19' y1='12' x2='5' y2='12'></line><polyline points='12 19 5 12 12 5'></polyline>",
			_class:  'feather-arrow-left sidebarCollapse'
		)
	end
end
