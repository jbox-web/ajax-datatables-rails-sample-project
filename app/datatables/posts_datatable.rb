# frozen_string_literal: true

class PostsDatatable < ApplicationDatatable

  RANGE_DELIMITER = '-yadcf_delim-'

  def view_columns
    @view_columns ||= {
      check_box:  { source: 'Post.id', orderable: false, searchable: false },
      name:       { source: 'Post.name' },
      title:      { source: 'Post.title' },
      rooms:      { source: 'Post.rooms',      cond: range_search },
      rooms_cond: { source: 'Post.rooms',      searchable: false },
      rooms2:     { source: 'Post.rooms',      cond: dynamic_numeric_condition(source: :rooms_cond) },
      enabled_s:  { source: 'Post.enabled',    cond: :eq },
      enabled_m:  { source: 'Post.enabled',    cond: :in, use_regex: false, formatter: ->(str) { cast_regex_value(str) } },
      created_at: { source: 'Post.created_at', cond: :date_range, delimiter: RANGE_DELIMITER },
      updated_at: { source: 'Post.updated_at', cond: :date_range, delimiter: RANGE_DELIMITER },
    }
  end


  def data
    records.map do |decorated|
      {
        check_box:  decorated.to_checkbox(selected: selected.include?(decorated.id)),
        name:       decorated.name,
        title:      decorated.title,
        rooms:      decorated.rooms,
        rooms_cond: decorated.rooms,
        rooms2:     decorated.rooms,
        enabled_s:  decorated.enabled,
        enabled_m:  decorated.enabled,
        created_at: decorated.created_at,
        updated_at: decorated.updated_at,
        DT_RowId:   decorated.id,
      }
    end
  end


  def get_raw_records
    Post.all
  end


  def additional_data
    super.merge({
      dt_dropdown_data(:rooms_cond) => select_options_for_numeric_filter,
      dt_dropdown_data(:enabled_s)  => select_options_for_boolean,
      dt_dropdown_data(:enabled_m)  => select_options_for_boolean,
    })
  end

end
