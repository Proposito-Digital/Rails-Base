class Admin::TenantsController < BaseAdminController

  def change_current_tenant
    authorize Tenant
    session_service = SessionService.new(request)
    session_service.set_admin_tenant_id(params[:id])
    if set_tenant
      redirect_to admin_tenants_path, flash:{success: t("#{controller_name}.single") + ' mudado com sucesso.' }  
    else
      redirect_to admin_tenants_path, flash:{danger: "Erro ao mudar " + t("#{controller_name}.single")}  
    end
  end
 
  def disable_current_tenant
    authorize Tenant
    session_service = SessionService.new(request)
    session_service.clear_admin_tenant_id
    if session_service.admin_tenant_id == nil
      redirect_to admin_tenants_path, flash:{success: t("#{controller_name}.single") + ' mudado com sucesso.' }  
    else
      redirect_to admin_tenants_path, flash:{danger: "Erro ao mudar " + t("#{controller_name}.single")}  
    end
  end

  def destroy
    filter
    set_instance
    authorize @instance
    begin
      @instance.destroy
    rescue ActiveRecord::InvalidForeignKey
      redirect_to admin_tenants_path, flash:{danger: "Erro ao deletar " + t("#{controller_name}.single")}
    else
      redirect_to self.send(redirect_to_index), :flash =>{:success => t("#{controller_name}.single") + ' foi removido com sucesso.' }
    end
  end
  
  private

  def default_params_permited
    [ :name, :slug ]
  end

  def filter_fields
    ['name', 'slug']
  end  

end
