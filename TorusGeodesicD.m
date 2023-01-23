function D = TorusGeodesicD(t,coords,R)
    % coords = [theta, phi, dtheta, dphi]
    %R = 3;
    D = zeros(4,1);
    D(1) = coords(3);
    D(2) = coords(4);
    D(3) = -(R+cos(coords(1)))*sin(coords(1))*coords(4);
    D(4) = (sin(coords(1))/(R+cos(coords(1))))*coords(4)*coords(3);
end

