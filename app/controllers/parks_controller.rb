class ParksController < ApplicationController
  def index
    @dog_parks  = Park.all
    render json: @dog_parks
  end

  def geojson
    @parks = Park.all
    @parks_geojson = Array.new

    @parks.each do |park|
      @parks_geojson << {
        :"type"=> 'Feature',
        :"geometry"=> {
          :"type"=> 'Point',
          :"coordinates"=> [park.longitude, park.latitude]
        },
        :"properties"=> {
          :"title"=> park.title,
          :"address"=> park.address,
          :"description"=> park.description,
          :'marker-color'=> '#00607d',
          :'marker-symbol'=> 'circle',
          :'marker-size'=> 'medium',
        }
      }
    end

    @geojson=[{
      :"type"=> "FeatureCollection",
      :"features"=> @parks_geojson
      }]
    render json: @geojson
  end
end
