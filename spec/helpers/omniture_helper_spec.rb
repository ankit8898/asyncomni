require 'spec_helper'

describe OmnitureHelper do
  it "should return application name" do
    helper.application_name.should == 'demo-app'
  end

  it "should return user id" do
    helper.should_receive(:current_user).and_return(stub(:id => id = 5))
    helper.user_id.should == id
  end

  it "should return omniture query params for page name" do
    helper.should_receive(:page_name).and_return(home = "Home")
    helper.omniture_query_param(:page_name).should == "page_name=#{home}"
  end

  it "should return omniture url" do
    helper.should_receive(:user_id).and_return(id = 5)
    helper.should_receive(:page_name).and_return(home = "Home")
    helper.omniture_url.should == "#{omniture_index_url}?page_name=#{home}&user_id=#{id}&application_name=demo-app"
  end

  it "should return page name for users index page" do
    helper.should_receive(:controller_name).exactly(1).times.and_return('users')
    helper.should_receive(:action_name).exactly(1).times.and_return('index')

    helper.page_name.should == "demo-app_Users_Index"
  end

  it "should have omniture formatted time" do
    helper.omniture_formatted_time.should == Time.now.strftime('%m/%d/%Y %I:%M:%S %p')
  end
end