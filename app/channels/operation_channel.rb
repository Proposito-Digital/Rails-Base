class OperationChannel < ApplicationCable::Channel
  SUBSCRIBED = 'subscribed'
  CHOOSE_TOPIC = 'choose_topic'
  START_TOPIC = 'start_topic'
  PAUSE_TOPIC = 'pause_topic'
  CHANGE_TOPIC_DURATION = 'change_topic_duration'
  CHANGE_TOPIC_ORDER = 'change_topic_order'
  CHANGE_TOPIC_ANSWER = 'change_topic_answer'

  def subscribed
    on_subscribe
    stream_for @meet
    stream_from @user_stream
    ActionCable.server.broadcast(@user_stream, { action: SUBSCRIBED, current_topic: @redis.data['current_topic'], clock_running: @redis.data['clock_running'], current_clock_time: @redis.data['current_clock_time'] })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def message_all data
    ap data
    message = data['message']
    self.broadcast_to @meet, {message: message}
  end

  def choose_topic data
    @topic = @meet.topics.find_by(id: data['topic_id'])
    @redis.set({current_topic: @topic, running_time_seconds: 0})
    OperationChannel.broadcast_to(@meet, { action: CHOOSE_TOPIC, topic: @topic } )
  end

  def start_topic data
    if @topic.present? and @topic.start_at.present?
      if @topic.update start_at: DateTime.now
        @topic.meet.update start_at: DateTime.now unless @topic.meet.start_at.present?
      end
    end
    @redis.set({current_topic_duration: @topic.duration, current_topic_start_at: @topic.start_at, clock_running: true})
    OperationChannel.broadcast_to(@meet, { action: START_TOPIC, clock_time: @topic.duration } )
  end

  def pause_topic data
    set_running_time
    @redis.set({clock_running: false})
    OperationChannel.broadcast_to(@meet, { action: PAUSE_TOPIC, clock_time: @topic.duration } )
  end

  def change_topic_duration data
    if @topic.update duration: data['new_duration']
      @redis.set({current_topic_duration: @topic.duration})
      OperationChannel.broadcast_to(@meet, { action: CHANGE_TOPIC_DURATION, new_duration: @topic.duration  } )
    end
  end

  def change_topic_order
    OperationChannel.broadcast_to(@meet, { action: CHANGE_TOPIC_ORDER } )
  end

  def change_topic_answer data
    @topic = Topic.find_by(id: data['topic_id'])
    if @topic.update answer: data['topic_answer']
      OperationChannel.broadcast_to(@meet, { action: CHANGE_TOPIC_ANSWER } )
    end
  end

  private

  def on_subscribe
    set_meeting
    set_initial_topic
    set_channel_stream
    set_user_stream
    set_channel_redis
    set_current_clock_time
  end

  def set_meeting
    @meet = Meet.find(params['meet_id'])
  end

  def set_initial_topic
    @topic = (not @meet.topics.any_started?) ? @meet.topics.first : @meet.topics.most_recent.first
  end

  def set_channel_stream
    @operation_stream = "operation_channel_#{@meet.id}"
  end

  def set_user_stream
    @user_stream = SecureRandom.hex(8)
  end

  def set_channel_redis
    @redis = RedisService.new(key: @operation_stream)
  end

  def set_current_clock_time
    @redis.set({current_clock_time: current_clock_time})
  end
  
  def set_running_time
    topic_start_at = @redis.data['current_topic_start_at']
    if topic_start_at.present?
      running_time_seconds = (DateTime.now - topic_start_at.to_datetime).to_seconds
      running_time_seconds += @redis.data['running_time_seconds'] || 0
      @redis.set({running_time_seconds: running_time_seconds })
    end
  end

  def current_clock_time
    topic_duration = (@redis.data['current_topic_duration'] || 0).to_seconds
    elapsed_seconds = 0
    if @redis.present? && @redis.data['current_topic_start_at'].present?
      topic_started_at = (@redis.data['current_topic_start_at'] || '').to_datetime
      elapsed_seconds = @redis.data['running_time_seconds'] if @redis.data['running_time_seconds'].present?
      if @redis.data['clock_running'].present?
        elapsed_seconds += (DateTime.now - topic_started_at).to_seconds
      end
    end
    topic_duration - elapsed_seconds
  end
end


