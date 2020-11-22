# frozen_string_literal: true

module DatatableSelection
  extend ActiveSupport::Concern

  def datatable
    set_data_in_session(:selected, get_selected_ids)
    super
  end


  def reset_selection
    do_reset_selection
    render json: true
  end


  def select_all
    # set_data_in_session(:not_selected, [])
    # run "#{trailblazer_concept}::Operation::Datatable".constantize do |result|
    #   set_data_in_session(:selected, result[:model].records.map(&:id).sort)
    #   return render json: true
    # end
  end


  private


    def datatable_params
      super.merge(selected: get_data_in_session(:selected))
    end


    def do_reset_selection
      set_data_in_session(:selected, [])
      set_data_in_session(:not_selected, [])
    end

end
