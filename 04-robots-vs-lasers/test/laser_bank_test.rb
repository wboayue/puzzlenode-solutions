require_relative 'test_helper'

require 'robot_factory/laser_bank'

describe LaserBank do
  describe "#initialize" do
    before do
      layout = "#|#|#|##"
      @laser_bank = LaserBank.new layout: layout
    end

    it "should load layout" do
      [0, 2, 4, 6, 7].each do |i|
        refute @laser_bank.laser_at?(i), "shoud not have laser at position #{i}"
      end

      [1, 3, 5].each do |i|
        assert @laser_bank.laser_at?(i), "shoud have laser at position #{i}"
      end
    end
  end
end