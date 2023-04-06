namespace :response do
  desc '今日通知が必要かチェックする'
  # コンソールから rake task:check_today で動作確認
  task check_today: :environment do
    # items1 = Item.where('updated_at < ?', 1.week.ago) # 動作確認の際は、変える
    items1 = [Item.first]
    # items1 = Item.where('updated_at < ?', 5.second.ago) # 動作確認の際は、変える
    items2 = [Item.second]
    # items2 = Item.where('updated_at < ?', 5.second.ago) # 動作確認の際は、変える
    items3 = []
    # items3 = Item.where('updated_at < ?', 5.second.ago) # 動作確認の際は、変える
    items4 = []
    # items4 = Item.where('updated_at < ?', 5.second.ago) # 動作確認の際は、変える

    # Userごとにtextを組み立てて通知を送る
    items1&.each do |item|
      text = <<~TEXT
        1週間前にこの商品を検討してたよ！
        #{item.url}
        検討の結果を教えてね！
        1 Buy
        2 Stop
        3 Think
      TEXT

      # userに通知を送る
      linebot = Linebot.new
      linebot.push(item.user, text)
    end

    items2&.each do |item|
      text = <<~TEXT
        2週間前にこの商品を検討してたよ！
        #{item.url}
        検討の結果を教えてね！
        1 Buy
        2 Stop
        3 Think
      TEXT

      # userに通知を送る
      linebot = Linebot.new
      linebot.push(item.user, text)
    end

    items3&.each do |item|
      text = <<~TEXT
        3週間前にこの商品を検討してたよ！
        #{item.url}
        検討の結果を教えてね！
        1 Buy
        2 Stop
        3 Think
      TEXT

      # userに通知を送る
      linebot = Linebot.new
      linebot.push(item.user, text)
    end

    items4&.each do |item|
      text = <<~TEXT
        TODO: 何かitem1用のメッセージを書く
        1ヶ月前にこの商品を購入したよ！
        #{item.url}
        この商品が気に入ってるか教えてね！
        1 Like
        2 Not Like
      TEXT

      # userに通知を送る
      linebot = Linebot.new
      linebot.push(item.user, text)
    end
  end
end
