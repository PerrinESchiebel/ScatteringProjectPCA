function [V,lambda,amplitudes,AllCurve] = Run_PCA_and_Make_Plots_SHAG
directory = pwd;
directory = directory(1);
directory = [directory,':\Dropbox\SnakeScattering\splinedSnakesOnShagNew\matFilesNoPegs\'];
 datatype = 'JMR';  %%%%%nDats, table
 CurveOrTan = 'Tan';
%  px2cm = 12;
AllCurve = CreateMatrix4PCA_SHAG(directory,datatype,CurveOrTan);
plotyesno = 1; %%%% 1 = yes 0 = no
[V,lambda,amplitudes] = PCAsnakes(AllCurve,plotyesno);


% % % abserror2modes = nan(size(y));
% % % abserror3modes = nan(size(y));
% % % abserror4modes = nan(size(y));
% % % for jj=1:size(y,1)
% % %     abserror2modes(jj,:) = abs(y(jj,:)-((amp(jj,end).*V(:,end)+amp(jj,end-1).*V(:,end-1)))');
% % %     abserror3modes(jj,:) = abs(y(jj,:)-((amp(jj,end).*V(:,end)+amp(jj,end-1).*V(:,end-1))+amp(jj,end-2).*V(:,end-2))');
% % %     abserror4modes(jj,:) = abs(y(jj,:)-((amp(jj,end).*V(:,end)+amp(jj,end-1).*V(:,end-1))+amp(jj,end-2).*V(:,end-2)+amp(jj,end-3).*V(:,end-3))');
% % % end
% % % ns = size(y,2);
% % % plot(linspace((100-ns)/(2*100),1-(100-ns)/(2*100),ns),rad2deg(mean(abserror2modes)),'LineWidth',6,'Color',[79,89,104]./255);hold on;
% % % plot(linspace((100-ns)/(2*100),1-(100-ns)/(2*100),ns),rad2deg(mean(abserror3modes)),'LineWidth',6,'Color',[36,34,35]./255);
% % % plot(linspace((100-ns)/(2*100),1-(100-ns)/(2*100),ns),rad2deg(mean(abserror4modes)),'LineWidth',6,'Color',[97,92,81]./255);
% % % set(gca,'FontSize',36,'FontWeight','bold','LineWidth',4,'YTick',[0 6 12],'XTick',[0 0.5 1]);
% % %     xlabel('Fraction of arclength');ylabel('Average Absolute Error (degrees)');
% % %     legend('2 Modes','3 Modes','4 Modes')