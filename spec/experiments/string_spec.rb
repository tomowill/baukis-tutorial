require 'spec_helper'

describe String do
  describe '#<<' do
    example 'add string' do
      s = "ABC"
      s << "D"
      expect(s.size).to eq(4)
    end
    example 'cannot add nil string', :excep do
      s = "ABC"
      expect { s << nil }.to raise_error(TypeError)
    end
   end
end
