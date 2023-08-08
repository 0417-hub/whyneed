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
          # TODO: itemのstatusには、ユーザーからのリプライ待ちかそうでないかの2種類ある（わかりやすい命名が必要!!）
          if event.message["text"].start_with?("https")
            # TODO: Item保存処理かく
            message = [{type: "text", text: "URLを受け取りました！"},
              {type: "text", text: event.message["text"]},
              {type: "text", text: '1週間後にまたご連絡します！'}
            ]
            reply_to_client(client, event['replyToken'], message)
            item = Item.new(url: event.message["text"])
            item.save
          end

          # TODO: itemモデルに定義したscopeを使ってitemsを代入する
          items = @user.items.search_wating_for_reply
          items.each do |item|
            # ここに全体を入れる？
            case item.status 
            when 'first_message' # item.statusが”3択質問後”の場合、
              case replied_message # ”3択質問の回答が以下の場合、
              when '1'
                @response.add_bought_message #購入した場合のメッセージ
              when '2'
                @response.add_stop_message #買わなかった場合のメッセージ
              when '3'
                @response.add_think_message #再検討の場合のメッセージ
              else
                @response.add_alert_message #正しく入力してやー
              end
  
              if 3 == message
                #add_think_messageを送信
                @response.add_think_message
                item.status = "think"
              elsif 1 == message
                #add_bought_messageを送信
                @response.add_bought_message
                item.status = "buy"
              elsif 2 == message
                #add_stop_messageを送信
                @response.add_stop_message
                item.status = "stop"
              end
  
              if item.status == "buy" && item.updated_at < 1.month.ago
                #item.statusがbuyで、updated_atが1ヶ月より前の場合の処理
                @response.add_one_month_message
                if message == 1
                  @response.add_like_message
                elsif message == 2
                  @response.add_not_like_message
                end
              end        
              if item.status == "think" && item.updated_at < 1.week.ago
                #item.statusがthinkで、updated_atが1週間より前の場合の処理
                @response.add_first_message
              elsif item.status == "think" && item.updated_at < 2.weeks.ago
                    # updated_atが2週間前で、statusがthinkの場合の処理
                @response.add_think_more_message
              elsif item.status == "think" && item.updated_at < 3.weeks.ago
                    # updated_atが3週間前で、statusがthinkの場合の処理
                @response.add_think_more_two_message
              elsif item.status == "think" && item.updated_at < 4.weeks.ago
                    # updated_atが4週間前で、statusがthinkの場合の処理
                @response.add_think_end_message
              end
              
  
            end
          end

          # ここから1週間後の書いてく
          # case item.status # item.statusになる？
          # when 'first_message' #別のものに変える
          #   case replied_message
          #   when '1'
          #     #@response.add_cancel_message #やり取り中止したで
          #     @response.add_bought_message #購入した場合のメッセージ
          #   when '2'
          #     #@response.add_asking_trash_name_message #ゴミの名前聞くメッセ送信
          #     #@user.registration!
          #     @response.add_stop_message #買わなかった場合のメッセージ
          #   when '3'
          #     #@response.add_show_trashes_message(@user) #ゴミリスト送信
          #     @response.add_think_message #再検討の場合のメッセージ
          #   else
          #     @response.add_alert_message #正しく入力してやー
          #   end

          #   if 3 == message
          #     #add_think_messageを送信
          #     @response.add_think_message
          #     item.status = "think"
          #   elsif 1 == message
          #     #add_bought_messageを送信
          #     @response.add_bought_message
          #     item.status = "buy"
          #   elsif 2 == message
          #     #add_stop_messageを送信
          #     @response.add_stop_message
          #     item.status = "stop"
          #   end

          #   if item.status == "buy" && item.updated_at < 1.month.ago
          #     #item.statusがbuyで、updated_atが1ヶ月より前の場合の処理
          #     @response.add_one_month_message
          #     if message == 1
          #       @response.add_like_message
          #     elsif message == 2
          #       @response.add_not_like_message
          #     end
          #   end        
          #   if item.status == "think" && item.updated_at < 1.week.ago
          #     #item.statusがthinkで、updated_atが1週間より前の場合の処理
          #     @response.add_first_message
          #   elsif item.status == "think" && item.updated_at < 2.weeks.ago
          #         # updated_atが2週間前で、statusがthinkの場合の処理
          #     @response.add_think_more_message
          #   elsif item.status == "think" && item.updated_at < 3.weeks.ago
          #         # updated_atが3週間前で、statusがthinkの場合の処理
          #     @response.add_think_more_two_message
          #   elsif item.status == "think" && item.updated_at < 4.weeks.ago
          #         # updated_atが4週間前で、statusがthinkの場合の処理
          #     @response.add_think_end_message
          #   end
            

          # end
        end
    end
  end
end