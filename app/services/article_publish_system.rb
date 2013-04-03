class ArticlePublishSystem
  def initialize(article)
    @article = article
  end

  #add callback for publishing
  def save(submit_type)
    if to_publish?(submit_type)
      @article.save
      make_clone
    else
      @article.save
    end
  end

  #add callback for publishing
  def update(article_params, submit_type)
    if to_publish?(submit_type)
      @article.update(article_params)
      make_or_update_clone
    else
      @article.update(article_params)
    end
  end

  #make clone with rubrics, set original id and save
  def make_clone
    @article.reload
    clone = @article.dup(:include => [:rubrics])
    clone.origin_id = @article.id
    clone.save
  end

  def make_or_update_clone
    return make_clone unless @article.front_clone
    clone = @article.front_clone
    clone.attributes = @article.attributes.except('id', 'origin_id', 'created_at', 'updated_at')
    clone.rubrics = @article.rubrics
    clone.save
  end

  private
  #return true if user want to publish article
  def to_publish?(submit_type)
    @article.valid? && submit_type == 'Publish'
  end
end