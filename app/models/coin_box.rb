class CoinBox
  def initialize(coins: [1], amt: 0)
    @coins = coins.uniq.sort.reverse
    @amt = amt
  end

  def call
    coins_to_return = []
    @coins.each do |coin|
      break if @amt.zero?

      if @amt >= coin
        coins_to_return << [coin] * (@amt / coin)
        @amt -= coin * (@amt / coin)
      end
    end

    result = coins_to_return.flatten
    result.empty? || @amt.positive? ? -1 : result
  end
end

# Selection of 5 coin values
coins = [1, 5, 10, 25, 50]
puts "Available coins: #{coins}"
# Random amount to solve for
amt = (1..100).to_a.sample

coins_used = CoinBox.new(coins: coins, amt: amt).call
if coins_used == -1
  puts "No solution found for #{amt}."
else
  puts "#{coins_used.length} coin(s) used to make up #{amt}: #{coins_used}"
end
