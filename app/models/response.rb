class Response < String
  attr_accesor :text

  def initialize(text = '')
    super
    @text = text
  end

  def add_stop_message
    self.text += <<~TEXT
      これまでに我慢した商品の合計は○点になったよ！
      金額は合計で○円節約できたよ！

      この調子で衝動買いを減らして行こう！！
    TEXT
  end

  def add_think_message
    self.text += <<~TEXT
      再検討だね！
      1週間後にまた連絡するね！
    TEXT
  end

  def add_think_more_message
    self.text += <<~TEXT
      再々検討だね！
      1週間後にまた連絡するね！
    TEXT
  end

  def add_think_more_two_message
    self.text += <<~TEXT
      再々々検討だね！
      もしかするともっといい商品や、購入するのに良いタイミングがあるのかもしれないね🤔
      
      1週間後にまた連絡するね！
    TEXT
  end

  def add_end_message
    self.text += <<~TEXT
      再検討だね！

      これまで4週間しっかり検討してきたよ！
      欲しいな〜、あったらいいな〜って思うものでも必要なものではなかったりすることもいっぱいあるんだ😞

      今持っているもので代わりに鳴るものがないか、
      その商品がなければできないこととか、1度整理してみるのもおすすめだよ！
    TEXT
  end

  def think_more_not_buy_message
    self.text += <<~TEXT
      購入をやめたんだね！
      しっかり検討した結果だから、もっといい商品があるのかも、、、？🤔

      これまでに我慢した商品数が○点になったよ！
      合計で○円節約できたよ！

      このまま衝動買いを無くして行こう！！
    TEXT
  end

  def add_bought_message
    self.text += <<~TEXT
      購入したんだね！
      お気に入りになるといいね！
    TEXT
  end

  def add_think_more_bought_message
    self.text += <<~TEXT
      購入したんだね！
      しっかり検討したからきっと気に入ると思うよ！
    TEXT
  end

  def add_one_month_message
    self.text += <<~TEXT
      先月購入した商品は気に入ってるか教えてね！
      1. Like
      2. Not Like(購入した金額を入力してね)
    TEXT
  end

  def add_like_message
    self.text += <<~TEXT
      お気に入りなんだね！
      いいお買い物ができて嬉しいよ！
    TEXT
  end

  def add_not_like_message
    self.text += <<~TEXT
      何かイメージと違ったのかな、、、？

      これまでのNot Likeリストの金額が○○円になりました、、、😢
    TEXT
  end

  def add_alert_message
    self.text += '正しく入力してね！'
  end