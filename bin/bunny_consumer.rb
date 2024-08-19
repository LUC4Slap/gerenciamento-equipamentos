#!/usr/bin/env ruby
require 'uri'
require 'bunny'

require File.expand_path('../config/environment', __dir__)

# Cria a conexão com o RabbitMQ
amqp_url = URI::Generic.build(
  scheme: 'amqp',
  userinfo: 'usuario:Senha%40123',
  host: 'localhost'
).to_s
connection = Bunny.new(amqp_url)
connection.start
channel = connection.create_channel

# Cria a fila para processamento
queue = channel.queue('notification_queue', durable: true, auto_delete: false)

puts "\nStarting consumer!"

# Captura da fila out (que usamos na outra app) as mensagens existentes
fanout_name = 'notifications_email.out'

# Ao declarar o exchange, use as mesmas configurações usadas na outra aplicação
exchange = channel.fanout(fanout_name, durable: true)

queue.bind(exchange)
puts "[consumer] #{queue.name} binds to #{fanout_name}"

# Inicia o processamento da mensagem
queue.subscribe(block: true) do |d_info, properties, payload|
  # teste = JSON.parse(payload)
  # puts teste['email']
  Email.create_and_send(JSON.parse(payload))
  puts "[consumer] #{queue.name} received #{properties[:type]}, from #{properties[:app_id]}: #{payload}\n"
end

begin
    while true
        sleep(3)
    end
rescue Interrupt
    connection.close
    puts "\nShutting down gracefully."
    exit
end
