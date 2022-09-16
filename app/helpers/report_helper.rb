module ReportHelper

    def percent(number)
        @porc = number*100
        @porc = @porc.round(2)
        return "#{(sprintf "%.2f", @porc).gsub(".", ",").gsub(",00", "")}%"
    end

    def nmb_form(number)
        number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1.').reverse
    end

    def bradate(data)
        parts = data.to_s.split('-')
        return "#{parts[2]}/#{parts[1]}/#{parts[0]}"
    end
end
