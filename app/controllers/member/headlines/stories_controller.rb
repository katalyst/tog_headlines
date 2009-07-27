class Member::Headlines::StoriesController < Member::BaseController
  
  def new
    @story = Story.new(:state => 'draft')
  end
  
  def create
    @story = Story.new(params[:story])
    @story.owner = current_user
    @story.publisher = current_user
    @story.editor = current_user
    @story.portal = false
    @story.save!
    flash[:ok] = I18n.t("tog_headlines.member.story_created")
    redirect_to headlines_story_path(@story)
    rescue ActiveRecord::RecordInvalid
    flash[:error] = I18n.t("tog_headlines.member.error_creating")
    render :action => :new
  end
  
  def edit
    @story = Story.find(params[:id])
  end
  
  def update
    @story = Story.find(params[:id])    
    @story.editor = current_user

    attributes = params[:story]
    groups = attributes[:groups]
    groups.delete('0')
    @story.groups = Group.find(groups)
    attributes.delete(:groups)
    @story.attributes = attributes

    if @story.save
      @story.publish! if @story.published?
      @story.archive! if @story.archived?
      flash[:ok] = I18n.t("tog_headlines.member.story_updated")
      redirect_to headlines_story_path(@story)
    else
      render :action => 'edit'
    end
  end
  
end
