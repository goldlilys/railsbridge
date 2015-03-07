class Topic < ActiveRecord::Base
    # if a vote is deleted from topic, delete the vote too
    has_many :votes, dependent: :destroy    # adds voting relationship to topic, one topic can have many votes
end
