class Persona < ApplicationRecord
  belongs_to :tipo_persona
  has_one :usuario

  validates :nombre, :correo, :telefono_principal, presence: true
end
