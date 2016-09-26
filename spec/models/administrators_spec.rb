require 'spec_helper'

RSpec.describe Administrators, :type => :model do
  describe '#password=' do
    example 'Given strings, hashed_password will be 60 character.' do
      member = Administrators.new
      member.password = 'baukis'
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end
  end
end
