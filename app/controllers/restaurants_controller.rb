class RestaurantsController < ApplicationController
  def index
    @q = Restaurant.ransack(params[:q])
    @restaurants = @q.result(:distinct => true).includes(:preference, :city).page(params[:page]).per(10)

    render("restaurants/index.html.erb")
  end

  def show
    @restaurant = Restaurant.find(params[:id])

    render("restaurants/show.html.erb")
  end

  def new
    @restaurant = Restaurant.new

    render("restaurants/new.html.erb")
  end

  def create
    @client = GooglePlaces::Client.new("AIzaSyCrkry5COmBLJFYt60-6C4VDpQfxi10EaY")

    search_query = "#{params[:name]} in #{City.find(params[:city_id]).name}"
    google_search_result = @client.spots_by_query(search_query)

    @restaurant = Restaurant.new

    @restaurant.city_id = params[:city_id]
    @restaurant.preference_id = params[:preference_id]
    @restaurant.name = google_search_result[0]["name"]
    @restaurant.place_id = google_search_result[0]["id"]

    save_status = @restaurant.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/restaurants/new", "/create_restaurant"
        redirect_to("/restaurants")
      else
        redirect_back(:fallback_location => "/", :notice => "Restaurant created successfully.")
      end
    else
      render("restaurants/new.html.erb")
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])

    render("restaurants/edit.html.erb")
  end

  def update
    @client = GooglePlaces::Client.new("AIzaSyCrkry5COmBLJFYt60-6C4VDpQfxi10EaY")

    search_query = "#{params[:name]} in #{City.find(params[:city_id]).name}"
    google_search_result = @client.spots_by_query(search_query)

    @restaurant = Restaurant.find(params[:id])

    @restaurant.city_id = params[:city_id]
    @restaurant.preference_id = params[:preference_id]
    @restaurant.name = google_search_result[0]["name"]

    save_status = @restaurant.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/restaurants/#{@restaurant.id}/edit", "/update_restaurant"
        redirect_to("/restaurants/#{@restaurant.id}", :notice => "Restaurant updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Restaurant updated successfully.")
      end
    else
      render("restaurants/edit.html.erb")
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])

    @restaurant.destroy

    if URI(request.referer).path == "/restaurants/#{@restaurant.id}"
      redirect_to("/", :notice => "Restaurant deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Restaurant deleted.")
    end
  end
end
