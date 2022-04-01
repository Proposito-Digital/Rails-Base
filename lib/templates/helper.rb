# frozen_string_literal: true
<% module_namespacing do -%>
module Admin::<%= class_name.pluralize %>Helper
	include BaseAdminHelper
end
<% end -%>