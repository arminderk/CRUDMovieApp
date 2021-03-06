class MoviesController < ApplicationController
  
  layout "application"
  before_action :authenticate_user!, only: [:delete]
  
  
  def index
    if params[:genre].present?
      @movies = Movie.where(genre: params[:genre])

      respond_to do |format|
        format.js {}
      end

    else
      @movies = Movie.order(:name)
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments
    @comment = Comment.new
  end

  def new
    @movie = Movie.new
  end
  
  def create
    #Instantiate a new object using form parameters
    @movie = Movie.new(movie_params)
    #Save the object
    if @movie.save
      #If save succeeds, redirect back to the index page
      redirect_to(:action => 'index')
    else
      #If save fails, redisplay the form so user can fix problems and resubmit
      render('new')
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end
  
  def update
    #Find an exisiting object using form parameters
    @movie = Movie.find(params[:id])
    #Update the object
    if @movie.update_attributes(movie_params)
      #If update succeeds, redirect back to the show page
      redirect_to(:action => 'show', :id => @movie.id)
    else
      #If save fails, redisplay the form so user can fix problems and resubmit
      render('edit')
    end
  end

  def delete
    @movie = Movie.find(params[:id])
  end
  
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to(:action => 'index')
  end
  
  private
    def movie_params
      params.require(:movie).permit(:name, :rated, :genre, :director, :year, :description)
    end
end
