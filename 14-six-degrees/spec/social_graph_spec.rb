require 'six_degrees'

describe SocialGraph do
  before do
    @graph = SocialGraph.new

    @graph.add_interaction 'alberta', ['bob']
    @graph.add_interaction 'bob', ['alberta']
    @graph.add_interaction 'alberta', ['christie']
    @graph.add_interaction 'christie', ['alberta', 'bob']
    @graph.add_interaction 'bob', ['duncan', 'christie']
    @graph.add_interaction 'duncan', ['bob']
    @graph.add_interaction 'alberta', ['duncan']
    @graph.add_interaction 'emily', ['duncan']
    @graph.add_interaction 'duncan', ['emily']
    @graph.add_interaction 'christie', ['emily']
    @graph.add_interaction 'emily', ['christie']
    @graph.add_interaction 'duncan', ['farid']
    @graph.add_interaction 'farid', ['duncan']
  end

  it "should sort users" do
    @graph.users.should == ["alberta", "bob", "christie", "duncan", "emily", "farid"] 
  end

  it "should discover 1st order connections" do
    @graph.connections('alberta')[0].should == ['bob', 'christie'] 
    @graph.connections('bob')[0].should == ['alberta', 'christie', 'duncan'] 
    @graph.connections('christie')[0].should == ['alberta', 'bob', 'emily'] 
    @graph.connections('duncan')[0].should == ['bob', 'emily', 'farid']
    @graph.connections('emily')[0].should == ['christie', 'duncan']
    @graph.connections('farid')[0].should == ['duncan']
  end

  it "should discover 2nd order connections" do
    @graph.connections('alberta')[1].should == ['duncan', 'emily'] 
    @graph.connections('bob')[1].should == ['emily', 'farid'] 
    @graph.connections('christie')[1].should == ['duncan'] 
    @graph.connections('duncan')[1].should == ['alberta', 'christie']
    @graph.connections('emily')[1].should == ['alberta', 'bob', 'farid']
    @graph.connections('farid')[1].should == ['bob', 'emily']
  end

  it "should discover 3rd order connections" do
    @graph.connections('alberta')[2].should == ['farid']
    @graph.connections('christie')[2].should == ['farid'] 
    @graph.connections('farid')[2].should == ['alberta', 'christie']
  end
end
