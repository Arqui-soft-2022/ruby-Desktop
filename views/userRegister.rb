
require_relative '../api/api'
require_relative 'singIn'
require_relative '../theme/theme'
require 'fox16'
include Fox
class UserRegister < FXMainWindow
    def initialize(app)
        @app = app
        @api = API.new()
        theme=Theme.new()
        super(app, "Qr Generator", :width => 1333, :height => 720)
        registro = FXLabel.new(self, "Registro", :opts => LAYOUT_CENTER_X)
        FXLabel.new(self, "Usuario", :opts => LAYOUT_CENTER_X)
        user = FXTextField.new(self,50, :opts => LAYOUT_CENTER_X)
        FXLabel.new(self, "Contraseña", :opts => LAYOUT_CENTER_X)
        password = FXTextField.new(self,50, :opts => LAYOUT_CENTER_X|TEXTFIELD_PASSWD)
        FXLabel.new(self, "Email", :opts => LAYOUT_CENTER_X)
        email = FXTextField.new(self,50, :opts => LAYOUT_CENTER_X)
        FXLabel.new(self, "Nombre", :opts => LAYOUT_CENTER_X)
        name= FXTextField.new(self,50, :opts => LAYOUT_CENTER_X)
        registroButton = FXButton.new(self, "Registrar", :opts => LAYOUT_CENTER_X,:padLeft => 20, :padRight => 20)
        registroButton.font = theme.fuenteVerdana150Bold(@app)
        registroButton.textColor= theme.whiteColor()
        registroButton.backColor= theme.secondaryColor()
        registroButton.connect(SEL_COMMAND) do
            res=@api.register_user(user.text, password.text, email.text, name.text)
            res= JSON.parse(res)
            puts res
            if res.has_key?("errors")
                puts "El usuario ya existe"
                alert = FXMessageBox.information(self, MBOX_OK, "Registro", "El usuario ya existe")
            elsif res.has_key?("msg") 
                puts "Registrado con exito"
                alert = FXMessageBox.information(self, MBOX_OK, "Registro", "Registro Exitoso")
                if alert == 3 
                    singIn = SingIn.new(@app)
                    singIn.create()
                    singIn.show(PLACEMENT_SCREEN)
                    self.close()
                end
            else 
                alert = FXMessageBox.information(self, MBOX_OK, "Registro", "Error, intenta nuevamente")
                puts "Error"
            end
        end

    end
    def create
        super
        show(PLACEMENT_SCREEN)
    end
end

