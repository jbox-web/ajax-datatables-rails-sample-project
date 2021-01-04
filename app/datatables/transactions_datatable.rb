# frozen_string_literal: true

class TransactionsDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      id:     { source: 'Transaction.id', cond: :eq },
      seller: { source: 'User.name', cond: :like },
      buyer:  { source: 'User.name', cond: :like },
      amount: { source: 'Transaction.amount', searchable: false, orderable: true }
    }
  end


  def data
    records.map do |transaction|
      {
        id:     transaction.id,
        seller: transaction.seller.name,
        buyer:  transaction.buyer.name,
        amount: transaction.amount
      }
    end
  end


  def get_raw_records
    Transaction.includes(:seller, :buyer)
  end

end
