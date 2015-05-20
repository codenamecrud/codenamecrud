FactoryGirl.define do
  factory :course do
    sequence(:title) { |n| "Ruby Title #{n}" }
    sequence(:slug)  { |n| "course_ruby-slug-#{n}" }
    description "MyText"
    short_description 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsum consequatur necessitatibus recusandae quo dolor tenetur consectetur quas maxime, adipisci sequi, est ad nam! Quasi est soluta modi sit laboriosam voluptatem.'
    you_learn ['test', 'test', 'test']
    you_build ['test', 'test', 'test']
    is_active false
  end

end
