class ManagerController < ApplicationController

def login
  #skip_before_filter :verify_authenticity_token
  if session[:admin] && session[:password]
    @result = Adminn.where(admin: session[:admin] , password: session[:password])
    if !@result.empty?
     redirect_to(manager_dashboard_path)
    end
  end

  if request.get?
    @logincred = Adminn.new
    @error = 0

  end

  if request.post?

    @logincred = Adminn.new(adminn_params)
  # @spassword = @logincred.password
    @result = Adminn.where(admin: @logincred.admin, password: @logincred.password)
  # If roll number and password exist
    if !@result.empty?
      session[:admin] = @logincred.admin
      session[:password] = @logincred.password
      session[:v] = 1

      redirect_to(manager_dashboard_path)

    else
      @error = 1
    end
    # @logintable = Login.all

  end
end


def logout
  @logincred = Adminn.new
  @error = 0
  session.clear
  render 'login'
end



def add_student

  if ((session[:v] != 1) || !(session[:admin] || session[:password]))
    redirect_to(manager_login_path)
  end
  if request.get?
      @student = Student.new
  end
  if request.post?
      @student = Student.new(student_params)
      if @student.save
        flash[:notice] = "Successfully created..."
        redirect_to(manager_add_student_path)
      end
 end
end


def delete_student
  if ((session[:v] != 1) || !(session[:admin] || session[:password]))
    redirect_to(manager_login_path)
  end
    if request.get?
      @student = Student.new
    end
    if request.post?
      @student = Student.find_by_roll_no(params[:student][:roll_no])
      @student.destroy
      flash[:notice] = "Successfully deleted '#{@student.name}'..."
      redirect_to(manager_delete_student_path)
    end
end


def view_menu
  if ((session[:v] != 1) || !(session[:admin] || session[:password]))
    redirect_to(manager_login_path)
  end
  if request.get?
    @menus = Menu.all
  end
  if request.post?
    @menu = Menu.find(params[:id])
  end
end


def update_menu
  if ((session[:v] != 1) || !(session[:admin] || session[:password]))
    redirect_to(manager_login_path)
  end
  @menu = Menu.find(params[:id])
  if request.patch?
    if  @menu.update_attributes(menu_params)
      flash[:notice] = "Successfully updated menu ... "
      redirect_to(manager_view_menu_path)
    end
  end
end

  def add_mess_cut
  #  @arr = ['yes', 'no']
  if ((session[:v] != 1) || !(session[:admin] || session[:password]))
    redirect_to(manager_login_path)
  end
    if request.get?
      @cuts = MessCut.all
    end
    if request.post?
      @cut = MessCut.find(params[:id])
    end
  end

  def update_mess_cut
  #  @cut = MessCut.find(params[:id])
  if ((session[:v] != 1) || !(session[:admin] || session[:password]))
    redirect_to(manager_login_path)
  end
  @cuts = MessCut.all
    if request.patch?

      if @cut.update_attributes(cut_params)
        flash[:notice] = "Successfully updated menu ... "
      #  redirect_to(manager_view_menu_path)
      end
    end
  end

  def per_month_fee_detail
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end

    if request.get?
      @bills = Bill.where(:status => '0')
    end
    if request.post?
      #@menu = Menu.find(params[:id])
    end

  end



  def update_per_month_fee_detail
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
    @bill = Bill.find(params[:id])
    if request.patch?
      if  @bill.update_attributes(fee_params)
        flash[:notice] = "Successfully updated menu ... "
        redirect_to(manager_per_month_fee_detail_path)
      end
    end
  end





  def extra_per_day
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
    if request.get?
      @extra = Extra.new
    end
    if request.post?
        @extra = Extra.new(extra_params)
        if @extra.save
          flash[:notice] = "Successfully created..."
          redirect_to(manager_extra_per_day_path)
        end
   end
  end

  def backup_db
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end

    #system ("backup perform -t db_backup")

  end

def view_stock
  if ((session[:v] != 1) || !(session[:admin] || session[:password]))
    redirect_to(manager_login_path)
  end
    if request.get?
      @stocks = Stock.all

    if request.post?
      @stock = Stock.find(params[:id])
    end
end

  def update_stock
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
    @stock = Stock.find(params[:id])
    if request.patch?
      if  @stock.update_attributes(stock_params)
        flash[:notice] = "Successfully updated stock ... "
        redirect_to(manager_view_stock_path)
      end
    end
  end

  def monthly_profit_analysis
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
  end

  def view_feedback
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
    @feedbacks = Feedback.all
  end

  def update_bill
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end

  end

end

  private
      def student_params

        params.require(:student).permit(:name, :phone, :roll_no, :email, :password)

      end

      def menu_params
        params.require(:menu).permit(:day, :meal1, :meal2, :meal3)
      end

      def stock_params
        params.require(:stock).permit(:stock_id, :stock_name, :quantity, :cost_per_unit)
      end

      def adminn_params
        params.require(:adminn).permit(:admin, :password)
      end

      def extra_params
        params.require(:extra).permit(:roll_no, :item, :date)
      end

      def fee_params
        params.require(:bill).permit(:status)
      end


end
