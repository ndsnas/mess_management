class ManagerController < ApplicationController
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

  end

  def update_mess_cut
  end

  def per_month_fee_detail
  end

  def extra_per_day
  end

  def backup_db
  end

  def view_stock
    @stocks = Stock.all
  end

  def update_stock
  end

  def monthly_profit_analysis
  end

  def view_feedback
    @feedbacks = Feedback.all
  end


  private
      def student_params

        params.require(:student).permit(:name, :phone, :roll_no, :email, :password)

      end

      def menu_params
        params.require(:menu).permit(:day, :meal1, :meal2, :meal3)
      end

end
