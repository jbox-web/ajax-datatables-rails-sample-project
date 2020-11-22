class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.references :country
      t.string     :name
      t.string     :iata
      t.string     :timezone

      t.timestamps
    end
  end
end
