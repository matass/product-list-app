# frozen_string_literal: true

RSpec.describe ProductTag, type: :model do
  subject { described_class.new }

  context 'ProductTag model validation' do
    it 'should belong to product' do
      product_association = described_class.reflect_on_association(:product)
      expect(product_association.macro).to eq(:belongs_to)
    end

    it 'should belong to tag' do
      tag_association = described_class.reflect_on_association(:tag)
      expect(tag_association.macro).to eq(:belongs_to)
    end
  end
end
