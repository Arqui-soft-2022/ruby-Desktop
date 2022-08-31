#My imports
require_relative 'userRegister'
require_relative '../theme/theme'
require_relative 'dashboard'
require_relative '../api/api'
#General imports
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

        #API initialize
        @api = API.new()
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
            if usuario.text=="" or password.text==""
                alert = FXMessageBox.information(self, MBOX_OK, "Error", "Campos vacios")
            elsif @api.check_connection
                res = @api.login_user(usuario.text, password.text)
                res= JSON.parse(res)
                if res.has_key?("errors")
                    alert = FXMessageBox.information(self, MBOX_OK, "Inicio de Sesion", "Usuario o contraseña incorrectos")
                elsif res.has_key?("usuario")
                    dashboard = Dashboard.new(@app, res)
                    dashboard.create()
                    dashboard.show(PLACEMENT_SCREEN)
                    self.close()
                else
                    alert = FXMessageBox.information(self, MBOX_OK, "Inicio de Sesion", "Error, intenta nuevamente")
                end
            else
                alert = FXMessageBox.information(self, MBOX_OK, "Error", "No hay conexion al servicio")
            end
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

