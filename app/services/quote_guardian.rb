class QuoteGuardian
  include Singleton

  STORAGE_FILENAME = File.join(Rails.root, 'tmp', 'qg_state.yml')

  def initialize
    load_state
  end

  def set_temporary_value(val, expiration_date)
    @state[:temp_value] = val
    @state[:expiration_date] = expiration_date
    save_state
  end

  def value
    @state[:expiration_date] && @state[:expiration_date] > Time.now ?
      @state[:temp_value] : @state[:real_value]
  end

  def temp_value
    @state[:temp_value]
  end

  def expiration_date
    @state[:expiration_date]
  end

  def timestamp
    @state[:timestamp]
  end

  def update(source)
    @state[:real_value] = source.fetch
    @state[:timestamp] = Time.now.to_i
    save_state
  end

  def reset
    File.delete(STORAGE_FILENAME) rescue nil
    @state = {}
  end
    
private
  def load_state
    @state = File.exists?(STORAGE_FILENAME) ?
      YAML.load(File.read(STORAGE_FILENAME)) : {}
  end

  def save_state
    File.open(STORAGE_FILENAME, 'w') { |f| f.write(YAML.dump(@state)) }
  end
end
