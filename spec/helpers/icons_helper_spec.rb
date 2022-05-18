require 'rails_helper'

RSpec.describe IconsHelper, type: :helper do
  describe "#feather_close_icon" do
    it "returns html icon" do
      width = Faker::Number.between(from: 1, to: 10)
      height = Faker::Number.between(from: 1, to: 10)
      line_width = Faker::Number.between(from: 1, to: 10)
      color = Faker::Color.color_name
      expect(
        helper.feather_close_icon(width: width, height: height, color: color, line_width: line_width)
      ).to eq "<svg aria-hidden='true' xmlns='http://www.w3.org/2000/svg' "+ 
              "width='#{width}' height='#{height}' viewBox='0 0 #{width} #{height}' fill='none' stroke='#{color}'"+ 
              " stroke-width='#{line_width}' stroke-linecap='round' stroke-linejoin='round' class='feather feather-x'>"+
              "<line x1='18' y1='6' x2='6' y2='18'></line><line x1='6' y1='6' x2='18' y2='18'></line></svg>"
    end
  end

  describe "#feather_arrow_left_icon" do
    it "returns html icon" do
      width = Faker::Number.between(from: 1, to: 10)
      height = Faker::Number.between(from: 1, to: 10)
      line_width = Faker::Number.between(from: 1, to: 10)
      color = Faker::Color.color_name
      expect(
        helper.feather_arrow_left_icon(width: width, height: height, color: color, line_width: line_width)
      ).to eq "<svg aria-hidden='true' xmlns='http://www.w3.org/2000/svg' "+
              "width='#{width}' height='#{height}' viewBox='0 0 #{width} #{height}'"+
              " fill='none' stroke='#{color}' stroke-width='#{line_width}' stroke-linecap='round' "+
              "stroke-linejoin='round' class='feather feather-arrow-left sidebarCollapse'>"+
              "<line x1='19' y1='12' x2='5' y2='12'></line><polyline points='12 19 5 12 12 5'></polyline></svg>"
    end
  end
end