require 'rails_helper'

describe "integration teste for <%= singular_table_name %>", :type => :feature do
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  it "access index page" do
    <%= singular_table_name %> = create(:<%= singular_table_name %>)
    visit admin_<%= plural_table_name %>_path  
    expect(page).to have_content <%= singular_table_name %>.<%= attributes_names.first %>
  end

  it "create <%= singular_table_name %>" do
    visit admin_<%= plural_table_name %>_path
    click_link 'Adicionar'
    within("#new_<%= singular_table_name %>") do
      <%= attributes_names.reject{|name| name.in?(['deleted_at'])}.map { |name| "fill_in '" + singular_table_name + "[#{name}]'" +", with: '#change_here'" }.join("\n      ") %>
    end
    click_button 'Salvar'
    expect(page).to have_content 'foi criado com sucesso.'
  end

  it "edit <%= singular_table_name %>" do
    <%= singular_table_name %> = create(:<%= singular_table_name %>)
    visit admin_<%= plural_table_name %>_path
    within("#tr_<%=class_name%>_#{<%=singular_table_name%>.id}") do
      click_link 'Editar'
    end
    within(".edit_<%= singular_table_name %>") do
      <%= attributes_names.reject{|name| name.in?(['deleted_at'])}.map { |name| "fill_in'" + singular_table_name + "[#{name}]'" +", with: '#change_here'" }.join("\n      ") %>
    end    
    click_button 'Salvar'
    expect(page).to have_content 'foi atualizado com sucesso.'
  end

  it "show <%= singular_table_name %>" do
    <%= singular_table_name %> = create(:<%= singular_table_name %>)
    visit admin_<%= plural_table_name %>_path
    within("#tr_<%=class_name%>_#{<%=singular_table_name%>.id}") do
      click_link 'Visualizar'
    end
    expect(page).to have_xpath("//input[@value='#{<%= singular_table_name %>.<%= attributes_names.first %>}']") 
  end

  xit "delete <%= singular_table_name %>" do
    create_list(:<%= singular_table_name %>, 2)
    <%= plural_table_name %> = <%= class_name %>.all()
    visit admin_<%= plural_table_name %>_path
    within("#tr_<%=class_name%>_#{<%=plural_table_name%>.first.id}") do
      find("a[title='Remover']").click
    end
    within("#modal_destroy_#{<%= plural_table_name %>.first.id}") do 
      click_link('Remover')
    end
    expect(page).to have_content 'foi removido com sucesso.'
  end

  xit "filter <%= singular_table_name %>" do
    Capybara.current_driver = :poltergeist
    create_list(:<%= singular_table_name %>, 3)
    <%= plural_table_name %> = <%= class_name %>.all()
    visit admin_<%= plural_table_name %>_path
    within("#form_search") do
      fill_in 'term' , with: <%= plural_table_name %>.last.<%= attributes_names.first %>
    end
    find("input[name=term]").native.send_keys :enter
    expect(page).to have_no_content <%= plural_table_name %>.first.<%= attributes_names.first %>
    Capybara.use_default_driver 
  end

  it "paginate <%= singular_table_name %>" do
    create_list(:<%= singular_table_name %>, 11)
    <%= plural_table_name %> = <%= class_name %>.all()

    visit admin_<%= plural_table_name %>_path
    
    find('#page_next').click
    expect(page).to have_content <%= plural_table_name %>.first.<%= attributes_names.first %>

    find('#page_previous').click
    expect(page).to have_no_content <%= plural_table_name %>.first.<%= attributes_names.first %>
  end

  it "ordenation <%= singular_table_name %>" do
    <%= attributes_names.first %>s = ('a'..'j').to_a.map{|letter| {<%= attributes_names.first %>: letter} }
    <%= attributes_names.first %>s.map { |<%= attributes_names.first %>| create(:<%= singular_table_name %>, <%= attributes_names.first %>) }
    <%= plural_table_name %> = <%= class_name %>.all()

    visit admin_<%= plural_table_name %>_path

    expect(page).to have_css("table tbody tr:first-child td:first-child", text: 'j')

    click_link '<%= attributes_names.first.capitalize %>' #change_here
    expect(page).to have_current_path(admin_<%= plural_table_name %>_path(sort_direction: 'asc', sort_column: '<%= plural_table_name + '.' + attributes_names.first %>'))
    expect(page).to have_css("table tbody tr:first-child td:first-child", text: 'a')
    
    click_link '<%= attributes_names.first.capitalize %>' #change_here
    expect(page).to have_current_path(admin_<%= plural_table_name %>_path(sort_direction: 'desc', sort_column: '<%= plural_table_name + '.' + attributes_names.first %>'))
    expect(page).to have_css("table tbody tr:first-child td:first-child", text: 'j')
    
  end

end