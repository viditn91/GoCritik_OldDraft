class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :name
      t.string :display_name
      t.string :input_type
      t.string :field_type
      t.text :options
      t.string :default_value

      t.timestamps
    end
  end
end
