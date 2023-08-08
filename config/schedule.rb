require File.expand_path(File.dirname(__FILE__) + "/environment")

# 実行環境を指定する
set :environment, Rails.env.to_sym
# 実行logの出力先
set :output, "#{Rails.root.to_s}/log/cron.log"

every 1.day, at: '19:00pm' do # 1.minute 1.day 1.week 1.month 1.yearなどをサポート
  rake "response:check_today"
end

every 1.day, at: '19:00pm' do # 1.minute 1.day 1.week 1.month 1.yearなどをサポート
  rake "bought_tasks:send_buy_message"
end

every 1.day, at: '19:00pm' do # 1.minute 1.day 1.week 1.month 1.yearなどをサポート
  rake "think_tasks:send_think_message"
end

every 1.day, at: '19:00pm' do # 1.minute 1.day 1.week 1.month 1.yearなどをサポート
  rake "think_tasks:send_think_more_message"
end

every 1.day, at: '19:00pm' do # 1.minute 1.day 1.week 1.month 1.yearなどをサポート
  rake "think_tasks:send_think_more_two_message"
end

every 1.day, at: '19:00pm' do # 1.minute 1.day 1.week 1.month 1.yearなどをサポート
  rake "think_tasks:send_think_end_message"
end


