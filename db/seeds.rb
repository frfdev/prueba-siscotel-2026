# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

TipoDocumento.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('tipo_documentos')

TipoPersona.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('tipo_personas')

Persona.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('personas')

Usuario.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('usuarios')

TipoDocumento.find_or_create_by(documento: "Cedula")
TipoDocumento.find_or_create_by(documento: "Pasaporte")
TipoDocumento.find_or_create_by(documento: "Rif")

TipoPersona.find_or_create_by(tipo: "Natural")
TipoPersona.find_or_create_by(tipo: "Juridico")