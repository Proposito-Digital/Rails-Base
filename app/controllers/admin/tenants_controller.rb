class Admin::TenantsController < BaseAdminController

  def change_current_tenant
    authorize Tenant
    session_service = SessionService.new(request)
    session_service.set_admin_tenant_id(params[:id])
    if set_tenant
      redirect_to admin_tenants_path, flash:{success: translate_flash('success') }  
    else
      redirect_to admin_tenants_path, flash:{danger: translate_flash('danger')}  
    end
  end
 
  def disable_current_tenant
    authorize Tenant
    session_service = SessionService.new(request)
    session_service.clear_admin_tenant_id
    if session_service.admin_tenant_id == nil
      redirect_to admin_tenants_path, flash:{success: translate_flash('success') }  
    else
      redirect_to admin_tenants_path, flash:{danger: translate_flash('danger')}  
    end
  end

  def destroy
    filter
    set_instance
    authorize @instance
    begin
      @instance.destroy
    rescue ActiveRecord::InvalidForeignKey
      redirect_to admin_tenants_path, flash:{danger: translate_flash('danger')}
    else
      redirect_to self.send(redirect_to_index), :flash =>{:success => translate_flash('success') }
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
