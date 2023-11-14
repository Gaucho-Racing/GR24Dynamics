function dTdt = FuseThermodynamics(t, state, cvol, Lfuse, d, Lblock, Wblock, Hblock, I, rho, rcond, e, a)
    TfuseCondRad = state(1);
    Tblock = state(2);
    TfuseCond = state(3);
    TfuseRad = state(4);
    TfuseNone = state(5);

    R0 = (rho * Lfuse) / (pi * d^2 / 4); %Fuse resistance with no temp dependence
    R = R0 * (1+a*(TfuseCondRad-20)); %Resistance dependance on temperature
    R1 = R0 * (1+a*(TfuseCond-20));
    R2 = R0 * (1+a*(TfuseRad-20));
    R3 = R0 * (1+a*(TfuseNone-20));

    Qjoule = (I^2 * R); %Joule heating from electrical current
    Qcond = -(1/rcond) * (TfuseCondRad - Tblock); %Conduction from fuse to block
    Qrad = -(5.67 * 10^(-8)) * e * (pi * d * Lfuse) * (TfuseCondRad+273)^4; %Radiation away from fuse

    Qjoule1 = (I^2 * R1);
    Qcond1 = -(1/rcond) * (TfuseCond - Tblock); %Conduction from fuse to block
    
    Qjoule2 = (I^2 * R2);
    Qrad2 = -(5.67 * 10^(-8)) * e * (pi * d * Lfuse) * (TfuseRad+273)^4; %Radiation away from fuse

    Qjoule3 = (I^2 * R3);

    Cvfuse = (cvol * Lfuse * pi * (d^2 / 4)); %Heat capacity of fuse
    Cvblock = 2 * (cvol * Lblock * Wblock * Hblock); %Heat capacity of block

    Tfuse_dot = (Qjoule + Qcond + Qrad)/Cvfuse; %Heat transfer of various scenarios (explained in main script)
    Tblock_dot = -(Qjoule + Qcond)/Cvblock;
    Tfuse_dotcond = (Qjoule1 + Qcond1)/Cvfuse;
    Tfuse_dotrad = (Qjoule2 + Qrad2)/Cvfuse;
    Tfuse_dotnone = (Qjoule3/Cvfuse);

    dTdt = [Tfuse_dot; Tblock_dot; Tfuse_dotcond; Tfuse_dotrad; Tfuse_dotnone];
end