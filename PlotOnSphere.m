function PlotOnSphere(coords, tangents)
    % coords [polar angle, azimuth angle]
    % polar angle starts from north pole (not from equator as native in MATLAB)
    
    normalize = true;

    N = size(coords,1);

    if size(coords,2) == 3
        x = coords(:,1);
        y = coords(:,2);
        z = coords(:,3);
        [phi,theta,~] = cart2sph(x,y,z);
    elseif size(coords,2) == 2
        theta = pi/2 - coords(:,1);
        phi = mod(coords(:,2), 2*pi) -pi;
        
        %if max(phi) > pi
        %    if min(phi) >= 0
        %        phi = phi-pi;
        %    else
        %        throw("Phi contains both values >360 deg and <0 deg");
         %   end
        %end

        [x,y,z] = sph2cart(phi,theta, ones(N,1));
    else
        throw("coordinate vector array has incompatible number of columns");
    end
    
    theta = rad2deg(theta);
    phi = rad2deg(phi);
    
    
    [Xs,Ys,Zs] = sphere;
    surf(Xs,Ys,Zs);
    colormap([0 206/255 209/255]);
    set(gca, 'clim', [-1 1]); 
    hold on
    plot3(x,y,z,'r');

    if numel(tangents) ~= 0
        % plot curve with tangent vectors
        assert(size(tangents,1) == N);

        if size(tangents,2) == 3
        % given in component form, embedded to R3
            veccart = tangents;
        elseif size(tangents,2) == 2
            % given as mutlipliers of spherical basis vectors (no radial component)
            veccart = zeros(3, N);
            for i = 1:N
                veccart(:,i) = sph2cartvec([tangents(i,2);-tangents(i,1); 0], phi(i), theta(i));
            end
        else
            close;
            throw("tangent vector array has incompatible number of columns");
        end
        if normalize
            norms = sqrt(sum(veccart.*veccart,1))';
        end
        quiver3(x,y,z, veccart(1,:)'./norms,veccart(2,:)'./norms,veccart(3,:)'./norms);
    end
    
    rotate3d on
end

