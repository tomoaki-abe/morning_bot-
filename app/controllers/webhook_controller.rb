class WebhookController < ApplicationController
  require 'line/bot'

def kokodayo
  message = {
    {
      "type": "template",
      "altText": "this is a confirm template",
      "template": {
          "type": "confirm",
          "text": "Are you sure?",
          "actions": [
              {
                "type": "message",
                "label": "Yes",
                "text": "yes"
              },
              {
                "type": "message",
                "label": "No",
                "text": "no"
              }
          ]
      }
    }
           }
            client = Line::Bot::Client.new { |config|
              config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
              config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
           }
  response = client.push_message(ENV["LINE_USER_ID"], message)
  end
end