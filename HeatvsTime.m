function HeatvsTime(dataTable, resistance, Tbat0, Tw0, hw, Aw, hair, Aair, Tair, m, cp)
    % This function takes a table with elapsedTime and current,
    % and a resistance value, then plots heat generated vs time.

    Tbat = Tbat0;
    Tw = Tw0;

    % Extract elapsedTime and current from the table
    elapsedTime = dataTable.elapsedTime;
    current = dataTable.torque;

    % Initialize arrays
    solution = zeros(size(current));

    % Calculate heat generated for each time interval
    for i = 2:length(elapsedTime)
        deltaT = elapsedTime(i) - elapsedTime(i - 1);
        heatJoule = current(i)^2 * resistance * deltaT;
        heatConvectionBatWater = hw * Aw * (Tw - Tbat);
        heatConvectionWaterAir = hair * Aair * (Tair - Tw);
        Tbat = Tbat + (heatJoule + heatConvectionBatWater + heatConvectionWaterAir)/(m * cp);
        solution(i) = Tbat;
    end

    % Create a cumulative sum of heat generated over time
    cumulativeHeat = cumsum(heatJoule);

    % Plotting the graph
    plot(elapsedTime, solution, 'b', elapsedTime, heatJoule, 'r');
    title('Joule Heating vs Time');
    xlabel('Time (s)');
    ylabel('Joule Heating');
    grid on;
end
