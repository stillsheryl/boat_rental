class Dock
  attr_reader :name, :max_rental_time, :rental_hash, :revenue
  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
    @revenue = 0
  end

  def rent(boat, renter)
    @rental_log[boat] = renter
  end

  def rental_log
    @rental_log
  end

  def charge(boat)
    charge_info = {}
    charge_info[:card_number] = @rental_log[boat].credit_card_number
    if boat.hours_rented <= max_rental_time
      charge_info[:amount] = boat.price_per_hour * boat.hours_rented
    else
      charge_info[:amount] = boat.price_per_hour * max_rental_time
    end
    charge_info
  end

  def return(boat)
    @rental_log.each do |boat, renter|
      if @rental_log[boat]
        @revenue += charge(boat)[:amount]
      end
      @rental_log.delete(boat)
      end
  end

  def log_hour
    @rental_log.each_key do |boat|
      boat.add_hour
    end
  end

end
