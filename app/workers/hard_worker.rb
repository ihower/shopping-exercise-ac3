# app/workers/hard_worker.rb
class HardWorker
  include Sidekiq::Worker

  def perform(name)
     # your code
     Rails.logger.info("SIDEKIQ TEST: #{name}")
  end

end