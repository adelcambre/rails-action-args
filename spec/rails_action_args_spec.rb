require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))

describe "RailsActionArgs" do
  def app
    MyApp
  end

  it "should be able to handle a nested class" do
    request("/awesome/index?foo=bar").body.should == "bar"
  end

  it "should be able to handle no arguments" do
    request("/action_args/nada").body.should == "NADA"
  end

  it "should be able to accept Action Arguments" do
    request("/action_args/index?foo=bar").body.should == "bar"
  end

  it "should be able to accept multiple Action Arguments" do
    request("/action_args/multi?foo=bar&bar=baz").body.should == "bar baz"
  end

  it "should be able to handle defaults in Action Arguments" do
    request("/action_args/defaults?foo=bar").body.should == "bar bar"
  end

  it "should be able to handle out of order defaults" do
    request("/action_args/defaults_mixed?foo=bar&baz=bar").body.should == "bar bar bar"
  end

  it "should throw a 400 Bad Request if the arguments are not provided" do
    request("/action_args/index").status.should == 400
  end

  it "should treat define_method actions as equal" do
    request("/action_args/dynamic_define_method").body.should == "mos def"
  end

  it "should be able to inherit actions for use with Action Arguments" do
    request("/action_args/funky_inherited_method?foo=bar&bar=baz").body.should == "bar baz"
  end

  it "should be able to handle nil defaults" do
    request("/action_args/with_default_nil?foo=bar").body.should == "bar "
  end

  it "should be able to handle [] defaults" do
    request("/action_args/with_default_array?foo=bar").body.should == "bar []"
  end

  it "should print out the missing parameters if all are required" do
    response = request("/action_args/multi")
    response.status.should == 400
    response.body.should include("were missing foo, bar")
  end

  it "should only print out missing parameters" do
    response = request("/action_args/multi?foo=Hello")
    response.status.should == 400
    response.body.should include("were missing bar")
  end
end