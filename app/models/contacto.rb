class Contacto < ApplicationRecord
  belongs_to :carga

  def desencripta_tarjeta
    tarjeta = self.tarjeta

    if tarjeta.blank?
      return
    end

    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.dig(:secret_key_base)[0..31])
    decrypted_back = crypt.decrypt_and_verify(tarjeta)
    return decrypted_back.split(//).last(4).join

  rescue
    "invalido"
  end

  def self.encripta_tarjeta(tarjeta)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.dig(:secret_key_base)[0..31])
    encrypted_data = crypt.encrypt_and_sign(tarjeta)
  end

end
