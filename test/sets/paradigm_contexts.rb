module Contexts
  module ParadigmContexts

    # Create four test paradigms
    def create_paradigms
      @build_understanding = FactoryGirl.create(:paradigm)
      @get_connected       = FactoryGirl.create(:paradigm, name: "Get Connected",
                                  description: "Workshops for you to try live!",
                                  ranking: 2)
      @do_something        = FactoryGirl.create(:paradigm, name: "Do Something",
                                  description: "Actionable ways to better you",
                                  ranking: 3)
      @learn_more          = FactoryGirl.create(:paradigm, name: "Learn More",
                                  description: "Watch educational videos",
                                  ranking: 4)
    end

    # Destroy four test paradgims created above
    def remove_paradigms
      @build_understanding.destroy
      @get_connected.destroy
      @do_something.destroy
      @learn_more.destroy
    end

  end
end
