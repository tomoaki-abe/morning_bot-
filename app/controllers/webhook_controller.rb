class WebhookController < ApplicationController
  require 'line/bot'

def kokodayo
  message = {
            "type": "text",
            "text": "ココア"
           }
            client = Line::Bot::Client.new { |config|
              config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
              config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
           }
  response = client.push_message(ENV["LINE_USER_ID"], message)
  end
end