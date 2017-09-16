class ManagerController < ApplicationController
  def add_student


  #  @student = Student.new
  if request.get?
  @student = Student.new()
  puts '123'

end
#if(student_params.has_key?(:roll_no))
if request.post?
  puts @student
  flash[:notice] = "Successfully created..."
  puts 'abc'

 if @student.save(student_params)

    flash[:notice] = "Successfully created..."
end
#  else
#
 end


  end

  def create

  end

  def delete_student
  end

  def view_menu
    @menus = Menu.all
  end

  def update_menu
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
  end

  def update_stock
  end

  def monthly_profit_analysis
  end

  def view_feedback
  end

  def show
  end

  private
      def student_params

        params.require(:roll_no).permit(:name, :phone, :email)

      end

end
