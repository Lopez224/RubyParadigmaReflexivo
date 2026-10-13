require_relative 'base'

# Metodo encargado calcular de la razon entre las camas y la poblacion
class HospitalBedRatio < Indicators::Base 
  title "Razon de las camas hospitalarias por poblacion"
  parameter :num, "Camas"
  parameter :denom, "Tamaño de la poblacion"
  def calculate!
    raise ZeroDivisionError, "La poblacion no puede ser 0." if denom.zero?
    "La razon de camas hospitalarias por poblacion es de #{num.to_f / denom.to_f * 100} camas por cada 100 habitantes"
  end 
end

# Metodo encargado de calcular la proporcion de camas hospitalarias publicas
class PublicHospitalBedProportion < Indicators::Base 
  title "Proporcion de camas hospitalarias publicas"
  parameter :num, "Cantidad de camas publicas"
  parameter :denom, "Cantidad total de camas" 
  def calculate!
    raise ZeroDivisionError, "El total de camas no puede ser 0." if denom.zero?
    "El porcentaje de camas publicas es del #{(num.to_f / denom.to_f) * 100}%"
  end
end 

# Metodo para calcular el Odds entre las camas publicas y privadas 
class PrivatePublicHospitalBedOdds < Indicators::Base 
  title "Odds de camas hospitalarias publicas frente a privadas"
  parameter :num, "Cantidad de camas hospitalarias publicas"
  parameter :denom, "Cantidad de camas hospitalarias privadas"

  def calculate!
    raise ZeroDivisionError, "El total de camas privadas no puede ser 0." if denom.zero?
    "Hay #{num.to_f / denom.to_f} camas publicas por 1 cama privada"
  end 
end 
class EpidemiologicalRate < Indicators::Base
  title "Tasa epidemiologica"
  parameter :events, "Eventos ocurridos"
  parameter :population, "Poblacion total"
  parameter :weeks, "Periodo (semanas)"

  def calculate!
    raise ZeroDivisionError, "Población y semanas deben ser mayores que 0." if population.zero? || weeks.zero?
    "#{(events.to_f / population / weeks * 100_000).round(2)} casos por cada 100.000 habitantes por semana"
  end
end