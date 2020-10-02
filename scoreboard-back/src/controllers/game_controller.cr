class GameController < ApplicationController
  def index
    games = Game.all
    respond_with 200 do
      json games.map{|g| g.preview}.to_json
    end
  end

  def show
    if game = Game.find params["id"]
      respond_with 200 do
        json game.full.to_json
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def create
    game = Game.new(game_params.validate!)

    if game.valid? && game.save
      respond_with 201 do
        json game.full.to_json
      end
    else
      results = {status: "invalid", errors: game.errors}
      respond_with 422 do
        json results.to_json
      end
    end
  end

  def destroy
    if game = Game.find params["id"]
      if(!game.authenticate(params["password"]))
        results = {status: "not authenticated"}
        return respond_with 404 do
          json results.to_json
        end
      end
      game.destroy
      respond_with 204 do
        json ""
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def authenticate
    if game = Game.find(params["id"])
      if(game.authenticate(params["password"]))
        respond_with 200 do
          json ""
        end
      else
        respond_with 401 do
          json ""
        end
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def update_data
    if game = Game.find(params["id"])
      if(!game.authenticate(params["password"]))
        results = {status: "not authenticated"}
        return respond_with 404 do
          json results.to_json
        end
      end
      body = request.body
      game.update!(data: body.gets) if body
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def game_params
    params.validation do
      optional(:name, msg: nil, allow_blank: true)
      optional(:type, msg: nil, allow_blank: true)
      optional(:password, msg: nil, allow_blank: true)
    end
  end
end
