# frozen_string_literal: true

class UsersDatatable < ApplicationDatatable

  RANGE_DELIMITER = '-yadcf_delim-'

  def view_columns
    @view_columns ||= {
      check_box:  { source: 'User.id', orderable: false, searchable: false },
      name:       { source: 'User.name' },
      title:      { source: 'User.title' },
      rooms:      { source: 'User.rooms',      cond: range_search },
      enabled_s:  { source: 'User.enabled',    cond: :eq },
      enabled_m:  { source: 'User.enabled',    cond: :in, use_regex: false, formatter: ->(str) { cast_regex_value(str) } },
      created_at: { source: 'User.created_at', cond: :date_range, delimiter: RANGE_DELIMITER },
      updated_at: { source: 'User.updated_at', cond: :date_range, delimiter: RANGE_DELIMITER },
    }
  end


  def data
    records.map do |decorated|
      {
        check_box:  decorated.to_checkbox(selected: selected.include?(decorated.id)),
        name:       decorated.name,
        title:      decorated.title,
        rooms:      decorated.rooms,
        enabled_s:  decorated.enabled,
        enabled_m:  decorated.enabled,
        created_at: decorated.created_at,
        updated_at: decorated.updated_at,
        DT_RowId:   decorated.id,
      }
    end
  end


  def get_raw_records
    User.all
  end


  def additional_data
    super.merge({
      dt_dropdown_data(:enabled_s) => select_options_for_boolean,
      dt_dropdown_data(:enabled_m) => select_options_for_boolean,
    })
  end

end
