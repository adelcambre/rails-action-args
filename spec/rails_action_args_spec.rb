require File.expand_path(File.join(File.dirname(__FILE__), "spec_helper"))

describe "RailsActionArgs" do
  it "should be able to handle a nested class" do
    Awesome::ActionArgs.action(:index).call(Rack::MockRequest.env_for("/?foo=bar"))[2].body.should == "bar"
  end

  it "should be able to handle no arguments" do
    ActionArgs.action(:nada).call(Rack::MockRequest.env_for("/"))[2].body.should == "NADA"
  end

  it "should be able to accept Action Arguments" do
    ActionArgs.action(:index).call(Rack::MockRequest.env_for("/?foo=bar"))[2].body.should == "bar"
  end

  it "should be able to accept multiple Action Arguments" do
    ActionArgs.action(:multi).call(Rack::MockRequest.env_for("/?foo=bar&bar=baz"))[2].body.should == "bar baz"    
  end

  it "should be able to handle defaults in Action Arguments" do
    ActionArgs.action(:defaults).call(Rack::MockRequest.env_for("/?foo=bar"))[2].body.should == "bar bar"
  end

  it "should be able to handle out of order defaults" do
    ActionArgs.action(:defaults_mixed).call(Rack::MockRequest.env_for("/?foo=bar&baz=bar"))[2].body.should == "bar bar bar"    
  end

  # it "should throw a BadRequest if the arguments are not provided" do
  #   lambda { ActionArgs.action(:index).call(Rack::MockRequest.env_for("/")) }.should raise_error(Merb::ControllerExceptions::BadRequest)
  # end

  it "should treat define_method actions as equal" do
    ActionArgs.action(:dynamic_define_method).call(Rack::MockRequest.env_for("/"))[2].body.should == "mos def"
  end

  it "should be able to inherit actions for use with Action Arguments" do
    ActionArgs.action(:funky_inherited_method).call(Rack::MockRequest.env_for("/?foo=bar&bar=baz"))[2].body.should == "bar baz"
  end

  it "should be able to handle nil defaults" do
    ActionArgs.action(:with_default_nil).call(Rack::MockRequest.env_for("/?foo=bar"))[2].body.should == "bar "
  end

  it "should be able to handle [] defaults" do
    ActionArgs.action(:with_default_array).call(Rack::MockRequest.env_for("/?foo=bar"))[2].body.should == "bar []"
  end

  # it "should print out the missing parameters if all are required" do
  #   lambda { ActionArgs.action(:multi).call(Rack::MockRequest.env_for("/")) }.should raise_error(
  #     Merb::ControllerExceptions::BadRequest, /were missing foo, bar/)
  # end
  # 
  # it "should only print out missing parameters" do
  #   lambda { ActionArgs.action(:multi).call(Rack::MockRequest.env_for("/?foo=Hello")) }.should raise_error(
  #     Merb::ControllerExceptions::BadRequest, /were missing bar/)          
  # end
end