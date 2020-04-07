class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :item_orders, through: :items
  has_many :users

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :enabled?

  def no_orders?
    item_orders.empty?
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    orders.distinct.joins(:user).pluck(:city)
  end

  def orders
    Order.where(id: ItemOrder.where(item_id: items.pluck(:id)).pluck(:order_id))
  end

  def pending_orders
    orders.where(status: 1)
  end

  def item_orders_in_order(order)
    order.item_orders.where(item_id: items.pluck(:id))
  end

  def total_items_in_order(order)
    item_orders_in_order(order).sum(:quantity)
  end

  def total_value_in_order(order)
    # order.item_orders.where(item_id: items.pluck(:id)).sum('price * quantity')
    order.item_orders.joins(:item).where(items: {merchant_id: self.id}).sum('item_orders.price * item_orders.quantity')

  end


end
