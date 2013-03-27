class Admin::ArticlesController < Admin::BaseController
  before_filter :find_resource_or_404, :only => [:show, :edit, :update, :destroy]
  before_filter :find_variables_for_form, :only => [:new, :edit]

  def index
    @articles = Article.page(params[:page])
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to admin_article_path(@article), notice: 'Article was successfully created.'
    else
      find_variables_and_render('new')
    end
  end

  def update
    if @article.update(article_params)
      redirect_to admin_article_path(@article), notice: 'Article was successfully updated.'
    else
      find_variables_and_render('edit')
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_url
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :meta_description, :short_description, :body, :language)
  end

  #setup variables for article form
  def find_variables_for_form
    @rubrics = Rubric.for_language(:ru)
  end

  #find variables, call callbacks and render action
  def find_variables_and_render(action)
    find_variables_for_form
    render action: action
  end
end
