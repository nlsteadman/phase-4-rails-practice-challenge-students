class StudentInstructorSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :major, :instructor_id
  belongs_to :instructor
end
