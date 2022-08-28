require_relative 'userRegister'
require_relative 'dashboard'
require 'fox16'
include Fox

class SingIn < FXMainWindow
    def initialize(app)
        @app = app
        @primaryColor=FXRGB(92, 106, 196)
        @secondaryColor=FXRGB(132, 140, 220)
        @primaryColorDark = FXRGB(35, 43, 97)
        @secondaryColorDark = FXRGB(105, 115, 184)
        @primaryColorLight = FXRGB(175, 179, 210)
        @whiteColor = FXRGB(255, 255, 255)
        @blackColor = FXRGB(0, 0, 0)
        super(app, "Qr Generator", :width => 1333, :height => 720)
        #Pantalla inicial
        saludo=FXLabel.new(self, "Bienvenido al Generador de Qr", :opts => LAYOUT_CENTER_X)
        fuente=FXFont.new(app,"Moderm, 250, Bold, 0")
        saludo.font = fuente
        saludo.textColor=@blackColor
        usuario = FXTextField.new(self,50, :opts => LAYOUT_CENTER_X)
        password = FXTextField.new(self,50, :opts => LAYOUT_CENTER_X)
        iniciarButton = FXButton.new(self, "Iniciar Sesion", :opts => LAYOUT_CENTER_X)
        iniciarButton.connect(SEL_COMMAND) do
            dato="hola"
            dashboard=Dashboard.new(@app,dato)
            dashboard.create()
            dashboard.show(PLACEMENT_SCREEN)
            self.close()
            puts "Iniciar Sesion"
        end
        noCuenta =FXLabel.new(self, "¿Aún no tienes cuenta?", :opts => LAYOUT_CENTER_X, :padLeft => 10, :padRight => 10)
        register=FXButton.new(self, "Registrarse", :opts => LAYOUT_CENTER_X)
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

