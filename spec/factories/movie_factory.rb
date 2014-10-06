FactoryGirl.define do
  factory :movie do
    author
    sequence(:youtube_id, "0fCpAuxrQ_I")
    title "7 brothers who aren't brothers"
    description "Broder frag movie."
    views 5
    duration 3.minutes
    association :proposer, factory: :user
    uploaded_on_youtube { 1.day.ago }
    info_refreshed_at { 1.day.ago }
    featured false
    status_cd Movie.statuses.pending
  end
end
