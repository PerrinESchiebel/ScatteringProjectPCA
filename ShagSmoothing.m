function [xx,yy] = ShagSmoothing(splineX,splineY,nsplinepts,smoothparam,plotyesno)

if nargin == 2
    nsplinepts = 100;
    smoothparam = 0.01;
    plotyesno = 0;
end
if nargin == 3
    smoothparam = 0.01;
    plotyesno = 0;
end
if nargin == 4
    plotyesno = 0;
end
[ns,nt] = size(splineX);
x = nan(ns,nt);
y = nan(ns,nt);
ttrk=1:nt;
for tt = 1:ns
    tempx = splineX(tt,:);
    tempy = splineY(tt,:);
    ft = fittype( 'smoothingspline');
    opts = fitoptions( ft );
    opts.SmoothingParam = smoothparam;  %%%%original value = 0.1 works ok
    [xData, yData] = prepareCurveData( [], tempx );
    Ftx = fit( xData, yData, ft, opts );
    [xData, yData] = prepareCurveData( [], tempy );
    Fty = fit( xData, yData, ft, opts );
    tempx=Ftx(ttrk);
    tempy=Fty(ttrk);
    if plotyesno == 1
        plot(splineX(tt,:),splineY(tt,:));hold on;plot(tempx,tempy,'--k');axis tight;drawnow;hold off;
    end
    x(tt,:) = tempx;
    y(tt,:) = tempy;
end
close
[xx,yy] = MMS_bspline(x,y,nsplinepts);