class StudentController < ApplicationController
# Login page for student
# Hackaround : Can we use direct variables here instead of using these class variables and all??
  def login             
    if request.get?
      @logincred = Student.new
      @error = 0
    end

    if request.post?

      @logincred = Student.new(login_params)
    # @spassword = @logincred.password
      @result = Student.where(roll_no: @logincred.roll_no, password: @logincred.password)
    # If roll number and password exist
      if !@result.empty?
        redirect_to(student_dashboard_path)
      else
        @error = 1
      end
      # @logintable = Login.all

    end
  end

# Dashboard for student
  def dashboard
  end

  def view_menu
  end

  def view_bill
  end

  def apply_mess_cut
  end

  def pay_bill
  end

  def purchase_history
  end

  def change_password
  end

  def feedback
    if request.get?
      @feedback = Feedback.new
    end

    if request.post?
      @feedback = Feedback.new(feedback_params)
      if @feedback.save
        flash[:notice] = "Successfully created..."
      end
    end
  end
end

private
  def feedback_params
    params.require(:feedback).permit(:name, :status, :s_id)
  end

  def login_params
    params.require(:student).permit(:roll_no, :password)
  end
