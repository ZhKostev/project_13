class Admin::RubricsController < Admin::BaseController
  before_filter :find_resource_or_404, :only => [:show, :edit, :update, :destroy]

  def index
    @rubrics = Rubric.page(params[:page])
  end

  def show
  end

  def new
    @rubric = Rubric.new
  end

  def edit
  end

  def create
    @rubric = Rubric.new(rubric_params)
    if @rubric.save
      redirect_to admin_rubric_path(@rubric), notice: 'Rubric was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @rubric.update(rubric_params)
      redirect_to admin_rubric_path(@rubric), notice: 'Rubric was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @rubric.destroy
    redirect_to admin_rubrics_url
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def rubric_params
    params.require(:rubric).permit(:language, :title)
  end
end
