require_relative 'test_helper'

require 'robot_factory/laser_bank'

describe LaserBank do

  before do
    layout = "#|#|#|##"
    @laser_bank = LaserBank.new layout: layout, fires_on: {even: true}
  end

  describe "#load_layout" do

    it "should load layout" do
      [0, 2, 4, 6, 7].each do |i|
        refute @laser_bank.laser_at?(i), "shoud not have laser at position #{i}"
      end

      [1, 3, 5].each do |i|
        assert @laser_bank.laser_at?(i), "shoud have laser at position #{i}"
      end
    end
  end

  describe "#fires_on" do
    it "should fire on configured click" do
      assert @laser_bank.fires_on? :even
      refute @laser_bank.fires_on? :odd
    end
  end

  describe "#damage?" do
    it "should cause damage is laser fires on click" do
      assert @laser_bank.damage?(0, 1)
      refute @laser_bank.damage?(1, 1)
    end
  end

end