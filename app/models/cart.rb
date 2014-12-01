class Cart
  attr_reader :data

  def initialize(data)
    @data = data || {}
  end

  def add_item(item)
    data[item.id.to_s] ||= 0
    data[item.id.to_s] += 1
  end

  def count_of(item)
    data[item.id.to_s]
  end

  def count_total
    data.values.sum
  end

  def items
    data.map { |item, _quantity| Item.find(item) }
  end

  def order_items
    o = []
    data.each { |k, v| v.times { o << Item.find(k) } }
    o
  end

  def cost_total
    items.reduce(0) { |sum, item| sum + (item.price * data[item.id.to_s]) }
  end
end
