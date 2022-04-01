# frozen_string_literal: true
module BaseAdminHelper
	include GenericHelper

	def instances_index_path
		path = "admin_#{model_plural_name}_path"
		send(path)
	end

	def instance_show_path instance
		path = "admin_#{model_singular_name}_path"
		send(path, instance)
	end

	def instance_new_path
		path = "new_admin_#{model_singular_name}_path"
		send(path)
	end

	def instance_create_path
		path = "admin_#{model_plural_name}_path"
		send(path)
	end

	def instance_edit_path instance
		path = "edit_admin_#{model_singular_name}_path"
		send(path, instance)
	end

	def instance_remove_path instance
		path = "admin_#{model_singular_name}_path"
		send(path, instance)
	end

	def instance_update_path instance
		path = "admin_#{model_singular_name}_path"
		send(path, instance)
	end
	
end
