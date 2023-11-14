% Time & Torque table
TimeTorqueTable = EnduranceSpeedData1(:, [2,9]);

%Parameters
ohms = 5;
Tbat0 = 25;
Tw0 = 25;
hw = 1; %battery-liquid convection coefficient
Aw = 5; %battery-liquid convection surface area
hair = 1;
Aair = 3;
Tair = 25;
m = 30;
cp = 0.89;

HeatvsTime(TimeTorqueTable, ohms, Tbat0, Tw0, hw, Aw, hair, Aair, Tair, m, cp); 