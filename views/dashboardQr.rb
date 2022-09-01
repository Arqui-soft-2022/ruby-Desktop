require_relative 'singIn'
require_relative '../api/api'
require_relative '../theme/theme'
require_relative 'dashboard'
require 'fox16'
include Fox
REGEXP = /\Adata:([-\w]+\/[-\w\+\.]+)?;base64,(.*)/m
class DashboardQr < FXMainWindow
    def initialize(app, userId, name,state)
        
        puts "DashboardQr state: #{state} name: #{name} userId: #{userId}"
        #API initialize
        @api = API.new()
        @app = app
        theme = Theme.new()
        super(app, "Qr Generator", :width => 1333, :height => 720)
        menuBar = FXMenuBar.new(self, LAYOUT_SIDE_TOP|LAYOUT_FILL_X|FRAME_RIDGE|LAYOUT_RIGHT)
        menuBar.backColor = theme.primaryColorLight()
        menuPane = FXMenuPane.new(self)
        FXMenuTitle.new(menuBar, "#{name}", :popupMenu => menuPane)
        o1=FXMenuCommand.new(menuPane, "Ver Historial")
        o2=FXMenuCommand.new(menuPane, "Cerrar Sesion")
        o1.connect(SEL_COMMAND) do
            puts "Ver Historial"
        end
        o2.connect(SEL_COMMAND) do
            singIn = SingIn.new(@app)
            singIn.create()
            singIn.show(PLACEMENT_SCREEN)
            self.close()
            puts "Cerrar Sesion"
        end
        FXLabel.new(self, "Bienvenido #{name}", :opts => LAYOUT_CENTER_X)
        FXLabel.new(self, "Genere su Codigo QR", :opts => LAYOUT_CENTER_X)
        FXLabel.new(self, "Sitio Web (URL)", :opts => LAYOUT_CENTER_X)
        url = FXTextField.new(self,50, :opts => LAYOUT_CENTER_X)
        qrButton = FXButton.new(self, "Generar", :opts => LAYOUT_CENTER_X,:padLeft => 20, :padRight => 20)
        qrButton.backColor = theme.primaryColor()
        qrButton.font = theme.fuenteVerdana150Bold(@app)
        qrButton.textColor = theme.whiteColor()
        qrButton.connect(SEL_COMMAND) do
            puts userId
            generarQR(url.text, userId,name)
        end
        if state 
            puts "logo.png 1"
            @icono = FXPNGIcon.new(@app, File.open("logo.png", "rb").read)
            @qrImagen = FXLabel.new(self,"", :opts => LAYOUT_CENTER_X)
            @qrImagen.icon = @icono
        else
            puts "qr.png 1"
            @icono = FXPNGIcon.new(@app, File.open("qr.png", "rb").read)
            @qrImagen = FXLabel.new(self,"", :opts => LAYOUT_CENTER_X)
            @qrImagen.icon = @icono
        end
    end
    def generarQR(url,userId,name)
        begin
            temp=@api.generate_qr(url,userId)
            temp = JSON.parse(temp)            
            qr = temp['qr_code']['url_code'] #la peticion post me retorna un json con varios valores el cual solo interesa la llave url_code cuyo  valor es un codigo base64  que se generó a partir de la url el cual hay que convertir a imagen            
            convert(qr,userId,name)
        rescue => e
            puts e , 'URL incorrecta'
        end
    end
    def convert(qr,userId,name)
        image_data = Base64.decode64(qr['data:image/png;base64,'.length .. -1])
        new_file=File.new("qr.png", 'wb')
        new_file.write(image_data)    
        new_file.close()
        goTo(userId,name)    
    end 
    def goTo(userId,name)
        d = Dashboard.new(@app, userId, name,false)
        d.create()
        d.show(PLACEMENT_SCREEN)
        self.close()
    end
    def create
        super
        show(PLACEMENT_SCREEN)
    end
end