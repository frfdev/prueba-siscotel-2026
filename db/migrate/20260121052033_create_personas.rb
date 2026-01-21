class CreatePersonas < ActiveRecord::Migration[8.1]
  def change
    create_table :personas do |t|
      t.string :nombre
      t.string :correo
      t.string :telefono_principal
      t.string :telefono_secundario
      t.references :tipo_persona, null: false, foreign_key: true

      t.timestamps
    end
  end
end
