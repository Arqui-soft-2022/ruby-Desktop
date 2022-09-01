require_relative 'singIn'
require_relative '../api/api'
require_relative '../theme/theme'
require_relative 'dashboardQr'
require 'fox16'
include Fox
REGEXP = /\Adata:([-\w]+\/[-\w\+\.]+)?;base64,(.*)/m
class History < FXMainWindow
    def initialize(app, userId, name,state)
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
        FXLabel.new(self, "Codigos Qr Generados de #{name}", :opts => LAYOUT_CENTER_X)
        
    end
    def create
        super
        show(PLACEMENT_SCREEN)
    end
end