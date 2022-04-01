# frozen_string_literal: true
require 'rails_helper'
require 'generators/rails/my_scaffold_controller/my_scaffold_controller_generator'

describe "Rails::Generators::MyScaffoldControllerGenerator" do

  subject { Rails::Generators::MyScaffoldControllerGenerator.new(["module"]) }	
 
  it "initialize" do
    expect(subject.name).to eq "module"
  end

  describe "Zeitwerk compliance" do
  it "eager loads all files without errors" do
    expect { Rails.application.eager_load! }.not_to raise_error
  end
end

end