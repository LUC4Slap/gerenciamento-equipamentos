class Email < ApplicationMailer
  def create_and_send(payload)
    # message = new(
    #   email: payload['email'],
    #   to: payload['subject'],
    #   content: payload['content']
    # )

    email = EmailMailer.send_mail(
      from: payload['email'],
      subject: payload['subject'],
      body: payload['content'],
    )

    # puts "No email"
    p message
    # message.save!
    # send_message(message)
    begin
      email.deliver_now
    rescue EmailMailer::Exception => e
      Rails.logger.error("Erro ao publicar no RabbitMQ: #{e.message}")
      # @connected = false
      # connect!
      # retry
    end
  end

  def self.send_message(message)
    MessageMailer.with(message: message).send_email.deliver_now
  end
end
