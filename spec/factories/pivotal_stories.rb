FactoryGirl.define do
  factory :pivotal_story do
    pivotal_id '123456'
    project_id '123456'
    started_at  ActiveSupport::TimeZone['UTC'].parse("14/08/2015 12:00:00")
    accepted_at ActiveSupport::TimeZone['UTC'].parse("17/08/2015 12:00:00")
    estimate 2
    name "Write a spec to test Pivotal Tracker stories"
    kind "story"
    story_type "feature"
    current_state "started"
  end
end
