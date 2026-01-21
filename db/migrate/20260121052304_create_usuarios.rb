class CreateUsuarios < ActiveRecord::Migration[8.1]
  def change
    create_table :usuarios do |t|
      t.string :n_documento
      t.references :tipo_documento, null: false, foreign_key: true
      t.references :persona, null: false, foreign_key: true
      t.date :fecha_emision
      t.date :fecha_vencimiento

      t.timestamps
    end
  end
end
