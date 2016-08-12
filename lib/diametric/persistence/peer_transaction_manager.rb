module Diametric
  module Persistence
    module Peer
      class TransactionManager
        def initialize(connection)
          @connection = connection
          @transactions_data = []
          @count = 0
        end

        def transaction(parsed_data=nil, &block)
          if parsed_data
            transaction_data = TransactionData.new(parsed_data, block)
            @transactions_data.push(transaction_data)
          end

          @count += 1
          block.call unless parsed_data
          @count -= 1

          if @count == 0
            data = @transactions_data.map{|td| td.parsed_data.first}
            map = @connection.transact(data).get
            @transactions_data.each { |transaction_data| transaction_data.is_done(map) }
            @transactions_data = []

            return map
          end

          return nil
        end
      end

      class TransactionData
        attr_reader :parsed_data, :done_block
        def initialize(parsed_data, done_block)
          @parsed_data = parsed_data
          @done_block = done_block
        end

        def is_done(map)
          Logger.debug "calling done block with #{map.inspect}"
          @done_block.call(map)
        end
      end
    end
  end
end
