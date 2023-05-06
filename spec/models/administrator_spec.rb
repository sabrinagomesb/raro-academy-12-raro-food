# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Administrator do
  describe 'Associations' do
    it { is_expected.to belong_to(:user).dependent(:destroy) }
  end

  describe 'Validation definitions' do
    subject(:administrator) { build(:administrator) }

    it {
      expect(administrator).to accept_nested_attributes_for(:user)
    }
  end
end
