function AllCurve = CreateMatrix4PCA_SHAG(directory,datatype,CurveOrTan,px2cm)
if nargin < 2
    datatype = 'nDats';
%     px2cm = 12;
    CurveOrTan = 'Curve';
end
if nargin < 3
%     px2cm = 12;
    CurveOrTan = 'Curve';
end
if nargin < 4
    px2cm = 8.45;
end
% load('conversions');
%%%%%data type is nDats, table,  or add Jennifer's spline
anginc = 7;  %%%%%This is ideal for finding curvature 100 pts on Chionactis
seginc = 3;  %%%%%This is ideal for finding tangent angle 100 pts on Chionactis
list = dir([directory,'*.mat']);
numfiles = size(list,1);
AllCurve = cell(numfiles,1);
for q = 1:numfiles
    filename = list(q).name; 
    display(filename);
%     clear px2cm;
%     px2cm = conversions(strcmp(filename,{conversions.name})).conversionFactor;
    load(strcat(directory,'',filename));
    switch datatype
        case 'nDats'
            x = nDats.x;
            y = nDats.y;
        case 'table'
            x = MS(:,1,:);
            y = MS(:,2,:);
        case 'JMR'
%             x = splineX(1:2:end,:);
%             y = splineY(1:2:end,:);
             [x,y] = ShagSmoothing(splineX(1:2:end,:),splineY(1:2:end,:),0.001,0);
    end

    [ns,~] = size(x);
    if ns == 500
        x = x(1:5:500,:);
        y = y(1:5:500,:);
    end
    switch CurveOrTan
        case 'Curve'
            clear Curvature;
            Curvature = spatialCurvature(x,y,anginc); %%%%NOTE THIS IS RETURNED IN PIXELS
            Curvature(Curvature(:,1)==0,:)=[];
            if length(px2cm) == 1
                Curvature = Curvature.*px2cm;
            else
                Curvature = Curvature.*px2cm(q);
            end
            Curvature(abs(Curvature)>2) = NaN;
            Curvature(isnan(Curvature)==1) = max(max(abs(Curvature))); 
            AllCurve{q} = Curvature;
        case 'Tan'
            clear Tangent;
            theta = tangentangle3(x,y,seginc);   
            theta(theta(:,1)==0,:)=[];
            theta(isnan(theta)==1) = max(max(abs(theta))); 
            AllCurve{q} = theta;
    end
%     pcolor(rad2deg(AllCurve{q}));
%     shading flat
%     drawnow
end