class RedisService
  attr_reader :key

  def initialize key: nil
    @key = key
    @redis = ActionCable.server.pubsub.send(:redis_connection)
  end

  def data
    if @redis.present?
      existent_data = @redis.get(self.key)
      if existent_data.present?
        return JSON.parse(existent_data)
      end
    end
    return {}
  end

  def set new_data
    if @redis.present?
      existent_data = self.data.merge! new_data
      @redis.set(self.key, existent_data.to_json)
    end
  end

  def clean
    @redis.set(self.key, {})
  end
end