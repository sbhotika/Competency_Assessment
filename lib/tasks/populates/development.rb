# Step 1: Create Competencies
competencies =
  [
    ["Communication", "Take the Communication assessment to see how well you perform in the Communication Competency.", true],
    ["Decision Making", "The Decision Making competency will help you be more decisive in the future.", true],
    ["Utilizing Technology", "The Utilizing Technology competency will help you be more prepared with using technological tools.", false]
  ]

competencies.each do |competency|
  c = Competency.new
  c.name = competency[0]
  c.description = competency[1]
  c.active = competency[2]
  c.save!
end

# Step 2: Create Levels
levels =
  [
    ["Champion", "The highest level of indicators.", 1, true],
    ["Contributor", "The middle level of indicators.", 2, true],
    ["Companion", "The lowest level of indicators.", 3, true]
  ]

levels.each do |level|
  l = Level.new
  l.name = level[0]
  l.description = level[1]
  l.ranking = level[2]
  l.active = level[3]
  l.save!
end

# Step 3: Create Indicators
indicators =
  [
    ["Able to organize own thoughts and outline intended meaning of a message", 2, 3, true],
    ["Able to identify and may employ active listening skills", 2, 3, true],
    ["Able to identify common nonverbal cues", 2, 3, true],
    ["Able to identify various media used to deliver messages", 2, 3, true],
    ["Able to comprehend the content of oral and written messages by applying personal context to interpret the meaning", 2, 3, true],
    ["Able to present simple, familiar information to familiar audiences by using preferred method of communication", 1, 3, true],
    ["Able to present intentions and ideas to a familiar individual when prompted by the individual", 1, 3, true],
    ["Able to select the most appropriate medium of communication to deliver a menaningful message", 1, 2, true],
    ["Able to clearly and concisely deliver the meaning of a message using various media", 1, 2, true],
    ["Able to actively listen to others and clarify the meaning of a message", 1, 2, true],
    ["Able to evaluate previous interactions and develop a communication strategy to accommodate audience's preferences", 1, 2, true],
    ["Able to present written communication in an easy-to-read format", 1, 2, true],
    ["Able to articulate intentions, ideas, and feelings to a large group", 1, 2, true],
    ["Able to articulate thoughts using proper grammer in written and verbal form", 1, 2, true],
    ["Able to deliver an informational message which encourages others to take action", 1, 2, true],
    ["Able to evaluate the environment and/or audience to determine the most appropriate medium for delivering a meaningful message", 1, 1, true],
    ["Able to determine the effectiveness of a chosen medium in delivering a message", 1, 1, true],
    ["Able to deliver an inspiring and informative message regarding departmental and/or organizational objectives using multiple modes of communication", 1, 1, true],
    ["Able to paraphrase or extract meaning from others' communication", 1, 1, true],
    ["Able to identify and interpret nonverbal cues", 1, 1, true],
    ["Able to adjust communication approach while delivering a message by analyzing the audience's verbal and nonverbal cues", 1, 1, true],
    ["Able to encourage others to openly and clearly express intentions and ideas", 1, 1, true],
    ["Able to help others develop appropriate and effective communication strategies", 1, 1, true],
    ["Able to clarify complex information into simple, easy-to-understand terms and translate complex concepts for a broader audience", 1, 1, true]
  ]

indicators.each do |indicator|
  i = Indicator.new
  i.description = indicator[0]
  i.competency_id = indicator[1]
  i.level_id = indicator[2]
  i.active = indicator[3]
  i.save!
end

# Step 4: Create Questions
questions =
  [
    ["When I have something to say, I prepare by organizing my thoughts and outlining my intention.",true],
    ["I pay attention and focus when someone is talking to me.",true],
    ["I can recognize non-verbal cues from others.",true],
    ["When given direction by my supervisor, I understand what is being asked of me.",true],
    ["I am able to present information to others in a clear and concise manner.",true],
    ["When I don't understand something, I am able to resolve by asking clarifying questions.",true],
    ["After interacting with an individual, I am able to tailor my communication style to meet his/her needs.",true],
    ["My written communication is clear and concise.",true],
    ["My written communication is free of grammatical errors.",true],
    ["I am able to give direction that prompts the requested action.",true],
    ["I am able to gauge my audience and know which communication method to use.",true],
    ["I am able to paraphrase or restate a message I have received with accuracy.",true],
    ["I am able to adjust my message in response to the non-verbal cues I receive.",true],
    ["I encourage others to share their ideas and opinions.",true],
    ["I can translate complex concepts into easy-to-understand ideas and information.",true],
    ["I can inspire others by communicating a vision or plan.",true]
  ]

questions.each do |question|
  q = Question.new
  q.question = question[0]
  q.active = question[1]
  q.save!
end

# Step 5: Create IndicatorQuestions
(indicators.length + questions.length).times do |index|
  iq = IndicatorQuestion.new
  iq.indicator_id = (index % indicators.length) + 1
  iq.question_id = (index % questions.length) + 1
  iq.save!
end

# Step 6: Create Paradigms
paradigms =
  [
    ["Build Understanding", "Books that help you understand what you're buildling", 1, true],
    ["Get Connected", "Workshops for you to try live!", 2, true],
    ["Do Something", "Actionable ways to better you", 3, true],
    ["Learn More", "Watch educational videos", 4, true]
  ]

paradigms.each do |paradigm|
  p = Paradigm.new
  p.name = paradigm[0]
  p.description = paradigm[1]
  p.ranking = paradigm[2]
  p.active = paradigm[3]
  p.save!
end

# Step 7: Create Resources
resources =
  [
    ["Basic Concepts of Intercultural Communication: Paradigms, Principles and Practices, Second Edition", 1, "http://www.google.com", true],
    ["Communication Skills for Dummies", 1, "http://wwww.google.com", true],
    ["Crisis Communications: The Definitive Guide to Managing the Message", 1, "http://wwww.google.com", true],
    ["How to Read a Client from Across the Room: Win More Business with the Proven Character Code System to Decode Verbal & Nonverbal Communication", 1, "http://wwww.google.com", true],
    ["How to Succeed with People: The Remarkable Truth about How to Get the Most Out of Dealing with Others", 1, "http://wwww.google.com",true],
    ["How To Talk To Absolutely Anyone: Confident Communication in Every Situation", 1, "http://www.google.com", true],
    ["I Hear You: Repair Communication Breakdowns; Negotiate Successfully; and Build Consensus . . . in Three Simple Steps", 1, "http://wwww.google.com", true],
    ["On Message: Precision Communication for the Digital Age", 1, "http://www.google.com", true],
    ["Communicating Across Cultures", 2, "http://www.google.com", true],
    ["Improving Communication in Cross-Cultural Relationships", 2, "http://www.google.com", true],
    ["Interpersonal Communication: Being Approachable", 2, "http://www.google.com", true],
    ["Interpersonal Communication: Communicating Assertively", 2, "http://www.google.com", true],
    ["Interpersonal Communication: Communicating with Confidence", 2, "http://www.google.com", true],
    ["Culture and Its Effect on Communication", 2, "http://www.google.com", true],
    ["Preparing to Communicate Effectively at the 'C' Level", 2, "http://www.google.com", true],
    ["Techniques for Communicating Effectively with Senior Executives", 2, "http://www.google.com", true],
    ["Volunteer to write an agenda for your team’s next meeting.", 3, "http://www.google.com", true],
    ["Observe a presentation and observe the presenter’s communication skills. Identify which methods contributed to an impactful message and which detracted from the meaning of the message.", 3, "http://www.google.com", true],
    ["Practice new communication skills when presenting familiar information to various individuals.", 3, "http://www.google.com", true],
    ["Be aware of your nonverbal cues. Ask a colleague to indicate the message your nonverbal cues are delivering.", 3, "http://www.google.com", true],
    ["Identify the cause(s) of a misunderstanding that occurred and develop a plan to avoid it in the future.", 3, "http://www.google.com", true],
    ["Volunteer to teach a new work process or procedure to a colleague.", 3, "http://www.google.com", true],
    ["Identify a situation where miscommunication occurs and develop a plan to clarify the miscommunication.", 3, "http://www.google.com", true],
    ["Offer to review a colleague’s written communication.", 3, "http://www.google.com", true],
    ["Discuss your communication style with others in your group. Ask for feedback.", 4, "http://www.google.com", true],
    ["Ask others in your group how they prefer to communicate. Do their preferences change based on the situation?", 4, "http://www.google.com", true],
    ["Invite a colleague out to lunch. Use your listening skills to learn more about him or her.", 4, "http://www.google.com", true],
    ["Identify a colleague who you feel expresses his or her ideas effectively. Observe his or her behavior when faced with a conflict situation.", 4, "http://www.google.com", true],
    ["Identify a colleague who communicates effectively in writing. Ask if he or she can review an important email before you send.", 4, "http://www.google.com", true],
    ["Attend an event or celebration with colleagues. Observe their non-verbal cues as they speak with you and with others.", 4, "http://www.google.com", true],
    ["Attend a conference or networking event where you know very few people. Practice introducing yourself and asking questions to get to know others.", 4, "http://www.google.com", true],
    ["Ask for feedback from colleagues or your supervisor on written and verbal messages – are you able to deliver your intended message in a way that encourages others and provides important information?", 4, "http://www.google.com", true],
  ]

resources.each do |resource|
  r = Resource.new
  r.title = resource[0]
  r.paradigm_id = resource[1]
  r.link = resource[2]
  r.active = resource[3]
  r.save!
end

# Step 8: Create IndicatorResources
(indicators.length + resources.length).times do |index|
  ir = IndicatorResource.new
  ir.indicator_id = (index % indicators.length) + 1
  ir.resource_id = (index % resources.length) + 1
  ir.save!
end

# Step 9: Create Users
users =
  [
    ["admin", "password", "password", true]
  ]

users.each do |user|
  u = User.new
  u.username = user[0]
  u.password = user[1]
  u.password_confirmation = user[2]
  u.active = user[3]
  u.save!
end
