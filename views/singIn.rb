require_relative 'userRegister'
require_relative '../theme/theme'
require_relative 'dashboard'
require 'fox16'
include Fox

class SingIn < FXMainWindow
    def initialize(app)
        theme=Theme.new()
        @app = app
        super(app, "Qr Generator", 
        :width => 720, 
        :height => 720, 
        :padLeft => 10, 
        :padRight => 10, 
        :padTop => 10, 
        :padBottom => 10)
        #fondo
        
        #Pantalla inicial
        saludo=FXLabel.new(self, "Bienvenido al Generador de Qr", :opts => LAYOUT_CENTER_X)
        saludo.font = theme.fuenteVerdana250Bold(@app)
        saludo.textColor=theme.blackColor()
        usuario = FXTextField.new(self,30, :opts => LAYOUT_CENTER_X)
        usuario.helpText="Usuario"
        usuario.tipText="Usuario"
        usuario.font = theme.fuenteVerdana100(@app)
        password = FXTextField.new(self,30, :opts => LAYOUT_CENTER_X|TEXTFIELD_PASSWD)
        password.helpText="Contraseña"
        password.tipText="Contraseña"
        password.font = theme.fuenteVerdana100(@app)
        
        iniciarButton = FXButton.new(self, "Iniciar Sesion", :opts => LAYOUT_CENTER_X,:padLeft => 20, :padRight => 20)
        iniciarButton.font = theme.fuenteVerdana150Bold(@app)
        iniciarButton.textColor=theme.whiteColor()
        iniciarButton.backColor=theme.secondaryColor()
        iniciarButton.connect(SEL_COMMAND) do
            dato="hola"
            dashboard=Dashboard.new(@app,dato)
            dashboard.create()
            dashboard.show(PLACEMENT_SCREEN)
            self.close()
            puts "Iniciar Sesion"
        end
        noCuenta =FXLabel.new(self, "¿Aún no tienes cuenta?", :opts => LAYOUT_CENTER_X, :padLeft => 10, :padRight => 10)
        noCuenta.font = theme.fuenteVerdana100Bold(@app)
        register=FXButton.new(self, "Registrarse", :opts => LAYOUT_CENTER_X)
        register.font = theme.fuenteVerdana100Bold(@app)
        register.textColor=theme.secondaryColorDark()
        register.connect(SEL_COMMAND) do            
            userRegister=UserRegister.new(@app)
            userRegister.create()
            userRegister.show(PLACEMENT_SCREEN)
            self.close()
            puts "Registrarse"
        end
    end

    def create
        super
        show(PLACEMENT_SCREEN)
    end
end

