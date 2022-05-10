require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let!(:instance){ create :user}
  let!(:user){create :user_admin }
  let!(:regular_user){create :user }
  let!(:current_user){ user }

  
  before :each do
    @model = User
    sign_in user
    allow(helper).to receive(:params){ ActionController::Parameters.new({controller: "admin/users", action: "index"}) }
  end

  describe "#model_singular_name" do
    it "returns singular model name" do
      expect(helper.model_singular_name).to eq "user"
    end
  end

  describe "#model_plural_name" do
    it "returns plural model name" do
      expect(helper.model_plural_name).to eq "users"
    end
  end

  describe "#model_singular_translation" do
    it "returns singular translation" do
      expect(helper.model_singular_translation).to eq "Usuário"
    end
  end

  describe "#model_plural_translation" do
    it "returns plural translation" do
      expect(helper.model_plural_translation).to eq "Usuários"
    end
  end

  describe "#model_column_names" do
    it "returns model column names" do
      expect(helper.model_column_names).to match_array [
        "id", 
        "name", 
        "token_expiration_time", 
        "access_token", 
        "created_at", 
        "updated_at", 
        "deleted_at",
        "email",
        "encrypted_password", 
        "reset_password_token",  
        "reset_password_sent_at", 
        "remember_created_at", 
        "sign_in_count", 
        "current_sign_in_at", 
        "last_sign_in_at", 
        "current_sign_in_ip", 
        "last_sign_in_ip",
        "tenant_id", 
        "current_role_id"]
    end
  end

  describe "#attribute_translation" do
    it "return attribute translation" do
      expect(helper.attribute_translation(@model.to_s.downcase, 'name')).to eq 'Nome'
    end
  end

  describe "#instances_index_path" do
    it "returns index path" do
      expect(helper.instances_index_path).to eq '/admin/users'
    end
  end

  describe "#instance_show_path" do
    it "returns show path" do
      expect(helper.instance_show_path(instance)).to eq "/admin/users/#{instance.id}"
    end
  end

  describe "#instance_new_path" do
    it "returns new path" do
      expect(helper.instance_new_path).to eq "/admin/users/new"
    end
  end

  describe "#instance_edit_path" do
    it "returns edit path" do
      expect(helper.instance_edit_path(instance)).to eq "/admin/users/#{instance.id}/edit"
    end
  end

  describe "#instance_remove_path" do
    it "returns remove path" do
      expect(helper.instance_remove_path(instance)).to eq "/admin/users/#{instance.id}"
    end
  end

  describe "#instance_create_path" do
    it "returns create path" do
      expect(helper.instance_create_path).to eq "/admin/users"
    end
  end

  describe "#instance_update_path" do
    it "returns update path" do
      expect(helper.instance_update_path(instance)).to eq "/admin/users/#{instance.id}"
    end
  end

  describe "#singular_model_name" do
    it "returns singular model name" do
      expect(helper.singular_model_name).to eq "user"
    end
  end

  describe "#model_singular_name_to_translate" do
    it "returns singular name to translate" do
      expect(helper.model_singular_name_to_translate(instance)).to eq "user"
    end
  end

  describe "#model_field_id" do
    it "returns model field id" do
      expect(helper.model_field_id(instance, :id)).to eq "user_id"
    end
  end

  describe "#custom_model_singular_translation" do
    it "returns custom model singular translation" do
      expect(helper.custom_model_singular_translation("users")).to eq "Usuário"
    end
  end

  describe "#custom_model_plural_translation" do
    it "returns custom model plural translation" do
      expect(helper.custom_model_plural_translation("users")).to eq "Usuários"
    end
  end

  describe "#model_column_names_only" do
    it "returns model column names" do
      expect(helper.model_column_names_only(["name", "id"])).to match_array ["name", "id"]
    end
  end

  describe "#model_column_names_only" do
    it "returns model column names" do
      attributes = helper.instance_attributes_only(instance, ["name", "id"])
      expect(attributes["id"]).to eq instance.id
      expect(attributes["name"]).to eq instance.name
    end
  end

  describe "#action_button" do
    context "Instance and action present" do
      context "Authorized" do
        it "returns enabled button html" do
          button = helper.action_button href: helper.instance_edit_path(instance), instance: instance, action: :edit?, icon:"bi bi-clock", title: 'test'
          expect(button).to eq "<a class='btn-icon' title='test' data-placement='top' href='/admin/users/#{instance.id}/edit'><i class='bi bi-clock'></i></a>"
        end
      end
      context "Unauthorized" do
        before :each do
          user_role = create :user_role, role: 1, user: user
          user.current_role = user_role
          user.save!
        end
        it "returns disabled button html" do
          button = helper.action_button href: helper.instance_edit_path(instance), instance: instance, action: :edit?, icon:"bi bi-clock", title: 'test'
          expect(button).to eq "<a class='btn-icon disabled' title='Você não pode fazer essa ação.' data-placement='top' href='javascript:void(0)'><i class='bi bi-clock'></i></a>"
        end
      end
    end
    context "Instance and action not present" do
      it "returns enabled button html" do
        button = helper.action_button href: root_path, icon:"bi bi-clock", title: 'test'
        expect(button).to eq "<a class='btn-icon' title='test' data-placement='top' href='/'><i class='bi bi-clock'></i></a>"
      end
    end

    describe "#modal_button" do
      context "Authorized" do
        it "returns modal button html" do
          button = helper.modal_button href: '#', instance: instance, action: :destroy?, icon:"bi bi-trash", title: 'test', modal_id: "modal_destroy_#{instance.id}"
          expect(button).to eq "<a type=\"button\" class='btn-icon' title='test' data-bs-toggle=\"modal\" data-bs-target=\"#modal_destroy_#{instance.id}\"><i class='bi bi-trash'></i></a>"
        end
      end
      context "Unauthorized" do
        before :each do
          user_role = create :user_role, role: 1, user: user
          user.current_role = user_role
          user.save!
        end
        it "returns modal button html" do
          button = helper.modal_button href: '#', instance: instance, action: :destroy?, icon:"bi bi-trash", title: 'test', modal_id: "modal_destroy_#{instance.id}"
          expect(button).to eq nil
        end
      end
    end

    describe "#check_policy" do
      context "authorized" do
        it "returns true" do
          expect(helper.check_policy(instance: instance, action: :edit?)).to eq true
        end
      end
      context "unauthorized" do
        before :each do
          user_role = create :user_role, role: 1, user: user
          user.current_role = user_role
          user.save!
        end
        it "returns false" do
          expect(helper.check_policy(instance: instance, action: :create?)).to eq false
        end
      end
    end

    describe "#instance_display" do
      it "returns id" do
        expect(helper.instance_display(instance)).to eq "##{instance.id}"
      end
    end

    describe "#d_datatime" do
      it "returns date string" do
        date = DateTime.new(2001,2,3,4,30)
        expect(helper.d_datatime(date)).to eq "03/02/2001 04:30"
      end
    end

    describe "#user_roles_options" do
      it "returns roles" do
        expect(helper.user_roles_options).to match_array ["admin", "regular"]
      end
    end

    describe "#hours_options" do
      it "returns hours" do
        expect(helper.hours_options).to match_array(
        [
          "00:00", "00:15", "00:30", "00:45", "01:00", "01:15", "01:30", "01:45", "02:00", "02:15", "02:30", "02:45", 
          "03:00", "03:15", "03:30", "03:45", "04:00", "04:15", "04:30", "04:45", "05:00", "05:15", "05:30", "05:45", 
          "06:00", "06:15", "06:30", "06:45", "07:00", "07:15", "07:30", "07:45", "08:00", "08:15", "08:30", "08:45", 
          "09:00", "09:15", "09:30", "09:45", "10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "11:45", 
          "12:00", "12:15", "12:30", "12:45", "13:00", "13:15", "13:30", "13:45", "14:00", "14:15", "14:30", "14:45", 
          "15:00", "15:15", "15:30", "15:45", "16:00", "16:15", "16:30", "16:45", "17:00", "17:15", "17:30", "17:45", 
          "18:00", "18:15", "18:30", "18:45", "19:00", "19:15", "19:30", "19:45", "20:00", "20:15", "20:30", "20:45", 
          "21:00", "21:15", "21:30", "21:45", "22:00", "22:15", "22:30", "22:45", "23:00", "23:15", "23:30", "23:45"
        ])
      end
    end

    describe "#flash_type" do
      context "success" do
        it "returns success" do
          expect(helper.flash_type('success')).to eq 'success'
        end
      end
      context "alert" do
        it "returns alert" do
          expect(helper.flash_type('alert')).to eq 'warning'
        end
      end
      context "error" do
        it "returns error" do
          expect(helper.flash_type('error')).to eq 'danger'
        end
      end
      context "danger" do
        it "returns error" do
          expect(helper.flash_type('danger')).to eq 'danger'
        end
      end
      context "notice" do
        it "returns error" do
          expect(helper.flash_type('notice')).to eq 'primary'
        end
      end
      context "empty string" do
        it "returns empty" do
          expect(helper.flash_type('')).to eq ''
        end
      end
    end

    describe "#render_active" do
      context "have submenu" do
        let!(:menu){
          {
            name: 'Tenants',
            icon: 'bi bi-people',
            id_collapse: 'tenant-collapse',
            policy: :tenant,
            url: { controller: 'tenants', action: 'index' },
            active: false ,
            items: [
                {
                  name: 'Categorias de exames',
                  icon: 'bi bi-card-list',
                  policy: :tenant,
                  url: { controller: 'tenants', action: 'index' },
                  active: false
                },
                {
                  name: 'Início',
                  icon: 'bi bi-house-door',
                  policy: :dashboard,
                  url: { controller: 'dashboard', action: 'index' },
                  active: true
                },
            ]
          }
        }
        context "active submenu" do
          it "returns true" do
            expect(helper.render_active(menu)).to eq true
          end
        end
        context "no active submenu" do
          before :each do
            menu[:items][1][:active]=false
          end
          it "returns false" do
            expect(helper.render_active(menu)).to eq false
          end
        end
      end
      context "do not have submenu" do
        let!(:menu){
          {
            name: 'Tenants',
            icon: 'bi bi-people',
            id_collapse: 'tenant-collapse',
            policy: :tenant,
            url: { controller: 'tenants', action: 'index' },
            active: false
          }
        }
        context "active" do
          before :each do
            menu[:active] = true
          end
          it "returns true" do
            expect(helper.render_active(menu)).to eq true
          end
        end
        context "no active" do
          it "returns false" do
            expect(helper.render_active(menu)).to eq false
          end
        end
      end
    end
  end
end