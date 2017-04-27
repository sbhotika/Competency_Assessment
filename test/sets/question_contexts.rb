module Contexts
  module QuestionContexts

    # Create three Questions
    def create_questions
      @communication_q1 = FactoryGirl.create(:question)
      @communication_q2 = FactoryGirl.create(:question, question: "I pay attention and focus when someone is talking to me.")
      @communication_q3 = FactoryGirl.create(:question, question: "I can recognize non-verbal cues from others.", active: false)
      @decision_making_q1 = FactoryGirl.create(:question, question: "I enjoy making decisions both large and small.")
      @decision_making_q2 = FactoryGirl.create(:question, question: "I am scared of making decisions, especially important ones.")
      @problem_solving_q1 = FactoryGirl.create(:question, question: "I can recognize the root issue with any problem.", active: false)
    end

    # Destroy the question objects
    def remove_questions
      @communication_q1.destroy
      @communication_q2.destroy
      @communication_q3.destroy
      @decision_making_q1.destroy
      @decision_making_q2.destroy
      @problem_solving_q1.destroy
    end

  end
end
