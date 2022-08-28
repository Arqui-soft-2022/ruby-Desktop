require_relative 'singIn'
require 'fox16'
include Fox
class UserRegister < FXMainWindow
    def initialize(app)
        @app = app
        super(app, "Qr Generator", :width => 1333, :height => 720)
        registro = FXLabel.new(self, "Registro", :opts => LAYOUT_CENTER_X)
        name= FXTextField.new(self,50, :opts => LAYOUT_CENTER_X)
        user = FXTextField.new(self,50, :opts => LAYOUT_CENTER_X)
        password = FXTextField.new(self,50, :opts => LAYOUT_CENTER_X)
        email = FXTextField.new(self,50, :opts => LAYOUT_CENTER_X)
        registroButton = FXButton.new(self, "Registrar", :opts => LAYOUT_CENTER_X)
        registroButton.connect(SEL_COMMAND) do
            alert = FXMessageBox.information(self, MBOX_OK, "Registro", "Registro Exitoso")
            puts "Registro Exitoso 1 #{alert}" 
            if alert == 3 then
                singIn = SingIn.new(@app)
                singIn.create()
                singIn.show(PLACEMENT_SCREEN)
                self.close()
            end

        end

    end
    def create
        super
        show(PLACEMENT_SCREEN)
    end
end

