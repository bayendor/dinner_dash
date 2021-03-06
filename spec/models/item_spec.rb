require 'rails_helper'

RSpec.describe Item, :type => :model do
  let(:category) { Category.new(name: 'breakfast') }
  let(:item) { Item.new(valid_attributes) }
  let(:valid_attributes) { {
    title: 'coffee',
    description: 'legal stimulants for cheap',
    price: 2.99,
    categories: [category]
  } }

  it 'is valid' do
    expect(item).to be_valid
  end

  it 'is invalid without a title' do
    item.title = nil
    expect(item).to be_invalid
  end

  it 'is invalid without a description' do
    item.description = nil
    expect(item).to be_invalid
  end

  it 'is invalid without a price' do
    item.price = nil
    expect(item).to be_invalid
  end

  it 'belongs to at least one category' do
    item.categories = []
    expect(item).to be_invalid
  end

  it 'should connect to categories' do
    expect(item.categories.first.name).to eq('breakfast')
  end

  it 'is not valid if title is an empty' do
    item.title = ""
    expect(item).to be_invalid
  end

  it 'is not valid if description is empty' do
    item.description = ""
    expect(item).to be_invalid
  end

  it 'must have a unique title' do
    item.save
    item2 = Item.create(valid_attributes)
    expect(item2).to be_invalid

    item2.title = 'espresso'
    expect(item2).to be_valid
  end

  it 'is invalid if the price is less than zero' do
    item.price = -1.00
    expect(item).to be_invalid
  end

  it 'is invalid if price is anything other than a decimal numeric value' do
    item.price = "alkdj"
    expect(item).to be_invalid
  end

  it 'has a default photo if empty' do
    item.photo = nil
    expect(item.photo.options.has_key?(:default_url)).to be true
    expect(item.photo.options.has_value?('/images/missing_large.png')).to be true
  end
end
