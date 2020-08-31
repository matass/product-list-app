# frozen_string_literal: true

RSpec.describe Product, type: :model do
  subject { described_class.new }

  context 'Product model validation' do
    it 'is not valid without attributes' do
      expect(subject).to_not be_valid
    end

    it 'is not valid with description attribute' do
      subject.description = 'Product decription #1'
      expect(subject).to_not be_valid
    end

    it 'is not valid with name attribute' do
      subject.name = 'Product name #1'
      expect(subject).to_not be_valid
    end

    it 'is valid with name and price attributes' do
      subject.name = 'Product name #2'
      subject.price = 1.32

      expect(subject).to be_valid
    end

    it 'should have many tags' do
      products = described_class.reflect_on_association(:tags)
      expect(products.macro).to eq(:has_many)
    end

    it 'should have a unique name' do
      described_class.create(name: 'Product name #3', price: 3)
      product = described_class.new(name: 'Product name #3', price: 1)

      expect(product).to_not be_valid

      expect(product.errors[:name]).to include('has already been taken')
    end
  end
end
