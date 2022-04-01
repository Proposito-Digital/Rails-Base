# frozen_string_literal: true
module ApplicationHelper
  include Pundit::Authorization
  include PaginationHelper
  include SortableHelper
  include SidebarHelper
  include IconsHelper
  include ActiveSupport::Inflector

	def app_version
		file = File.read("VERSION") + Rails.env[0, 3]
	end

	def plural_model_name
		params[:controller].split("/")[-1]
	end

	def singular_model_name
		singularize(plural_model_name)
	end

	def build_namespace
		params[:controller].gsub(plural_model_name,"").gsub("/","_").delete_suffix('_')
	end

	def model_singular_name
		@model.to_s.underscore
	end

  def model_singular_name_to_translate(instance)
		instance.class.name.to_s.underscore.gsub("::","/")
	end
	
	def model_plural_name
		model_singular_name.pluralize
	end

	def model_plural_name_to_sort
		model_singular_name.pluralize.gsub("/","_")
	end
  
	def model_field_id(instance, attribute)
		"#{instance.class.name.to_s.underscore.gsub("/","_")}_#{attribute}"
	end

	def model_singular_translation
		t("#{model_plural_name}.single")
	end

	def custom_model_singular_translation model
		t("#{model}.single")
	end

	def model_plural_translation
		t("#{model_plural_name}.plural")
	end

	def custom_model_plural_translation model
		t("#{model.pluralize.downcase.gsub("::","/")}.plural")
	end

	def model_column_names
		@model.column_names.to_a
	end

	def model_column_names_only(attributes_names)
		@model.column_names.select { |column_name| attributes_names.include? column_name }
	end

	def instance_attributes_only(instance, attributes_names)
		instance.attributes.select { |attribute| attributes_names.include? attribute }
	end

	def attribute_translation model_name, attribute_name
		I18n.translate("activerecord.attributes.#{model_name}.#{attribute_name}")
	end

	def meet_status_translation status
		t("en.activerecord.attributes.meet.statuses.#{status}")
	end

	def action_button href: nil, style: nil, data_placement: 'top', instance: nil, action: nil, title: nil, data_method: nil, data_toggle: nil, data_target: nil, icon: nil, context_instance: nil
		properties = []

    css_class, properties, policy_error = check_policy_to_button(instance, action, properties, href, title, context_instance)

    properties << "data-placement='#{data_placement}'" if data_placement.present?
		properties << "data-method='#{data_method}'" if data_method.present?
		properties << "data-toggle='#{data_toggle}'" if data_toggle.present?
		properties << "data-target='##{data_target}'" if data_target.present?
    policy_error ? properties << "href='javascript:void(0)'" : properties << "href='#{href}'" if href.present?

		i = []
		i << "class='#{icon}'" if icon.present?
		i << "style='#{style}'" if style.present?
		"<a #{css_class} #{properties.join(" ")}><i #{i.join(" ")}></i></a>".html_safe
	end

  def modal_button icon: nil, instance:nil, action: nil, href: nil, title: nil, style: nil, modal_id: nil, context_instance: nil
		properties = []

    css_class, properties, policy_error = check_policy_to_button(instance, action, properties, href, title, context_instance)

		if not policy_error

			properties << "data-bs-toggle=\"modal\" data-bs-target=\"##{modal_id}\""

			i = []
			i << "class='#{icon}'" if icon.present?
			i << "style='#{style}'" if style.present?

			"<a type=\"button\" #{css_class} #{properties.join(" ")}><i #{i.join(" ")}></i></a>".html_safe
		end
	end

	def instances_index_path
		path = "#{build_namespace}_#{model_plural_name}_path"
		send(path)
	end

	def instance_show_path instance
		path = "#{build_namespace}_#{model_singular_name}_path"
		send(path, instance)
	end

	def instance_new_path
		path = "new_#{build_namespace}_#{model_singular_name}_path"
		send(path)
	end

	def instance_create_path
		path = "#{build_namespace}_#{model_plural_name}_path"
		send(path)
	end

	def instance_edit_path instance
		path = "edit_#{build_namespace}_#{model_singular_name}_path"
		send(path, instance)
	end

	def instance_remove_path instance
		path = "#{build_namespace}_#{model_singular_name}_path"
		send(path, instance)
	end

	def instance_update_path instance
		path = "#{build_namespace}_#{model_singular_name}_path"
		send(path, instance)
	end

	def instance_display instance
		"##{instance.id}"
	end

  def check_policy_to_button(instance, action, properties, href, title, context_instance=nil)
    if instance.present? && action.present?
      policy_error = check_policy_error(instance: instance, action: action)
			policy_error = check_policy_error(instance: context_instance, action: action) if context_instance.present?
    else
      policy_error = false
    end

    if policy_error
      properties << "title='#{policy_error}'" if policy_error.present?
      css_class = "class='btn-icon disabled'"
    else
      properties << "title='#{title}'" if title.present?
      css_class = "class='btn-icon'"
    end
    return [css_class, properties, policy_error]
  end

	def check_policy instance: nil, action: nil
		begin
			policy(instance).send(action)
		rescue Pundit::NotAuthorizedError => e
			false
		end
	end

	def check_policy_error instance: nil, action: nil
		begin
			if policy(instance).send(action)
				return false
			else
				return (t "#{instance.class.to_s.underscore + "_policy"}.#{action.to_s}", scope: "pundit", default: :default)
			end
		rescue Pundit::NotAuthorizedError => e
			policy_name = e.policy.class.to_s.underscore
			return t "#{policy_name}.#{e.query}", scope: "pundit", default: :default
		end
	end

	def d_datatime(data)
		data.strftime("%d/%m/%Y %H:%M")
	end

	def user_roles_options
		UserRole.roles.keys.to_a
	end

	def hours_options
		# starting_hour = DateTime.now.beginning_of_day
		# hours = [starting_hour.strftime('%H:%M')]
		# while hours[-1] != '23:45' do
		# 	starting_hour += 15.minute
		# 	hours.append(starting_hour.strftime('%H:%M'))
		# end
		["00:00", "00:15", "00:30", "00:45", "01:00", "01:15", "01:30", "01:45", "02:00", "02:15", "02:30", "02:45", 
			"03:00", "03:15", "03:30", "03:45", "04:00", "04:15", "04:30", "04:45", "05:00", "05:15", "05:30", "05:45", 
			"06:00", "06:15", "06:30", "06:45", "07:00", "07:15", "07:30", "07:45", "08:00", "08:15", "08:30", "08:45", 
			"09:00", "09:15", "09:30", "09:45", "10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "11:45", 
			"12:00", "12:15", "12:30", "12:45", "13:00", "13:15", "13:30", "13:45", "14:00", "14:15", "14:30", "14:45", 
			"15:00", "15:15", "15:30", "15:45", "16:00", "16:15", "16:30", "16:45", "17:00", "17:15", "17:30", "17:45", 
			"18:00", "18:15", "18:30", "18:45", "19:00", "19:15", "19:30", "19:45", "20:00", "20:15", "20:30", "20:45", 
			"21:00", "21:15", "21:30", "21:45", "22:00", "22:15", "22:30", "22:45", "23:00", "23:15", "23:30", "23:45"]
	end

	def present(model, presenter_class=nil)
		begin
			klass = presenter_class || "#{model.class}Presenter".constantize
		rescue NameError
			klass = ApplicationPresenter
		end
		klass.new(model, self)
		# yield(presenter) if block_given?
	end

	def present_collection(collection, presenter_class=nil)
		collection.map{|e|present(e, presenter_class)}
	end

	def flash_type type
    case type 
    when 'success'
      return 'success'
    when 'alert'
      return 'warning'
    when 'error'
      return 'danger'
    when 'danger'
      return 'danger'
    when 'notice'
      return 'primary'
    else
      return ''
    end
	end

	def active_by_submenu submenu
		submenu.each do |menu|
			if menu[:active]
				return true
			end
		end
		return false
	end

	def render_active menu
		if menu[:items].present?
			return active_by_submenu(menu[:items])
		end
		return menu[:active]
	end

  def tenant_options
    Tenant.all.pluck(:slug, :id)
  end

  def markdown(text)
    options = %i[
      hard_wrap autolink no_intra_emphasis tables fenced_code_blocks
      disable_indented_code_blocks strikethrough lax_spacing space_after_headers
      quote footnotes highlight underline no_images
      ]
      Markdown.new(text, *options).to_html.html_safe
  end
  
end