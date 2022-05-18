require 'active_support/concern'

module SidebarConcerns
	extend ActiveSupport::Concern
  include Translations::TranslationsViewHelper

 	included do
    def set_menu
      @menu = [
      {
        name: translate_view_application_shared('sidebar_menu.home'),
        icon: 'bi bi-house-door',
        policy: :dashboard,
        url: { controller: 'dashboard', action: 'index' },
        active: controller_path == 'admin/dashboard'
      },
      {
        name: t('users.plural'),
        icon: 'bi bi-person',
        policy: :user,
        url: { controller: 'users', action: 'index' },
        active: controller_path == 'admin/users'
      },
      {
        name: t('tenants.plural'),
        icon: 'bi bi-people',
        policy: :tenant,
        url: { controller: 'tenants', action: 'index' },
        active: controller_path == 'admin/tenants'
      },
      # Submenu Example
      # {
      #   name: 'Tenants',
      #   icon: 'bi bi-people',
      #   id_collapse: 'tenant-collapse',
      #   policy: :tenant,
      #   url: { controller: 'tenants', action: 'index' },
      #   active: (controller_path == "admin/users" || controller_path == 'admin/dashboard' ) ,
      #   items: [
      #       {
      #         name: 'Categorias de exames',
      #         icon: 'bi bi-card-list',
      #         policy: :tenant,
      #         url: { controller: 'tenants', action: 'index' },
      #         active: (controller_path == "admin/users")
      #       },
      #       {
      #         name: 'Início',
      #         icon: 'bi bi-house-door',
      #         policy: :dashboard,
      #         url: { controller: 'dashboard', action: 'index' },
      #         active: controller_path == 'admin/dashboard'
      #       },
      #   ]
      # }
      ]
    end
	end

end

