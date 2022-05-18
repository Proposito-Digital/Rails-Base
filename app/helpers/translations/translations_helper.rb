module Translations::TranslationsHelper
  include Translations::TranslationsView
	include Translations::Datetime
  include Translations::TranslationsSelectHelper

  # controller: PagesController, action: home
  def translate_view_home path, params = {}
    translate_view_actions("home.#{path}", params)
  end
end