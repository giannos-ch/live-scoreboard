require "uuid"
require "crypto/bcrypt/password"

class Game < Granite::Base
  connection pg
  table games

  column id : String, primary: true, auto: false
  column type : String
  column name : String
  column data : String = ""
  column hashed_password : String

  property password = ""

  timestamps

  before_create :assign_id
  before_save :hash_password

  def assign_id
    @id = UUID.random.to_s
  end

  def hash_password
    if(!password.empty?)
      @hashed_password = Crypto::Bcrypt::Password.create(password, cost=7).to_s
    end
  end

  def preview
    {id: id, type: type, name: name}
  end

  def full
    {id: id, type: type, name: name, data: data}
  end

  def authenticate(password : String)
    Crypto::Bcrypt::Password.new(hashed_password).verify(password)
  end
end
