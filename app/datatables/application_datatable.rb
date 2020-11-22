# frozen_string_literal: true

class ApplicationDatatable < AjaxDatatablesRails::ActiveRecord

  def selected
    @selected ||= (options[:selected] || [])
  end


  def records(opts = {})
    decorate = opts.fetch(:decorate, true)
    if decorate
      super().decorate(opts)
    else
      super()
    end
  end


  private


    def select_options_for_boolean
      [
        { value: 1, label: I18n.t('text.yes') },
        { value: 0, label: I18n.t('text.no') },
      ]
    end


    def select_options_for_country_name
      Country.all.map { |k| { value: k.id, label: k.name } }
    end



    def dt_dropdown_data(name)
      "dt_filter_data_#{column_id(name)}".to_sym
    end


    def cast_regex_value(value)
      value.split('|').map(&:to_i)
    end


    def range_search
      ->(column, value) do
        return nil if value == RANGE_DELIMITER
        range_start = value.split(RANGE_DELIMITER)[0]
        range_end   = value.split(RANGE_DELIMITER)[1]
        return nil if range_start.blank? && range_end.blank?
        return column.table[column.field].gteq(range_start) if range_end.blank?
        return column.table[column.field].lteq(range_end) if range_start.blank?
        column.table[column.field].between(AjaxDatatablesRails::Datatable::Column::DateFilter::DateRange.new(range_start, range_end))
      end
    end

end
