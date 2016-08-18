
class MoviesController < ApplicationController
  
  def index
    @movies = Movie.all
    @movies = @movies.title_query(params[:title]) if params[:title].present?
    @movies = @movies.director_query(params[:director]) if params[:director].present?
    @movies = @movies.runtime_query1(params[:runtime_in_minutes]) if params[:runtime_in_minutes] == "1"
    @movies = @movies.runtime_query2(params[:runtime_in_minutes]) if params[:runtime_in_minutes] == "2"
    @movies = @movies.runtime_query3(params[:runtime_in_minutes]) if params[:runtime_in_minutes] == "3"
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
