%Parameters for the heat flow system
cp = 0.89; %aluminum specific heat (J/gC)
cvol = cp * 2710000; %aluminum volumetric heat capacity (J/m3C)
Lfuse = 0.003; %length of fuse (m)
d = 0.001; %diameter of fuse (m)
Lblock = 0.05; %length of one terminal block (m)
Wblock = 0.04; %width of terminal block (m)
Hblock = 0.02; %height of terminal block (m)
I = 1000; %current (A)
rho = 2.63 * 10^(-8); %aluminum resistivity (ohm m^2/m)
rcond = 1; %thermal resistance between fuse and block (K/W)
e = 0.5; %fuse emissivity

%Time range
T = 0.005; %max time
times = [0 T];

%Initial conditions: [Tfuse, Tblock]
initial_conditions = [25.0, 21.0, 25.0, 25.0, 25.0];

%Numerically solve ODE and plot solution
[t, solution] = ode45(@(t, state) FuseThermodynamics(t, state, cvol, Lfuse, d, Lblock, Wblock, Hblock, I, rho, rcond, e), times, initial_conditions);

% Plot temperature profiles of scenarios: 1. Fuse Temp with Joule heating, conduction, &
% radiation; 2. Block Temp; 3. Fuse Temp with joule & conduction; 4. Fuse
% temp with joule & radiation; 5. Fuse temp with only joule (some lines may
% be covered by others due to radiation being negligible at low
% temperatures)
subplot(2, 1, 1);
plot(t, solution(:, 1), 'b', t, solution(:, 2), 'r', t, solution(:, 3), 'm', t, solution(:, 4), 'g', t, solution(:, 5), 'k');
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Temperature Profiles');
legend('Tfuse', 'Tblock', 'Tfusecond', 'Tfuserad', 'Tfusenone');

%{ 
%Calculate and plot derivatives
dTdt = diff(solution) ./ diff(t);
subplot(2, 1, 2);
plot(t(2:end), dTdt(:, 1), 'b', t(2:end), dTdt(:, 2), 'r');
xlabel('Time (s)');
ylabel('dT/dt (°C/s)');
title('Derivatives of Temperature Profiles');
legend('dTfuse/dt', 'dTblock/dt');
%}