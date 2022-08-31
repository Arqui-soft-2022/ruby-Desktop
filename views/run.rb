require_relative 'singIn'
app = FXApp.new
SingIn.new(app)
app.create
app.run
