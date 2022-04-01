# frozen_string_literal: true
class Admin::UsersController < BaseAdminController
  
  def update_password
    id = params['user'][:id];
    id ||= current_user.id
    @instance = @model.find(id)
    authorize @instance
    
    if @instance.update_with_password(update_password_params)
      if @instance.id == current_user.id 
        bypass_sign_in @instance
      end
      flash[:success] = "Senha alterada com sucesso"
      redirect_back fallback_location: admin_root_path
    else
      flash[:danger] = "Erro ao editar senha"
      redirect_back fallback_location: admin_root_path
    end
  end
  
  def update_all_passwords
    authorize @model, :update_all_passwords?
    update_password
  end

  private

  def default_params_permited
    [ :role, :name, :is_admin, :is_representative, :email, :password, :password_confirmation, :current_password, :tenant_id ] 
  end


  def update_password_params
    params.require(default_param_required).permit(default_params_permited)
  end

  def filter_fields
    ['users.name', 'users.email']
  end


end
