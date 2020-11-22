# frozen_string_literal: true

class PostDecorator < ApplicationDecorator

  delegate :name, :title, :rooms, :enabled

end
