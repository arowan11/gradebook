class StudentsController < ApplicationController
  load_and_authorize_resource

  def new
    @student = Student.new()
  end

  def create
    @student = Student.new(student_params)
    @student.teacher = current_user.personable
    if @student.save
      redirect_to teacher_path(current_user.personable_id)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def student_params
    params.require(:student).permit(:full_name, :email)
  end
end
