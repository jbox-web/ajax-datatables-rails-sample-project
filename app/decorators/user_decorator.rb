# frozen_string_literal: true

class UserDecorator < ApplicationDecorator

  delegate :name, :title, :rooms, :enabled

end
