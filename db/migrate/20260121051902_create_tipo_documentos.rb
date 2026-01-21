class CreateTipoDocumentos < ActiveRecord::Migration[8.1]
  def change
    create_table :tipo_documentos do |t|
      t.string :documento

      t.timestamps
    end
  end
end
