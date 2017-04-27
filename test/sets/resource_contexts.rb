module Contexts
  module ResourceContexts

    # Create four resources for testing
    def create_resources
      @comm_dumm = FactoryGirl.create(:resource, paradigm: @build_understanding)
      @busi_success   = FactoryGirl.create(:resource, paradigm: @get_connected, link:"https://www.google.com", title: "How to Succeed in Business")
      @busi_failure   = FactoryGirl.create(:resource, paradigm: @get_connected, link:"", title: "How to Fail in Business")
      @pub_speak = FactoryGirl.create(:resource, paradigm: @do_something, link:nil, title: "Public Speaking 101 Workshop", active: false)
    end

    # Destroy four resources created above
    def remove_resources
      @comm_dumm.destroy
      @busi_success.destroy
      @busi_failure.destroy
      @pub_speak.destroy
    end

  end
end
