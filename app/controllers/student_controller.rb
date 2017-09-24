class StudentController < ApplicationController
# Login page for student
# Hackaround : Can we use direct variables here instead of using these class variables and all??
  def login
    if request.get?
      
      if session[:roll_no] && session[:password]
        @result = Student.where(roll_no: session[:roll_no] , password: session[:password])  
        if !@result.empty?
         redirect_to(student_dashboard_path)  
        end  
      end

      @logincred = Student.new
      @error = 0
    end

    if request.post?

      @logincred = Student.new(login_params)
    # @spassword = @logincred.password
      @result = Student.where(roll_no: @logincred.roll_no, password: @logincred.password)
    # If roll number and password exist
      if !@result.empty?
        session[:roll_no] = @logincred.roll_no
        session[:password] = @logincred.password
        redirect_to(student_dashboard_path)
      else
        @error = 1
      end
      # @logintable = Login.all

    end
  end

  def logout
    @logincred = Student.new
    @error = 0
    session.clear
    render 'login'
  end
# Dashboard for student
  def dashboard
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)  
    end
  end

  def view_menu
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)  
    end
    @menus = Menu.all
  end

  def view_bill
  end

  def apply_mess_cut
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)  
    end

    if request.get?
      @messcut = MessCut.new
    end
    
    if request.post?
      @messcut = MessCut.new(messcut_params)
      if @messcut.save
        flash[:notice] = "Successfully submitted..."
      end
    end
  end

  def pay_bill
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)  
    end
  end

  def purchase_history
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)  
    end
# Replace this hardcoded value with the session variables rollnumber and name
    # @purchased = Extra.where(roll_no: 123).group('item').count('item')
    @purchased = Extra.where(roll_no: session[:roll_no])

  end

  def change_password
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)  
    end

  end

  def feedback
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)  
    end
    
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
    params.require(:feedback).permit(:name, :s_id, :feedback)
  end

  def login_params
    params.require(:student).permit(:roll_no, :password)
  end

  def messcut_params
    params.require(:mess_cut).permit(:roll_no, :name, :from, :to)
  end
