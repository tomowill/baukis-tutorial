require "rails_helper"
require_relative "../../../app/services/staff/authenticator.rb"

describe Staff::Authenticator do
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

    example 'Not Started, return false' do
      m = build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end

    example 'Finished, return false' do
      m = build(:staff_member, end_date: Date.today)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end
  end
end
