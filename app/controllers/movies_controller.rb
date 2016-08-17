
class MoviesController < ApplicationController
  
  def index
    @movies = Movie.all
    unless params[:title].blank? 
      @movies = @movies.where('title LIKE?', "%#{params[:title]}%")
    end
    unless params[:director].blank?
      @movies = @movies.where('director LIKE?', "%#{params[:director]}%")
    end
    case params[:runtime_in_minutes]   
      when "1"
        @movies = @movies.where("runtime_in_minutes < ?", 90)
      when "2"
        @movies = @movies.where('runtime_in_minutes > ? AND runtime_in_minutes < ?', "90", "120")
      when "3"
        @movies = @movies.where('runtime_in_minutes > ?', "120")
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted succesfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie), notice: "#{@movie.title} updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end
  

  protected
  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :description, :image, :remove_image, :remote_image_url
      )
  end
end
