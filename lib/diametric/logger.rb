module Diametric
  class Logger
    LEVELS = {
      debug: 4,
      info: 3,
      warning: 2,
      error: 1
    }

    class << self
      LEVELS.keys.each do |sym|
        define_method(sym) do |str|
          @logger ||= Logger.new
          @logger.send(sym, str)
        end
      end
    end

    def self.logger=(logger)
      @logger = logger
    end

    attr_accessor :level
    def initialize(level=:warning)
      @level = level
    end

    LEVELS.keys.each do |sym|
      define_method(sym) do |str|
        return if below_level(sym)
        puts "DIAMETRIC-DEBUG: #{str}"
      end
    end

    private

    def below_level(level)
      LEVELS[level] >= LEVELS[@level]
    end
  end
end
