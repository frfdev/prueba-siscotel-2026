class Usuario < ApplicationRecord
  belongs_to :tipo_documento
  belongs_to :persona, dependent: :destroy

  accepts_nested_attributes_for :persona

  validates :n_documento, :fecha_emision, :fecha_vencimiento, presence: true
end
