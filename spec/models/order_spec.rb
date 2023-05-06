# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order do
  describe 'Associations' do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to belong_to(:delivery_address).class_name('Address') }

    it { is_expected.to have_many(:items).class_name('OrderItem').dependent(:destroy) }
    it { is_expected.to have_many(:dishes).through(:items) }

    it { is_expected.to have_one(:city).through(:delivery_address) }
  end

  describe 'Validation definitions' do
    subject(:order) { build(:order) }

    it {
      expect(order).to define_enum_for(:status)
        .with_values(
          started: 1, request: 2, preparing: 3, sent: 4,
          delivered: 5, finished: 6, canceled: 7
        )
    }

    it {
      expect(order).to accept_nested_attributes_for(:delivery_address).allow_destroy(true)
    }

    it {
      expect(order).to accept_nested_attributes_for(:items).allow_destroy(true)
    }
  end

  describe 'Model Methods' do
    describe '#update_total_price' do
      let(:unavailable_dish) { create(:dish) }
      let(:first_available_dish) { create(:dish, :active, :available) }
      let(:second_available_dish) { create(:dish, :active, :available) }
      let(:order) { create(:order) }

      it 'validates if total_price is zero when there are no items added' do
        expect(order.items).to be_empty
        expect(order.total_price).to be_zero
      end

      it 'throws exception when inserting unavailable dish' do
        expect(
          order.items.create(dish: unavailable_dish).errors[:dish_id]
        ).to eq ['is not an active and available item']
      end

      it 'updates total_price when a new item is added' do
        expect(order.items).to be_empty
        added_item = order.items.create(dish: first_available_dish)
        expect(order.items.length).to eq 1
        expect(order.total_price).to eq(added_item.total_per_item)
      end

      it 'must update the total_price when the amount of an item is updated' do
        initial_calc = order.items.create(dish: first_available_dish).total_per_item
        expect(order.total_price).to eq initial_calc
        order.items.last.update(amount: 5)
        new_cal = order.items.last.reload.total_per_item
        expect(order.total_price).to eq new_cal
      end

      it 'must udpate the total_price when an item exists and a new item has been added' do
        first_calc = order.items.create(dish: first_available_dish).total_per_item
        second_calc = order.items.create(dish: second_available_dish).total_per_item
        expect(order.items.length).to eq 2
        expect(order.total_price).to eq first_calc + second_calc
      end

      it 'must reset the total_price when there is an item and this item is deleted' do
        order.items.create(dish: first_available_dish)
        expect(order.items.length).to eq 1
        order.items.last.destroy
        expect(order.items.reload).to be_empty
        expect(order.total_price).to be_zero
      end
    end
  end
end
