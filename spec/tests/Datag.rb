
describe "Datag :list" do

  it "only lists tags containing characters: v 0-9 ." do
    chdir('Me') {
      Datag.list.should == Me_List
    }
  end

  it "uses natural sorting" do
    chdir('Me') {
      Datag.list.should == Me_List
    }
  end

end # === describe Datag list

describe "Datag :next" do
  
  it "lists tag previous to the current checked out tag." do
    chdir('Me') {
      Exit_0 %^ git checkout v2.0.1 ^
      Datag.next.should == "v2.0.02"
    }
  end

  it "returns current tag if it is the last tag." do
    chdir('Me') {
      Exit_0 %^ git checkout v2.0.02 ^
      Datag.next.should == "v2.0.02"
    }
  end

  it "returns current tag if on a non-tag commit" do
    chdir('Me') {
      Exit_0 %^ 
        git checkout master
        touch #{rand 1000}.md
        git add .
        git commit -m "No tag."
      ^
      Datag.next.should == Exit_0('git describe --tag').out
    }
  end
  
end # === Datag :next

describe "Datag :previous" do
  
  it "lists tag previous to the current checked out tag." do
    chdir('Me') {
      Exit_0 %^ git checkout v2.0.02 ^
      Datag.previous.should == "v2.0.1"
    }
  end

  it "returns current tag if it is the first tag." do
    chdir('Me') {
      Exit_0 %^ git checkout v1.1.1 ^
      Datag.previous.should == "v1.1.1"
    }
  end

  it "returns previous tag if on a non-tag commit" do
    chdir('Me') {
      Exit_0 %^ 
        git checkout master
        touch #{rand 1000}.md
        git add .
        git commit -m "No tag."
      ^
      Datag.previous.should == "v2.0.1"
    }
  end
  
end # === Datag :previous

describe "Datag :bump_patch" do
  
  after { reset_tmp } 
  
  it "adds 1 to patch of last tag" do
    chdir('Me') {
      Datag.bump_patch
      .should == "v2.0.3"
    }
  end

  it "adds 1 to patch if last tag is missing patch: v4.0" do
    t = Test_Datag.new
    def t.list
      %w{ v4.0 }
    end
    t.bump_patch
    .should == "v4.0.1"
  end

  it "returns v0.0.1 if no tags are listed" do
    t = Test_Datag.new
    def t.list
      %w{}
    end
    t.bump_patch.should == "v0.0.1"
  end
  
end # === Datag :bump_patch

describe "Datag :bump_minor" do

  it "adds 1 to minor and sets patch to 0 of last tag" do
    chdir('Me') {
      Datag.bump_minor.should == "v2.1.0"
    }
  end

  it "adds 1 to minor, even if last tag is missing a minor: v2" do
    t = Test_Datag.new
    def t.list
      %w{ v1.0 v2 }
    end
    t.bump_minor.should == "v2.1.0"
  end

  it "returns v0.1.0 if no tags are listed" do
    t = Test_Datag.new
    def t.list
      %w{ }
    end
    t.bump_minor.should == "v0.1.0"
  end
  
end # === Datag :bump_minor

describe "Datag :bump_major" do
  
  it "adds 1 to major" do
    chdir('Me') {
      Datag.bump_major.should == "v3.0.0"
    }
  end

  it "returns v1.0.0 if no tags are found" do
    t = Test_Datag.new
    def t.list
      %w{}
    end
    t.bump_major.should == "v1.0.0"
  end

end # === Datag :bump_major

describe "Datag :first" do

  it "prints first tag" do
    t = Test_Datag.new
    def t.list
      %w{ v1 }
    end
    t.first.should == "v1"
  end
  
end # === describe Datag :first

describe "Datag :last" do
  
  it "prints last tag" do
    t = Test_Datag.new
    def t.list 
      %w{ v1 v2 }
    end
    t.last.should == "v2"
  end
  
end # === Datag :last


