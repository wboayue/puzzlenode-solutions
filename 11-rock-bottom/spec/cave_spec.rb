require 'rock_bottom'

describe RockBottom::Cave do
  let(:cave_layout) {[
    "################################",
    "~                              #",
    "#         ####                 #",
    "###       ####                ##",
    "###       ####              ####",
    "#######   #######         ######",
    "#######   ###########     ######",
    "################################"
  ]}

  let(:cave) { RockBottom::Cave.new cave_layout }

  let(:floor) {[
    [0, 2], [1, 3], [2, 3], [3, 5], [4, 5], [5, 5], [6, 5], [7, 7], [8, 7], [9, 7]
  ]}

  let(:open_spaces) {[
    [1, 1], [1, 2], [2, 2], [3, 4], [4, 4], [5, 4], [6, 4], [7, 6], [8, 6], [9, 6]
  ]}

  it "indicates correct position of water" do
    expect(cave[0, 1]).to eq('~')
  end 

  it "indicates correct position of floor" do
    floor.each do |pos|
      expect(cave[*pos]).to eq('#')
    end
  end  

  it "indicates correct position of open spaces" do
    floor.each do |pos|
      expect(cave[*pos]).to eq('#')
    end
  end  

end