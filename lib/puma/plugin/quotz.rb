require 'puma/plugin'

Puma::Plugin.create do
  def start(launcher)
    broadcaster = QuoteBroadcaster.new(QuoteSourceCbr.new)
    in_background do
      loop do
        suppress(Exception) do
           broadcaster.perform
        end
        sleep 1
      end
    end
  end
end
