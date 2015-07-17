class SubsController < ApplicationController
  before_action :redirect_unless_moderator, only: [:edit, :update]

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def redirect_unless_moderator
    redirect_to subs_url unless current_user == Sub.find(params[:id]).moderator
  end
end
