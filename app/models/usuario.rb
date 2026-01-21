class Usuario < ApplicationRecord
  belongs_to :tipo_documento
  belongs_to :persona
end
