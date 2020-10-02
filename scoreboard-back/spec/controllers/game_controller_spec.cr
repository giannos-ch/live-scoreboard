require "./spec_helper"

def game_hash
  {"type" => "Fake", "data" => "Fake", "password" => "Fake"}
end

def game_params
  params = [] of String
  params << "type=#{game_hash["type"]}"
  params << "data=#{game_hash["data"]}"
  params << "password=#{game_hash["password"]}"
  params.join("&")
end

def create_game
  model = Game.new(game_hash)
  model.save
  model
end

class GameControllerTest < GarnetSpec::Controller::Test
  getter handler : Amber::Pipe::Pipeline

  def initialize
    @handler = Amber::Pipe::Pipeline.new
    @handler.build :api do
      plug Amber::Pipe::Error.new
      plug Amber::Pipe::Session.new
    end
    @handler.prepare_pipelines
  end
end

describe GameControllerTest do
  subject = GameControllerTest.new

  it "renders game index json" do
    Game.clear
    model = create_game
    response = subject.get "/games"

    response.status_code.should eq(200)
    response.body.should contain("Fake")
  end

  it "renders game show json" do
    Game.clear
    model = create_game
    location = "/games/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Fake")
  end

  it "creates a game" do
    Game.clear
    response = subject.post "/games", body: game_params

    response.status_code.should eq(201)
    response.body.should contain "Fake"
  end

  it "updates a game" do
    Game.clear
    model = create_game
    response = subject.patch "/games/#{model.id}", body: game_params

    response.status_code.should eq(200)
    response.body.should contain "Fake"
  end

  it "deletes a game" do
    Game.clear
    model = create_game
    response = subject.delete "/games/#{model.id}"

    response.status_code.should eq(204)
  end
end
