class ShopsController < ApplicationController
  def index
    @q = Shop.ransack(params[:q])
    @shops = @q.result(:distinct => true).includes(:preference, :city).page(params[:page]).per(10)

    render("shops/index.html.erb")
  end

  def show
    @shop = Shop.find(params[:id])

    render("shops/show.html.erb")
  end

  def new
    @shop = Shop.new

    render("shops/new.html.erb")
  end

  def create

    @client = GooglePlaces::Client.new("AIzaSyCrkry5COmBLJFYt60-6C4VDpQfxi10EaY")

    search_query = "#{params[:name]} in #{City.find(params[:city_id]).name}"
    google_search_result = @client.spots_by_query(search_query)

    @shop = Shop.new

    @shop.city_id = params[:city_id]
    @shop.preference_id = params[:preference_id]
    @shop.name = google_search_result[0]["name"]

    save_status = @shop.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/shops/new", "/create_shop"
        redirect_to("/shops")
      else
        redirect_back(:fallback_location => "/", :notice => "Shop created successfully.")
      end
    else
      render("shops/new.html.erb")
    end
  end

  def edit
    @shop = Shop.find(params[:id])

    render("shops/edit.html.erb")
  end

  def update
    @client = GooglePlaces::Client.new("AIzaSyCrkry5COmBLJFYt60-6C4VDpQfxi10EaY")

    search_query = "#{params[:name]} in #{City.find(params[:city_id]).name}"
    google_search_result = @client.spots_by_query(search_query)

    @shop = Shop.find(params[:id])

    @shop.city_id = params[:city_id]
    @shop.preference_id = params[:preference_id]
    @shop.name = google_search_result[0]["name"]

    save_status = @shop.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/shops/#{@shop.id}/edit", "/update_shop"
        redirect_to("/shops/#{@shop.id}", :notice => "Shop updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Shop updated successfully.")
      end
    else
      render("shops/edit.html.erb")
    end
  end

  def destroy
    @shop = Shop.find(params[:id])

    @shop.destroy

    if URI(request.referer).path == "/shops/#{@shop.id}"
      redirect_to("/", :notice => "Shop deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Shop deleted.")
    end
  end
end
