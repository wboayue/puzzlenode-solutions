require 'wired_up'

module WiredUp
describe TextGraph do
  let(:graph) {
    lines = [
      "0-------------|",
      "              A------------|",
      "1-------------|            |",
      "                           X------------@",
      "1-------------|            |",
      "              N------------|"
    ]

    TextGraph.new lines
  }

  describe "#find_root" do
    it "finds root node of graph" do
      root = graph.find_root

      expect(root.value).to eq('@')
      expect(root.x).to eq(40)
      expect(root.y).to eq(3)
    end    
  end

  describe "#direct_path?" do
    it "indicates direct path is available" do
      expect(graph.direct_path?(40, 3)).to eq(true)
    end

    it "indicates direct path is not available" do
      expect(graph.direct_path?(27, 3)).to eq(false)
    end
  end

  describe "#find_direct_node" do
    it "finds direct node from specified location" do
      node = graph.find_direct_node(40, 3)

      expect(node.value).to eq('X')
      expect(node.x).to eq(27)
      expect(node.y).to eq(3)
    end
  end

  describe "#left_path?" do
    it "indicates left path is available" do
      expect(graph.left_path?(14, 1)).to eq(true)
    end

    it "indicates left path is not available" do
      expect(graph.left_path?(14, 5)).to eq(false)
    end
  end

  describe "#find_left_node" do
    it "finds left node from specified location" do
      node = graph.find_left_node(14, 1)

      expect(node.value).to eq('1')
      expect(node.x).to eq(0)
      expect(node.y).to eq(2)
    end
  end

  describe "#right_path?" do
    it "indicates right path is available" do
      expect(graph.right_path?(14, 1)).to eq(true)
    end

    it "indicates right path is not available" do
      expect(graph.right_path?(0, 0)).to eq(false)
    end
  end

  describe "#find_right_node" do
    it "finds right node from specified location" do
      node = graph.find_right_node(14, 1)

      expect(node.value).to eq('0')
      expect(node.x).to eq(0)
      expect(node.y).to eq(0)
    end
  end

end

end