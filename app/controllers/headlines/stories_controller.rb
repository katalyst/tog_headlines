class Headlines::StoriesController < ApplicationController
  
  def show
    @story = Story.find(params[:id])
    # SMELL: this isn't very elegant, but users should only see this if they're crafting urls
    raise 'not permitted' unless @story.visible_to(current_user)
  end

  def by_tag
    @tag  =  Tag.find_by_name(params[:tag])
    @stories = Story.published.find_tagged_with(params[:tag])
  end

  def index
    @order = params[:order] || 'publish_date'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'desc'    
    @stories = Story.published.paginate :per_page => Tog::Config['plugins.tog_headlines.pagination_size'],
                                  :page => @page,
                                  :order => @order + " " + @asc
                                  
    @stories = @stories.select{ |s| s.visible_to(current_user) }
    respond_to do |format|
      format.html
      format.atom { render(:layout => false) }
    end                                  
  end
  
end
