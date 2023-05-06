# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chef do
  describe 'Associations' do
    it { is_expected.to belong_to(:user).dependent(:destroy) }
    it { is_expected.to belong_to(:approver).class_name('Administrator') }
    it { is_expected.to belong_to(:address).inverse_of(:chef) }

    it { is_expected.to have_one(:city).through(:address) }
    it { is_expected.to have_one(:state).through(:city) }

    it { is_expected.to have_many(:telephones).dependent(:destroy) }
    it { is_expected.to have_many(:dishes).dependent(:destroy).inverse_of(:chef) }
  end

  describe 'Validation definitions' do
    subject(:chef) { build(:chef) }

    it {
      expect(chef).to accept_nested_attributes_for(:user)
    }

    it {
      expect(chef).to accept_nested_attributes_for(:address)
    }

    it {
      expect(chef).to accept_nested_attributes_for(:telephones).allow_destroy(true)
    }

    it {
      expect(chef).to accept_nested_attributes_for(:dishes).allow_destroy(true)
    }
  end

  describe 'Model' do
    subject(:chef) { build(:chef) }

    it 'is invalid when the approver is not defined' do
      chef.approver = nil
      chef.save
      expect(chef.errors[:approver]).to eq ['must exist']
    end

    it 'is invalid when the address is not defined' do
      chef.address = nil
      chef.save
      expect(chef.errors[:address]).to eq ['must exist']
    end

    it 'is valid when all attributes are valid' do
      chef.save
      expect(chef.errors).to be_empty
    end
  end
end
