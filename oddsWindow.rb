#Bloque de importaciones
require 'tk'
require_relative 'BedChart'

#Método para inicializar y configurar la ventana de odds
def openOddsWindow
  oddsWindow = TkToplevel.new do
      title "Odds"
      geometry "#{WIDTH}x#{HEIGHT}"
  end

  root = TkRoot.new do
    background '#F5F7FA' 
    geometry "#{WIDTH}x#{HEIGHT}"
    end

  #Texto de bienvenida al módulo
  Tk::Label.new(oddsWindow) do
    text "¡Bienvenido al módulo para el calculo de Odds!"
    font 'Arial 10 bold'
    pack('pady' => 30)
  end

  #Marco contenedor del formulario de entrada de datos
  formFrame = Tk::Frame.new(oddsWindow) do
    pack('pady' => 15)
  end

  #Campo de texto y etiqueta para el total de camas
  Tk::Label.new(formFrame) { text "Total de camas:"; grid('row' => 0, 'column' => 0, 'padx' => 10, 'pady' => 10, 'sticky' => 'e') }
  totalBedsField = Tk::Entry.new(formFrame) do
    width 25
    grid('row' => 0, 'column' => 1, 'padx' => 10, 'pady' => 10, 'sticky' => 'w')
  end

  #Campo de texto y etiqueta para el total de camas públicas
  Tk::Label.new(formFrame) { text "Total de camas publicas:"; grid('row' => 1, 'column' => 0, 'padx' => 10, 'pady' => 10, 'sticky' => 'e') }
  publicBedsField = Tk::Entry.new(formFrame) do
    width 25
    grid('row' => 1, 'column' => 1, 'padx' => 10, 'pady' => 10, 'sticky' => 'w')
  end

  #Campo de texto y etiqueta para el total de camas privadas
  Tk::Label.new(formFrame) { text "Total de camas privadas:"; grid('row' => 2, 'column' => 0, 'padx' => 10, 'pady' => 10, 'sticky' => 'e') }
  privateBedsField = Tk::Entry.new(formFrame) do
    width 25
    grid('row' => 2, 'column' => 1, 'padx' => 10, 'pady' => 10, 'sticky' => 'w')
  end

  #Marco contenedor para la sección de resultados
  resultFrame = Tk::Frame.new(oddsWindow) do
    pack()
  end

  #Etiqueta descriptiva y campo de texto/resultado dinámico
  Tk::Label.new(resultFrame) { text "Resultado:"; grid('row' => 0, 'column' => 0, 'padx' => 5, 'pady' => 5, 'sticky' => 'e') }
  labelResult = Tk::Label.new(resultFrame) do
    text "--------------"
    grid('row' => 0, 'column' => 1, 'padx' => 5, 'pady' => 10, 'sticky' => 'w')
  end

  #Marco contenedor de los botones de acción
  buttonFrame = Tk::Frame.new(oddsWindow) do
    background '#F5F7FA' 
    pack('pady' => 10)
  end

  #Botón para validar los datos, realizar la verificación y mostrar el gráfico o mensajes de error
  executeButton = Tk::Button.new(buttonFrame) do 
    background '#008C9E' 
    text "Mostrar resultado"
    grid('row' => 0, 'column' => 0, 'padx' => 5, 'pady' => 5)
    command {
    totalBeds = totalBedsField.value().strip()  
    publicBeds = publicBedsField.value().strip()
    privateBeds = privateBedsField.value().strip()

    if totalBeds.strip.empty? or publicBeds.strip.empty? or privateBeds.strip.empty?
        labelResult.foreground = 'red'
        labelResult.text = "Por favor, ingrese todos los datos solicitados."
    else
        begin
          publicBeds = Integer(publicBeds)
          totalBeds = Integer(totalBeds)
          privateBeds = Integer(privateBeds)
          if !(totalBeds<=0) and !(publicBeds<0) and !(privateBeds<0)
            if totalBeds == (publicBeds+privateBeds)
              labelResult.foreground = 'green'
              labelResult.text = labelResult.text = runIndicator(PrivatePublicHospitalBedOdds, num: publicBeds, denom: privateBeds)
            else
              labelResult.foreground = 'red'
              labelResult.text = "Por favor, revise los datos, no coinciden las cuentas."
            end
          else
            labelResult.foreground = 'red'
            labelResult.text = "Por favor, ingrese datos mayores o iguales que 0."
          end
        rescue ArgumentError
          labelResult.foreground = 'red'
          labelResult.text = "Por favor, ingrese datos numericos (Enteros)"
        end
    end}
  end

  #Botón para regresar o cerrar la ventana actual
  backButton = Tk::Button.new(buttonFrame) do
    background '#008C9E' 
    text "Regresar"
    grid('row' => 0, 'column' => 1, 'padx' => 5, 'pady' => 5)
    command { oddsWindow.destroy() }
    end
end