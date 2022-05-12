module Translations::TranslationsView
  
  def base_translate_view(path, params = {})
    t("views.#{path}.", **params)
  end

  def base_translate_view_controller_path(path, params = {})
    base_translate_view("#{translation_controller_path}.#{path}", params)
  end

  def base_translate_view_controller_contextable_path(path, params = {})
    base_translate_view("#{translation_contextable_controller_path}.#{path}", params)
  end

  def base_translate_view_application_path(path, params = {})
    base_translate_view("application.#{path}", params)
  end

  def translate_view(path, params = {})
    translation = base_translate_view_controller_path(path, params.merge(default: ''))
    unless translation.present?
      return base_translate_view_application_path(path, params)
    end
    translation
  end

  def translate_view_actions(path, params = {})
    translate_view("actions.#{path}", params)
  end

  def translate_view_shared(path, params = {})
    translate_view("shared.#{path}", params)
  end

  def translate_view_index(path, params = {})
    translate_view_actions("index.#{path}", params)
  end

  def translate_view_new(path, params = {})
    translate_view_actions("new.#{path}", params)
  end

  def translate_view_edit(path, params = {})
    translate_view_actions("edit.#{path}", params)
  end

  def translate_view_show(path, params = {})
    translate_view_actions("show.#{path}", params)
  end

  def translate_view_destroy(path, params = {})
    translate_view_actions("destroy.#{path}", params)
  end

  def translation_controller_path
    splited_name = self.controller.class.name.underscore.split("/")
    splited_name[splited_name.length-1] = splited_name[splited_name.length-1].gsub("_controller", "")
    splited_name.join(".")
  end

  alias_method :t_view_shared, :translate_view_shared
  alias_method :t_view_index, :translate_view_index
  alias_method :t_view_new, :translate_view_new
  alias_method :t_view_edit, :translate_view_edit
  alias_method :t_view_show, :translate_view_show
  alias_method :t_view_destroy, :translate_view_destroy
end