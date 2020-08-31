# frozen_string_literal: true

RSpec.describe Tag, type: :model do
  subject { described_class.new }

  context 'Tag model validation' do
    it 'is not valid without attributes' do
      expect(subject).to_not be_valid
    end

    it 'is valid with titlle attributes' do
      subject.title = 'Tag title #1'
      expect(subject).to be_valid
    end

    it 'should have many products' do
      tags = described_class.reflect_on_association(:products)
      expect(tags.macro).to eq(:has_many)
    end

    it 'should have a unique title' do
      described_class.create(title: 'Tag title #2')
      tag = described_class.new(title: 'Tag title #2')

      expect(tag).to_not be_valid

      expect(tag.errors[:title]).to include('has already been taken')
    end
  end
end
