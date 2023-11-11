class MoviesController < ApplicationController

      # params hash looks like this:
    # {"the_title"=>"1", "the_year"=>"2", "the_duration"=>"3", "the_description"=>"4", "the_image"=>"5", "the_director_id"=>"6"} 

    def destroy
      # Find the movie to be deleted by its ID
      movie_id_to_delete = params.fetch("an_id")
      movie_to_delete = Movie.find(movie_id_to_delete)
    
      # Delete the movie
      movie_to_delete.destroy
    
      # Redirect to the movies index page
      redirect_to("/movies")
    end

    def update
      # Get the ID out of params
      m_id = params.fetch("the_id")
  
      # Look up the existing record
      matching_records = Movie.where({ :id => m_id })
      the_movie = matching_records.at(0)
  
      # Overwrite each column with the values from user inputs
      the_movie.title = params.fetch("the_title")
      the_movie.year = params.fetch("the_year")
      the_movie.duration = params.fetch("the_duration")
      the_movie.description = params.fetch("the_description")
      the_movie.image = params.fetch("the_image")
      the_movie.director_id = params.fetch("the_director_id")
  
      # Save
  
      the_movie.save
  
      # Redirect to the movie details page
      redirect_to("/movies/#{the_movie.id}")
    end
  
  def create
    m = Movie.new
    
    # Overwrite each column with the values from user inputs
    m.title = params.fetch("title")
    m.year = params.fetch("year")
    m.duration = params.fetch("duration")
    m.description = params.fetch("description")
    m.image = params.fetch("image")
    m.director_id = params.fetch("director_id")

    # Save

    m.save

    # Redirect to the movie details page
    redirect_to("/movies")
  end

   
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
