function dTdt = FuseThermodynamics(t, state, cvol, Lfuse, d, Lblock, Wblock, Hblock, I, rho, rcond, e)
    Tfuse = state(1)
    Tblock = state(2)
    Tfuse

    R = (rho * Lfuse) / (pi * d^2 / 4); %Fuse resistance

    Qjoule = (I^2 * R); %Joule heating from electrical current
    Qcond = -(1/rcond) * (Tfuse - Tblock); %Conduction from fuse to block
    Qrad = -(5.67 * 10^(-8)) * e * (pi * d * Lfuse) * Tfuse^4; %Radiation away from fuse

    Cvfuse = (cvol * Lfuse * pi * (d^2 / 4)); %Heat capacity of fuse
    Cvblock = 2 * (cvol * Lblock * Wblock * Hblock); %Heat capacity of block

    Tfuse_dot = (Qjoule + Qcond + Qrad)/Cvfuse %Heat transfer of various scenarios (explained in main script)
    Tblock_dot = -(Qjoule + Qcond)/Cvblock;
    Tfuse_dotcond = (Qjoule + Qcond)/Cvfuse;
    Tfuse_dotrad = (Qjoule + Qrad)/Cvfuse;
    Tfuse_dotnone = (Qjoule/Cvfuse)

    dTdt = [Tfuse_dot; Tblock_dot; Tfuse_dotcond; Tfuse_dotrad; Tfuse_dotnone];
end