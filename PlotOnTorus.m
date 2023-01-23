function PlotOnTorus(coords, R)
    % Plot curve on torus surface
    % IN:
    % - coords: [N x 2] array with angles (\theta, \phi) representing points on torus
    % - R: Large radius of torus, radius of "tube" is r=1
    % (c) Tuomas Mylläri 2022

    r=1;
    alpha = 0.5;
    [xx,yy,zz] = torus(r,20,R);

    if size(coords,2) == 3
        surf(xx,yy,zz, 'EdgeAlpha',alpha,'FaceAlpha',alpha)
        axis([-R-1,R+1,-R-1,R+1,-R,R])
        colormap([0 206/255 209/255]);
        set(gca, 'clim', [-1 1]); 
        hold on
        plot3(coords(:,1),coords(:,2),coords(:,3));

    elseif size(coords,2) == 2
       

        fpos =(get(groot, 'defaultFigurePosition'));
        fpos(3)= fpos(3)*2;
        figure('Position',fpos)
        subplot(1,2,1)
   
        surf(xx,yy,zz, 'EdgeAlpha',alpha,'FaceAlpha',alpha)
        axis([-R-1,R+1,-R-1,R+1,-R,R])
        colormap([0 206/255 209/255]);
        set(gca, 'clim', [-1 1]); 
        hold on
        
        % trnaform to cartesian coordinates
        xcart = (r*cos(coords(:,1))+R).*cos(coords(:,2));
        ycart = (r*cos(coords(:,1))+R).*sin(coords(:,2));
        zcart = r*sin(coords(:,1));
        %plot curve
        plot3(xcart,ycart,zcart,'r','LineWidth',2);
        
        % plot on (0, 2pi) x (0, 2pi)
        subplot(1,2,2)
        coordsmod = mod(coords,2*pi);
        % to prevent drawing the transition 0 <-> 2pi being plotted as a
        % long line lets check for those points and add Nan between the
        % points on different sides
        xmod =coordsmod(:,1);
        ymod =coordsmod(:,2);
        
        xdiff = xmod(2:end) - xmod(1:(end-1));
        ydiff = ymod(2:end) - ymod(1:(end-1));

        threshold = pi;

        for i = numel(xdiff):-1:1
            if(abs(xdiff(i)) > threshold)
                if(xdiff(i) > 0 )
                    % 0 -> 2pi
                    xmod = [xmod(1:i); 0;NaN;2*pi; xmod((i+1):end)];
                else
                     % 2pi -> 0
                     xmod = [xmod(1:i); 2*pi;NaN;0; xmod((i+1):end)];
                end
                padd = (ymod(i) + ymod(i+1))/2;
                ymod = [ymod(1:i); padd;NaN;padd; ymod((i+1):end)];
            elseif abs(ydiff(i)) > threshold
                if(ydiff(i) > 0 )
                     % 0 -> 2pi
                     ymod = [ymod(1:i); 0;NaN;2*pi; ymod((i+1):end)];
                else
                    % 2pi -> 0
                    ymod = [ymod(1:i); 2*pi;NaN;0; ymod((i+1):end)];
                end
                padd = (xmod(i) + xmod(i+1))/2;
                xmod = [xmod(1:i); padd;NaN;padd; xmod((i+1):end)];
            end
        end

        plot(xmod,ymod)
        xlabel("$\theta$")
        ylabel("$\phi$")
        axis([0,2*pi,0,2*pi])
        % tick labels
        set(gca,'xtick',[0:(pi/2):2*pi]); 
        set(gca,'xticklabels',{'0','$\pi/2$','$\pi$','$3\pi/2$','$2\pi$'});
        set(gca,'ytick',[0:(pi/2):2*pi]); 
        set(gca,'yticklabels',{'0','$\pi/2$','$\pi$','$3\pi/2$','$2\pi$'});

    else
        throw("coordinate vector array has incompatible number of columns");
    end  

end

function  [x,y,z] = torus(R,res,r)
    theta = pi*(0:2*res)/res;
    phi   = 2*pi*(0:res)'/res;
    x = (r + R*cos(phi))*cos(theta);
    y = (r + R*cos(phi))*sin(theta);
    z = R*sin(phi)*ones(size(theta));
end
