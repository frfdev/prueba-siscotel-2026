class CreateTipoPersonas < ActiveRecord::Migration[8.1]
  def change
    create_table :tipo_personas do |t|
      t.string :tipo

      t.timestamps
    end
  end
end
