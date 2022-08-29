require_relative 'singIn'
require 'fox16'
include Fox
class Dashboard < FXMainWindow
    
    def initialize(app,dato)
        @app = app
        super(app, "Qr Generator", :width => 1333, :height => 720)
        menuBar = FXMenuBar.new(self, LAYOUT_SIDE_TOP|LAYOUT_FILL_X|FRAME_RIDGE|LAYOUT_RIGHT)
        menuPane = FXMenuPane.new(self)
        FXMenuTitle.new(menuBar, "Usuario", :popupMenu => menuPane)
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
        text = FXLabel.new(self,"dato #{dato}", :opts => LAYOUT_CENTER_X)

    end
    def create
        super
        show(PLACEMENT_SCREEN)
    end
end