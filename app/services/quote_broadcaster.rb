class QuoteBroadcaster
  def initialize(source)
    @source = source
    @last_value = nil
  end

  def perform
    if Time.at(QuoteGuardian.instance.timestamp || 0) + 1.hour <= Time.now
      QuoteGuardian.instance.update(@source)
    end
    curr_value = QuoteGuardian.instance.value
    if curr_value != @last_value
      ActionCable.server.broadcast("quote", curr_value)
      @last_value = curr_value
    end
  end
end
