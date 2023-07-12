namespace :response do
  desc '今日通知が必要かチェックする'
  # コンソールから rake task:check_today で動作確認
  task check_today: :environment do
    # items1 = Item.where('updated_at < ?', 1.week.ago).order(id: :asc) # 動作確認の際は、変える
    items1 = [Item.first]
    # items1 = Item.where('updated_at < ?', 5.second.ago).order(id: :asc) # 動作確認の際は、変える
    items2 = [Item.second]
    # items2 = Item.where('updated_at < ?', 5.second.ago).order(id: :asc) # 動作確認の際は、変える
    items3 = []
    # items3 = Item.where('updated_at < ?', 5.second.ago).order(id: :asc) # 動作確認の際は、変える
    items4 = []
    # items4 = Item.where('updated_at < ?', 5.second.ago).order(id: :asc) # 動作確認の際は、変える

    # とりあえずなし！
    # レスポンス待ちのitemを一時保管しておくresponse_mati_itemsテーブルを作成する
    # user.response_mati_items << [items1, items2, items3, items4].flatten
    # # [[1 ,2], 3, [4, 5], [6]].flatten => [1, 2, 3, 4, 5, 6]

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

# namespase :stop_tasks do
#   desk "stopを選択したユーザーへの通知"
#   task :send_stop_message => :environment do
#     items = Item.where("updated_at < ?", 1.week.ago).where(status: "stop")

#     items.each do |item|
#       # add_stop_messsageの送信処理をここに実装する
#       puts "Sending think message for item: #{item.id}"
#     end
#   end
# end

namespase :bought_tasks do
  desk "buyを選択したユーザーへの1ヶ月後の通知が必要かチェックする"
  task :send_buy_message => :environment do
    items Item.where("updated_at > ?", 1.month.ago).where(status: "buy")

    items.each do |item|

      # puts "Sending buy message for item: #{item.id}"
      text = <<~TEXT
        購入したんだね！
        しっかり検討したからきっと気に入るといいね！！
      TEXT

      linebot = Linebot.new
      linebot.push(item.user, text)
    end
  end
end

namespace :think_tasks do
  desc "1回目のthinkを選択したユーザーへの通知"
  task :send_think_message => :environment do
    items = Item.where("updated_at < ?", 1.week.ago).where(status: "think")

    items.each do |item|
      # add_think_messageの送信処理をここに実装する
      # 例: item.add_think_message
      # puts "Sending think message for item: #{item.id}"
      text = <<~TEXT
        再検討だね！
        1週間後にまた連絡するね！
      TEXT

      linebot = Linebot.new
      linebot.push(item.user, text)
    end
  end

  desc "2回目のthinkを選択したユーザーへの通知"
  task :send_think_more_message => :environment do
    items = Item.where("updated_at < ?", 2.weeks.ago).where(status: "think")

    items.each do |item|
      # add_think_more_messageの送信処理をここに実装する
      # 例: item.add_think_more_message
      # puts "Sending think more message for item: #{item.id}"
      text = <<~TEXT
        再々検討だね！
        1週間後にまた連絡するね！
      TEXT

      linebot = Linebot.new
      linebot.push(item.user, text)
    end
  end

  desc "3回目のthinkを選択したユーザーへの通知"
  task :send_think_more_message => :environment do
    items = Item.where("updated_at < ?", 3.weeks.ago).where(status: "think")

    items.each do |item|
      # add_think_more_messageの送信処理をここに実装する
      # 例: item.add_think_more_message
      # puts "Sending think more two message for item: #{item.id}"
      text = <<~TEXT
        再々々検討だね！
        もしかするともっといい商品や、購入するのに良いタイミングがあるのかもしれないね🤔
        
        1週間後にまた連絡するね！！
      TEXT

      linebot = Linebot.new
      linebot.push(item.user, text)
    end
  end
  
  desc "4回目のthinkを選択したユーザーへの通知"
  task :send_think_more_message => :environment do
    items = Item.where("updated_at < ?", 4.weeks.ago).where(status: "think")

    items.each do |item|
      # add_think_more_messageの送信処理をここに実装する
      # 例: item.add_think_more_message
      #puts "Sending think end message for item: #{item.id}"
      text = <<~TEXT
        再検討だね！

        これまで4週間しっかり検討してきたよ！
        欲しいな〜、あったらいいな〜って思うものでも必要なものではなかったりすることもいっぱいあるんだ😞

        今持っているもので代わりに鳴るものがないか、
        その商品がなければできないこととか、1度整理してみるのもおすすめだよ！
      TEXT

      linebot = Linebot.new
      linebot.push(item.user, text)
    end
  end
end
