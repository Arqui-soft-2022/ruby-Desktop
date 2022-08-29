
class Theme 
    def primaryColor()
        return FXRGB(92, 106, 196)
    end
    def secondaryColor()
        return FXRGB(132, 140, 220)
    end
    def secondaryColorDark()
        return FXRGB(105, 115, 184)
    end
    def primaryColorLight()
        return FXRGB(175, 179, 210)
    end
    def whiteColor()
        return FXRGB(255, 255, 255)
    end
    def blackColor()
        return FXRGB(0, 0, 0)
    end

    def fuenteModerm(app)
        return FXFont.new(app,"Moderm, 250, Bold, 0")
    end
    def fuenteVerdana250Bold(app)
        return FXFont.new(app,"Verdana, 250, Bold, 0")
    end
    def fuenteVerdana150(app)
        return FXFont.new(app,"Verdana, 150, 0")
    end
    def fuenteVerdana150Bold(app)
        return FXFont.new(app,"Verdana, 150, Bold, 0")
    end
    def fuenteVerdana100Bold(app)
        return FXFont.new(app,"Verdana, 100, Bold, 0")
    end
    def fuenteVerdana100(app)
        return FXFont.new(app,"Verdana, 100, 0")
    end
end
