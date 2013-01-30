require_relative 'test_helper'

require 'robot_factory'

describe RobotFactory do

  include TestHelper

  before do
    @robot_factory = RobotFactory.new [
      "#|#|#|##",
      "---X----",
      "###||###"
    ]
  end

  describe "#load_layout" do
    it "should initialize north laser bank" do
      refute @robot_factory.north_bank.nil?, "has north bank"
    end

    it "should initialize south laser bank" do
      refute @robot_factory.south_bank.nil?, "has south bank"
    end

    it "should have correct size" do
      assert_equal 8, @robot_factory.size
    end

    it "should set starting position" do
      assert_equal 3, @robot_factory.robot_starting_position
    end
  end

  describe "#damage" do
    it "should detect damage on click 0 at position 1" do
      assert @robot_factory.damage?(0, 1) 
    end

    it "should not detect damage on click 1 at position 1" do
      refute @robot_factory.damage?(1, 1) 
    end

    it "should not detect damage on click 0 at position 5" do
      refute @robot_factory.damage?(0, 4) 
    end

    it "should detect damage on click 1 at position 5" do
      assert @robot_factory.damage?(1, 4) 
    end

    it "should not detect damage on click 0 at position 0" do
      refute @robot_factory.damage?(0, 0) 
    end

    it "should not detect damage on click 1 at position 0" do
      refute @robot_factory.damage?(1, 0) 
    end
  end

  describe "#calculate_damage" do
    it "should calulate damage when moving left" do
      assert_equal 2, @robot_factory.calculate_damage(:direction => :left) 
    end

    it "should calulate damage when moving right" do
      assert_equal 3, @robot_factory.calculate_damage(:direction => :right) 
    end    
  end

end