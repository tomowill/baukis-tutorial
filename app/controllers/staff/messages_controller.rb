class Staff::MessagesController < Staff::Base
  def count
    render text: CustomerMessage.unprocessed.count
  end
end
