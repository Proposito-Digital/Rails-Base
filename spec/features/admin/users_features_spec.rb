# frozen_string_literal: true
require 'rails_helper'

describe "integration teste for Admin::user", :type => :feature do
  let!(:tenant) { create(:tenant) }
  let!(:user_admin) { create(:user_admin) }
  let!(:user) { create(:user, tenant: tenant) }

  before(:each) do
    sign_in user_admin
  end

  it "access index page" do
    visit admin_users_path()  
    expect(page).to have_content user.name
  end

  it "create user" do
    visit admin_users_path() 
    click_link 'Adicionar'
    within("#new_user") do
      fill_in 'user[name]', with: 'games'
      fill_in 'user[email]', with: 'games@games.com'
      fill_in 'user[password]', with: 'teste@123'
      fill_in 'user[password_confirmation]', with: 'teste@123'
      select(UserRole.roles.keys.to_a.sample, from: "user_roles").select_option
    end    

    click_button 'Salvar'
    expect(page).to have_content 'foi criado com sucesso.'
  end

  it "edit user" do
    visit admin_users_path()
    within "#tr_User_#{user.id}" do 
      click_link 'Editar'
    end
    within(".edit_user") do
      fill_in 'user[name]', with: 'opa'
    end    
    click_button 'Salvar'
    expect(page).to have_content 'foi atualizado com sucesso.'
  end

  it "show user" do
    visit admin_users_path()
    within "#tr_User_#{user.id}" do 
      click_link 'Visualizar'
    end
    expect(find_field('user[name]', disabled: true).value).to eq user.name
    expect(find_field('user[email]', disabled: true).value).to eq user.email
    expect(find_field('user[roles]', disabled: true).value).to eq "admin"
  end

  xit "delete user" do
    new_user = create :user,tenant: tenant
    visit admin_users_path()
    within("#tr_#{new_user.class.name}_#{new_user.id}") do
      find("a[title='Remover']").click
    end
    within("#modal_destroy_#{new_user.id}") do 
      click_link('Remover')
    end
    expect(page).to have_content 'foi removido com sucesso.'
  end

  it "paginate user" do
    create_list(:user, 11, tenant: tenant)
    users = User.where.not(email: user.email).order(:created_at)

    visit admin_users_path() 

    find('#page_next').click
    expect(page).to have_content users.last.name

    find('#page_previous').click
    expect(page).to have_no_content users.last.name
  end

  
  it "ordenation" do
    create :user
    visit admin_users_path()
    
    click_link 'Nome'
    expect(page).to have_current_path(admin_users_path(sort_direction: 'asc', sort_column: 'users.name', locale: "pt-BR"))
    users = User.order(name: :asc).all()
    expect(page).to have_css('table > tbody > tr:nth-child(1) > td:nth-child(1)', text: users[0].name)
    
    click_link 'Nome'
    users = User.order(name: :desc).all()
    expect(page).to have_current_path(admin_users_path(sort_direction: 'desc', sort_column: 'users.name', locale: "pt-BR"))
    expect(page).to have_css('table > tbody > tr:nth-child(1) > td:nth-child(1)', text: users[0].name)
  end

end