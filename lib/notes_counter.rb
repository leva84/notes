class NotesCounter
  def initialize
    @mx = Mutex.new
    @client = $redis
    @count = @client.get('notes_count').to_i

    if @count == 0
      @client.set('notes_count', Note.count)
      @count = @client.get('notes_count').to_i
    end
  end

  def increment
    @mx.synchronize do
      @count += 1
      @client.incr('notes_count')
      @count
    end
  end

  def decrement
    @mx.synchronize do
      @count -= 1
      @client.decr('notes_count')
      @count
    end
  end

  def count
    @mx.synchronize do
      @count.dup
    end
  end

  class << self
    delegate :increment, to: :instance
    delegate :decrement, to: :instance
    delegate :count, to: :instance

    private

    def instance
      @instance ||= NotesCounter.new
    end
  end
end
