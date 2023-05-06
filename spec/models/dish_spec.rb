# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dish do
  describe 'Associations' do
    it { is_expected.to belong_to(:chef) }
    it { is_expected.to have_and_belong_to_many(:categories) }

    it { is_expected.to have_many(:items).class_name('OrderItem').dependent(:destroy) }
  end

  describe 'Validation definitions' do
    subject(:dish) { build(:dish) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:unit_price) }

    it {
      expect(dish).to allow_value(%w[true false]).for(:available)
    }

    it {
      expect(dish).to allow_value(%w[true false]).for(:active)
    }

    it {
      expect(dish).to validate_numericality_of(:unit_price)
        .is_greater_than(0)
    }
  end

  describe 'Model Methods' do
    describe '#can_be_sold?' do
      let(:dish) { create(:dish) }

      it 'must be false if available is false and active is false' do
        expect(dish).not_to be_can_be_sold
      end

      it 'must be false if available is true and active is false' do
        dish.available = true
        expect(dish).not_to be_can_be_sold
      end

      it 'must be false if available is false and active is true' do
        dish.active = true
        expect(dish).not_to be_can_be_sold
      end

      it 'must be true if available is true and active is true' do
        dish.active = true
        dish.available = true
        expect(dish).to be_can_be_sold
      end
    end
  end
end
