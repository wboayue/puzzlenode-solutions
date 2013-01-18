class SalesTotaler

  attr_accessor :rates_file, :transactions_file

  def initialize(args)
    @rates_file = args[:rates_file]
    @transactions_file = args[:transactions_file]
  end

end