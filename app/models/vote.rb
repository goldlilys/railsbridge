class Vote < ActiveRecord::Base
    belongs_to :topic    # connect relationship for vote with topic, one topic per vote
end
