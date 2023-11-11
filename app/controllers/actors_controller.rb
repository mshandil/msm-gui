class ActorsController < ApplicationController
# app/controllers/actors_controller.rb
class ActorsController < ApplicationController
  # Existing actions...

  def destroy
    # Find the actor to be deleted by its ID
    actor_id_to_delete = params.fetch("an_id")
    actor_to_delete = Actor.find(actor_id_to_delete)

    # Delete the actor
    actor_to_delete.destroy

    # Redirect to the actors index page
    redirect_to("/actors")
  end

  def update
    # Find the actor to be updated by its ID
    actor_id_to_update = params.fetch("the_id")
    actor_to_update = Actor.find(actor_id_to_update)

    # Update actor attributes based on user inputs
    actor_to_update.name = params.fetch("name")
    actor_to_update.dob = params.fetch("dob")
    actor_to_update.bio = params.fetch("bio")
    actor_to_update.image = params.fetch("image")

    # Save the updated actor
    actor_to_update.save

    # Redirect to the actors index page
    redirect_to("/actors")
  end
end

  
  def create
    actor = Actor.new
  
    # Assign values from user inputs
    actor.name = params.fetch("name")
    actor.dob = params.fetch("dob")
    actor.bio = params.fetch("bio")
    actor.image = params.fetch("image")
  
    # Save the actor record
    actor.save
  
    # Redirect to the actors index page
    redirect_to("/actors")
  end
  
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
