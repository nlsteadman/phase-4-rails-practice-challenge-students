class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        instructors = Instructor.all
        render json: instructors
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor
    end

    def create
        instructor = Instructor.create!(params.permit(:name))
        render json: instructor, status: :created
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update(params.permit(:name))
        render json: instructor
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    private

    def render_not_found_response
        render json: { error: "Intructor not found" }, status: :not_found
    end

    def render_unprocessable_entity_response
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end


end
