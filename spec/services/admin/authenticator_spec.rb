require "rails_helper"
require_relative "../../../app/services/admin/authenticator.rb"

describe Admin::Authenticator do
  describe '#authenticate' do
    example 'Given a correct password, return true' do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    example 'Given a uncorrect password, return false' do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate('xy')).to be_falsey
    end

    example 'Not Given a password, return false' do
      m = build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    example 'Set a stop flag, return false' do
      m = build(:staff_member, suspended: false)
      expect(Staff::Authenticator.new(m).suspendedcheck()).to be_falsey
    end
  end
end
