require 'rails_helper'

describe "integration teste for Admin::tenant", type: :feature do
    let!(:tenant) { create(:tenant) }
    let!(:user) { create(:user_admin) }

    before(:each) do
        sign_in user
    end

    it "access index page" do
        visit admin_tenants_path()
        expect(page).to have_content tenant.name
    end

    it "create tenant" do
        visit admin_tenants_path()
        click_link 'Adicionar'
        within("#new_tenant") do
            fill_in 'tenant[name]', with: 'Tenant novo'
            fill_in 'tenant[slug]', with: 'novo tnt'
        end
        click_button 'Salvar'
        expect(page).to have_content 'foi criado com sucesso.'
    end
    
    it "edit tenant" do
        visit admin_tenants_path()
        within "#tr_Tenant_#{tenant.id}" do
            click_link 'Editar'
        end
        within(".edit_tenant") do
            fill_in 'tenant[name]', with: 'Tenant editado'
        end    
        click_button 'Salvar'
        expect(page).to have_content 'foi atualizado com sucesso.'
    end

    it "show tenant" do
        visit admin_tenants_path()
        within "#tr_Tenant_#{tenant.id}" do
            click_link 'Visualizar'
        end
        expect(find_field('tenant[name]', disabled: true).value).to eq tenant.name
        expect(find_field('tenant[slug]', disabled: true).value).to eq tenant.slug
    end
    
    xit "delete tenant" do
        new_tenant = create :tenant
        visit admin_tenants_path() 
        within("#tr_Tenant_#{new_tenant.id}") do
            find("a[title='Remover']").click
        end
        within("#modal_destroy_#{new_tenant.id}") do 
          click_link('Remover')
        end
        expect(page).to have_content 'foi removido com sucesso.'
    end

    it "paginate tenant" do
        create_list(:tenant, 11)
        tenants = Tenant.where.not(name: tenant.name).order(:created_at)

        visit admin_tenants_path() 

        find('#page_next').click
        expect(page).to have_content tenants.last.name

        find('#page_previous').click
        expect(page).to have_no_content tenants.last.name
    end

    it "ordenation tenant" do
        create :tenant
        visit admin_tenants_path() 

        click_link 'Nome'
        expect(page).to have_current_path(admin_tenants_path(sort_direction: 'asc', sort_column: 'tenants.name'))
        tenants = Tenant.order(name: :asc).all()
        expect(page).to have_css('table > tbody > tr:nth-child(1) > td:nth-child(1)', text: tenants[0].name)
        
        click_link 'Nome'
        tenants = Tenant.order(name: :desc).all()
        expect(page).to have_current_path(admin_tenants_path(sort_direction: 'desc', sort_column: 'tenants.name'))
        expect(page).to have_css('table > tbody > tr:nth-child(1) > td:nth-child(1)', text: tenants[0].name)
    end

end