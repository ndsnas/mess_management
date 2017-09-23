class ManagerController < ApplicationController

def login
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
      redirect_to(manager_dashboard_path)
    end
    else
      @error = 1
    end
    # @logintable = Login.all

  end




def add_student
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
  if request.get?
    @menus = Menu.all
  end
  if request.post?
    @menu = Menu.find(params[:id])
  end
end


def update_menu
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
    if request.get?
      @cuts = MessCut.all
    end
    if request.post?
      @cut = MessCut.find(params[:id])
    end
  end

  def update_mess_cut
  #  @cut = MessCut.find(params[:id])
  @cuts = MessCut.all
    if request.patch?

      if @cut.update_attributes(cut_params)
        flash[:notice] = "Successfully updated menu ... "
      #  redirect_to(manager_view_menu_path)
      end
    end
  end

  def per_month_fee_detail
  end

  def extra_per_day

  end

  def backup_db
  end

def view_stock
    if request.get?
      @stocks = Stock.all
    endroll_no
    if request.post?
      @stock = Stock.find(params[:id])
    end
end

  def update_stock
    @stock = Stock.find(params[:id])
    if request.patch?
      if  @stock.update_attributes(stock_params)
        flash[:notice] = "Successfully updated stock ... "
        redirect_to(manager_view_stock_path)
      end
    end
  end

  def monthly_profit_analysis
  end

  def view_feedback
    @feedbacks = Feedback.all
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
end
