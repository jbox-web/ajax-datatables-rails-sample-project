# frozen_string_literal: true

class ApplicationDecorator < Draper::Decorator

  delegate :id


  def created_at(opts = {})
    h.l(object.created_at, opts)
  end


  def updated_at(opts = {})
    h.l(object.updated_at, opts)
  end


  def to_checkbox(opts = {})
    _record_check_box(object, opts)
  end


  private


    def _record_check_box(record, opts = {})
      css = opts.delete(:class) { "#{record.class.name.pluralize.underscore}-checkbox" }
      selected = opts.delete(:selected) { false }
      h.check_box_tag 'ids[]', record.id, selected, opts.merge(id: "#{record.class.name.underscore}-#{record.id}", class: ['checkbox', css])
    end

end
