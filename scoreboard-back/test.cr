Game.clear
g = Game.new(type: "volleyball", name: "melissiakos", password: "pass")
puts(g.password)
g.save
g = Game.first!
puts(g.password)
puts(g.hashed_password)
puts(g.authenticate("pass"))
puts(g.authenticate("wrong"))
