class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        students = Student.all
        render json: students
    end

    def show
        student = Student.find(params[:id])
        render json: student
    end

    def create
        student = Student.create!(params.permit(:name, :age, :major, :instructor_id))
        render json: student, status: :created, serializer: StudentInstructorSerializer
    end

    def update
        student = Student.find(params[:id])
        student.update(params.permit(:name, :age, :major, :instructor_id))
        render json: student, serializer: StudentInstructorSerializer
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private

    def render_not_found_response
        render json: { error: "Student not found" }, status: :not_found
    end

    def render_unprocessable_entity_response
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

end
