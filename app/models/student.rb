class Student < ApplicationRecord
    validates :name, presence: true
    validates :age, inclusion: 18..90
    belongs_to :instructor
end
