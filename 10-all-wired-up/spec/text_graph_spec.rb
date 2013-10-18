require 'wired_up'

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

      expect(root.type).to eq('@')
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

end