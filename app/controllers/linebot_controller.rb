class LinebotController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'

  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)

    events.each { |event|

      if event.message['text'].include?("パスワード")
        response = "test1"
      elsif event.message['text'].include?("覚悟")
        response = "ふん、意気込みだけでは儂に勝てぬぞ"
      else event.message['text'].include?("姫はどこだ")
        response = "そんな小娘のことより、己自身の心配をせい"
     
      end


        
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: "template",
            altText: "this is a confirm template",
            template: {
                type: "confirm",
                text: "Are you sure?",
                actions: [
                    {
                      type: "message",
                      label: "Yes",
                      text: "yes"
                    },
                    {
                      type: "message",
                      label: "No",
                      text: "no"
                    }
                ]
            }
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    }

    head :ok
  end
end