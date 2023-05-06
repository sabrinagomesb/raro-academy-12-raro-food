# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Telephone do
  describe 'Associations' do
    it { is_expected.to belong_to(:contactable) }
  end

  describe 'Validation definitions' do
    subject(:telephone) { build(:telephone) }

    it { is_expected.to validate_presence_of(:number) }

    it {
      expect(telephone).to validate_length_of(:number)
        .is_equal_to(11)
    }
  end

  describe 'Model' do
    subject(:telephone) { build(:telephone) }

    it 'is invalid when number is nil' do
      telephone.number = nil
      expect(telephone).not_to be_valid

      telephone.save
      expect(telephone.errors[:number]).to eq ["can't be blank", 'is the wrong length (should be 11 characters)']
    end

    it 'is invalid when number is an empty string' do
      telephone.number = ''
      expect(telephone).not_to be_valid

      telephone.save
      expect(telephone.errors[:number]).to eq ["can't be blank", 'is the wrong length (should be 11 characters)']
    end

    it 'is invalid when the number has more than 11 digits' do
      telephone.number = Faker::Number.number(digits: 12)
      expect(telephone).not_to be_valid

      telephone.save
      expect(telephone.errors[:number]).to eq ['is the wrong length (should be 11 characters)']
    end

    it 'is saved when all attributes is valid' do
      expect(telephone).to be_valid

      telephone.save
      expect(telephone.errors).to be_empty
    end
  end
end
