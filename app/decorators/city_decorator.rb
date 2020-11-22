# frozen_string_literal: true

class CityDecorator < ApplicationDecorator

  delegate :name, :iata, :country

  def custom_column
  end
end
