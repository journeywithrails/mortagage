class ContentController < ApplicationController
  layout 'content'
  
  before_filter :redirect_from_content, :except => :index
  skip_before_filter :login_required

  def show
    render :action => params[:path].join('/')
  end
  
  def index
    redirect_to "/index.html"
  end

  protected
  def redirect_from_content
    if params[:path][0] == 'content'
      params[:path].shift
      redirect_to "/#{params[:path].join('/')}"
    end
  end
end
