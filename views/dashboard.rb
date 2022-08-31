require_relative 'singIn'
require_relative '../api/api'
require_relative '../theme/theme'
require 'fox16'
include Fox
REGEXP = /\Adata:([-\w]+\/[-\w\+\.]+)?;base64,(.*)/m
class Dashboard < FXMainWindow
    
    def initialize(app,user=nil)
        #API initialize
        @api = API.new()

        user =user["usuario"]
        name = user["name"]
        userId = user["id_usuario"]
        if user == nil 
            alert = FXMessageBox.information(self, MBOX_OK, "Error", "Error de Usuario")
            singIn = SingIn.new(@app)
            singIn.create()
            singIn.show(PLACEMENT_SCREEN)
            self.close()
        else
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
                generarQR(url.text, userId)
            end
            qrImagen=FXLabel.new(self, "", :opts => LAYOUT_CENTER_X)
            qrImagen.icon = FXIPng.new(@app, "somefilename.png")


        end

    end

    def generarQR(url,userId)
        begin
            temp=@api.generate_qr(url,userId)
            temp = JSON.parse(temp)            
            qr = temp['qr_code']['url_code'] #la peticion post me retorna un json con varios valores el cual solo interesa la llave url_code cuyo  valor es un codigo base64  que se generó a partir de la url el cual hay que convertir a imagen            
            convert(qr)
        rescue => e
            puts e , 'URL incorrecta'
        end
    end

    def convert(qr)
        image_data = Base64.decode64(qr['data:image/png;base64,'.length .. -1])
        new_file=File.new("somefilename.png", 'wb')
        new_file.write(image_data)
        
    end 



    def create
        super
        show(PLACEMENT_SCREEN)
    end
end