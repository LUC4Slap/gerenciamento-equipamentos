class Equipamento < ApplicationRecord
  after_save :publish!

  def publish!
    messge = {
      email: "lucaslap27@gmail.com",
      subject: "Equipamento cadastrado",
      content: "Teste mensagem fila"
    }
    BunnyClient.push(messge.to_json)
  end
end
