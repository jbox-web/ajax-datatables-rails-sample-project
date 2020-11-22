# frozen_string_literal: true

class CityDatatable < ApplicationDatatable

  def view_columns
    @view_columns ||= {
      check_box:     { source: 'City.id', orderable: false, searchable: false },
      name:          { source: 'City.name' },
      iata:          { source: 'City.iata' },
      country_name:  { source: 'City.country_id', cond: filter_country_condition },
      custom_column: { source: 'custom_column',   cond: filter_custom_column_condition },
    }
  end


  def data
    records.map do |record|
      {
        check_box:     record.decorate.to_checkbox(selected: selected.include?(record.id)),
        name:          record.name,
        iata:          record.iata,
        country_name:  record.country.try(:name),
        custom_column: record[:custom_column],
      }
    end
  end


  def get_raw_records
    City.select('cities.*, timezone AS custom_column').includes(:country)
  end



  def additional_data
    super.merge({
      dt_dropdown_data(:country_name) => select_options_for_country_name,
    })
  end


  def records(opts = {})
    super opts.merge(decorate: false)
  end


  private


    def filter_country_condition
      ->(column, value) { column.table[column.field].eq(column.search.value.to_i + 1) }
    end


    def filter_custom_column_condition
      ->(column, value) { ::Arel::Nodes::SqlLiteral.new(column.field.to_s).matches("#{ column.search.value }%") }
    end

end
