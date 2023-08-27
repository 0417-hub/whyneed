class Item < ApplicationRecord
  belongs_to :user

  # TODO: scopeでリプライ待ちのアイテムを検索する
  # @user.items.search_wating_for_reply としたとき、リプライ待ちのアイテムを検索する
  scope :search_wating_for_reply, -> { where(status: [1, 3, 5, 7, 9])}
                                      #  where("status LIKE ?", "%wait_to_reply%")
                                      #  where(status: [1, 3, 7, 11])

  # TODO: statusのenumを定義する！(リプライ待ちとそうでないitemをわかりやすく命名する)
  enum status: { 
    waiting_for_first_message_reply: 1, # ユーザーからの返信待ち
    not_waiting_received_url: 2,
    waiting_for_one_month_message_reply: 3, # ユーザーからの返信待ち
    not_waiting_stop_the_buy_message: 4,
    waiting_for_second_weeks_message_reply: 5,# ユーザーからの返信待ち
    not_waiting_within_one_month_message: 6,
    waiting_for_third_weeks_message_reply: 7, # ユーザーからの返信待ち
    not_waiting_after_send_like_message: 8,
    waiting_for_fourth_weeks_message_reply: 9, # やり取り終了
    not_waiting_after_send_not_like_message: 10,
    not_waiting_after_send_add_think_message: 12,
    not_waiting_after_send_add_think_more_message: 14,
    not_waiting_after_send_add_think_more_two_message: 16,
    not_waiting_after_send_add_think__end_message: 18
  }  
end
