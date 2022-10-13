module ReportHelper

    def percent(number)
        @porc = number*100
        @porc = @porc.round(2)
        return "#{(sprintf "%.2f", @porc).gsub(".", ",").gsub(",000", "")}%"
    end

    def nmb_form(number)
        number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1.').reverse
    end

    def bradate(data)
        parts = data.to_s.split('-')
        return "#{parts[2]}/#{parts[1]}/#{parts[0]}"
    end

    def date_mask(data)
        @month = {1 => 'janeiro', 2 => 'fevereiro', 3 => 'março', 4 => 'abril', 5 => 'maio', 6 => 'junho', 7 => 'julho', 8 => 'agosto', 9 => 'setembro', 10 => 'outubro', 11 => 'novembro', 12 => 'dezembro'}
        parts = data.to_s.split('-')
        return "#{parts[2]} de #{@month[parts[1].to_i]}"
    end
end
