# frozen_string_literal: true
require 'rails_helper'

describe "the signin process", :type => :feature do
  let!(:tenant) { create(:tenant) }
  before :each do
    create(:user_admin, email: 'casa@casa.com.br', password: "teste@123", password_confirmation: "teste@123",tenant: tenant )
  end

  it "signs me in" do
    visit admin_root_path(tenant_slug: tenant.slug)
    within("#new_user") do
      fill_in 'user[email]'	, with: 'casa@casa.com.br'
      fill_in 'user[password]', with: 'teste@123'
    end
    click_button 'Entrar'
    expect(page).to have_content 'Login efetuado com sucesso!'
  end
end