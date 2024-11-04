def check_out
  return if owner.wallet.balance < total_amount

  # カート内のすべてのアイテムについて処理を行う
  @items.each do |item|
    # カートのオーナーのウォレットからアイテムの価格を引き出し、アイテムのオーナーのウォレットに入金する
    item_price = item.price
    owner.wallet.withdraw(item_price)
    item.owner.wallet.deposit(item_price)

    # アイテムのオーナー権限をカートのオーナーに移す
    item.owner = owner
  end

  # カートの中身を空にする
  @items.clear
end
