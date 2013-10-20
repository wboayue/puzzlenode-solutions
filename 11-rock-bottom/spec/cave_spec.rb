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

  it "indicates correct position of water" do
    expect(cave[0, 1]).to eq('~')
  end 

  let(:floor) {[
    [0, 2], [1, 3], [2, 3], [3, 5], [4, 5], [5, 5], [6, 5], [7, 7], [8, 7], [9, 7]
  ]}

  it "indicates correct position of floor" do
    floor.each do |pos|
      expect(cave[*pos]).to eq('#')
    end
  end  

  let(:open_spaces) {[
    [1, 1], [1, 2], [2, 2], [3, 4], [4, 4], [5, 4], [6, 4], [7, 6], [8, 6], [9, 6]
  ]}

  it "indicates correct position of open spaces" do
    floor.each do |pos|
      expect(cave[*pos]).to eq('#')
    end
  end  

  it "starts with one unit of water" do
    expect(cave.units_of_water).to eq(1)
  end  

  let(:expected_flow) {[
    [1, 1], [1, 2], [2, 2], [3, 2], [3, 3], [3, 4], [4, 4], [5, 4], [6, 4], [7, 4],
    [7, 5], [7, 6], [8, 6], [9, 6], [8, 5], [9, 5], [8, 4], [9, 4], [4, 3], [5, 3]
  ]}

  it "flows water along expected path" do
    expected_flow.each do |pos|
      expect(cave[*pos]).to eq(' ')
      cave.pour(1)
      expect(cave[*pos]).to eq('~')
    end
    cave.print
  end  

  it "flows water along expected path" do
    cave.pour(44)
    cave.print
  end  

end