class User < ApplicationRecord
  has_many :items, dependent: :destroy

  class << self
    # 1週間後にメッセージを送りたいユーザーの配列を返す
    def received_message_from_one_week
      # Itemのupdated_atで1週間経ったかどうかを判定
      # items = Item.where('updated_at < ?', 1.week.ago)
      # users = items.map(&:user)
      # return users
      # users = []
      # items.each do |item|
      #   # itemのuserを取得
      #   user = item.user      
      #   users << user
      # end
      Item.where('updated_at < ?', 1.week.ago).pluck(:user)
    end

    def received_message_from_two_weeks
      # TODO: ここも同じように書く！
      Item.where('updated_at < ?', 2.week.ago).pluck(:user)
    end

    # TODO: 3,4も書く
    def received_message_from_three_weeks
      # TODO: ここも同じように書く！
      Item.where('updated_at < ?', 3.week.ago).pluck(:user)
    end

    def received_message_from_one_month
      # TODO: ここも同じように書く！
      Item.where('updated_at < ?', 1.month.ago).pluck(:user)
    end
    
  end
end
