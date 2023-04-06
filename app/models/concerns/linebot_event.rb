module LinebotEvent
  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_id = ENV['LINE_CHANNEL_ID']
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end

  def validate_client_signature(body)
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    head :bad_request unless client.validate_signature(body, signature)
  end

  def push(user, text)
    message = {
      type: 'text',
      text: text
    }
    @response = client.push_message(user.line_id, message)
  end

  def reply_to_client(client, reply_token, message)
    response_message = {
      type: 'text',
      text: message
    }
    client.reply_message(reply_token, response_message)
  end

  def main_action(event)
    case event
    when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if event.message["text"].include?("https")
            message = [{type: "text", text: "URLを受け取りました！"},
              {type: "text", text: event.message["text"]},
              {type: "text", text: '1週間後にまたご連絡します！'}
            ]
          else
            message = {type: "text", text: "#{event.message["text"]}が送られました"}
          end
          client.reply_message(event['replyToken'], message)
        end
      end
  end
end
