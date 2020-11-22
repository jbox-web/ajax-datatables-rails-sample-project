class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string  :title
      t.text    :content
      t.integer :rooms
      t.boolean :enabled

      t.timestamps
    end
  end
end
