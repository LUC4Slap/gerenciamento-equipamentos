# frozen_string_literal: true
require 'uri'
class BunnyClient
  class << self
    def connect!
      amqp_url = URI::Generic.build(
        scheme: 'amqp',
        userinfo: 'usuario:Senha%40123',
        host: 'localhost'
      ).to_s

      @connection = Bunny.new(amqp_url)
      @connection.start
      @channel = @connection.create_channel

      # Crie um exchange direto para teste
      @exchange = @channel.direct('notifications_direct', durable: true)

      # Vincule uma fila ao exchange direto (para testes)
      @queue = @channel.queue('notification_queue', durable: true)
      @queue.bind(@exchange, routing_key: 'notification_key')

      @connected = true
    end

    def push(payload)
      connect! unless @connected

      begin
        # Publicar a mensagem no exchange com routing key
        @exchange.publish(payload, routing_key: 'notification_key', app_id: 'notifications_email')
      rescue Bunny::Exception => e
        Rails.logger.error("Erro ao publicar no RabbitMQ: #{e.message}")
        @connected = false
        connect!
        retry
      end

      true
    end
  end
end
# user e senha RabbitMQ
# user: usuario
# senha: Senha@123
# 'amqp://localhost:5672'
