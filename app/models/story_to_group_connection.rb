class StoryToGroupConnection < ActiveRecord::Base
  belongs_to :group
  belongs_to :story
end