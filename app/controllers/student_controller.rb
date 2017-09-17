class StudentController < ApplicationController
# Login page for student
  def login
    if request.get?
      @logincred = Login.new
    end

    if request.post?
      @logincred = Login.new(login_params)
      @logintable = Login.all
# Don't know if I really need it?

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
    params.require(:login).permit(:s_id, :username, :password)
  end
