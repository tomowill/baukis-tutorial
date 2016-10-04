class Customer::ProgramsController < Customer::Base
  def index
#    @programs = Program.published.page(params[:page])
     @programs = Program.find_by_sql(['select programs.* from programs'])
     @programs = Kaminari.paginate_array(@programs).page(params[:page]).per(10)
  end

  def show
    @program = Program.published.find(params[:id])
  end
end
