class CreateDeadlineValues < ActiveRecord::Migration[5.0]
  def change
    create_table :deadline_values do |t|
      t.date :deadline
      t.decimal :value, precision: 8, scale: 2
      t.string :form_of_participation
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
