class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]

  validates_numericality_of :price
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :inventory, only_integer: true
  validates_numericality_of :inventory, greater_than_or_equal_to: 0

  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def self.active_only
    where(active?: true)
  end

  def self.by_quantity_ordered(direction = "ASC")
    joins(:item_orders)
    .select('items.*, sum(item_orders.quantity) as quantity_ordered')
    .group(:id)
    .order("quantity_ordered #{direction}")
    .limit(5)
  end

  def self.by_average_rating(direction = "ASC")
    eligible_items = joins(:merchant, :orders)
                      .where(merchants: {enabled?: true})
                      .where(items: {active?: true})
                      .where(orders: {status: :shipped})
                      .group(:id)
                      .having('count(*) > 100')

    eligible_items.joins(:reviews)
                  .group(:id)
                  .select("items.*, avg(reviews.rating) as average_rating")
                  .order("average_rating #{direction}")
                  .limit(5)
  end

  def reduce_inventory(quantity)
    self.inventory -= quantity
  end

  def increase_inventory(quantity)
    self.inventory += quantity
  end
end
