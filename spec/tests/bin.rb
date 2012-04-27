
describe "permissions of bin/" do
  Dir.glob("bin/*").each { |file|
    it "should chmod 755 for: #{file}" do
      `stat -c %a #{file}`.strip
      .should.be == "755"
    end
  }
end # === permissions of bin/


describe "Datag bin" do
  
  it "prints out :next tag" do
    chdir('Me') {
      r = Exit_0 '
        git checkout v1.1.1
        bundle exec Datag next
      '
      r.raw_out.should == "v1.2.1\n"
    }
  end
  
  it "prints out :previous tag" do
    chdir('Me') {
      r = Exit_0 '
        git checkout v2.0.0
        bundle exec Datag previous
      '
      r.raw_out.should == "v1.11.0\n"
    }
  end

  it "prints each tag on a separate line" do
    chdir('Me') {
      Exit_0("bundle exec Datag list")
      .raw_out.should == Me_List.join("\n") + "\n"
    }
  end
  
  it "prints all tags reversed when passed: list -r" do
    chdir('Me') {
      Exit_0("bundle exec Datag list -r")
      .raw_out.should == Me_List.reverse.join("\n") + "\n"
    }
  end
  
  it "prints all tags reversed when passed: -r list" do
    chdir('Me') {
      Exit_0("bundle exec Datag -r list")
      .raw_out.should == Me_List.reverse.join("\n") + "\n"
    }
  end

end # === Datag bin
