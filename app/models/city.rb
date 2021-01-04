# frozen_string_literal: true

class City < ApplicationRecord
  belongs_to :country
end
