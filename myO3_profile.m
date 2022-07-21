function myO3_plots(species1_x,species1_xa,zgrid,f_backend,y,yf,avk,jac,year,month,day,hour,minute,second,ret_eo,ret_ss)
%% Comments
% import variables species1_x, species1_xa and zgrid 
% and plot the O3 apriori profile and retrieved O3 profile 
% open full screen figure 
figure('units','normalized','outerposition',[0 0 1 1], 'Color','white') 

% create figure title 
title_date = strcat('MIRAaos2oem'," ",num2str(year),".",num2str(month),".",num2str(day)); 
title_time = strcat(' at'," ",num2str(hour),":",num2str(minute),":",num2str(second));
sgt = sgtitle(title_date + title_time + newline);
sgt.FontSize = 18;

subplot(2,3,1)
plot(species1_x(1:41).*species1_xa(1,:)'*10^6,zgrid*10^(-3),... 
    '--','LineWidth', 2, 'DisplayName','retrieved O3'); 
hold on
plot(species1_xa(1,:)'*10^6, zgrid*10^(-3),... 
    '-k', 'LineWidth', 2, 'DisplayName','original xa O3 MIPAS')
hold on 
% plot observational error 
errorbar(species1_x(1:41).*species1_xa(1,:)'.*10^6,zgrid*10^(-3), ... 
  ret_eo(1:41).*species1_xa(1,:)'*10^6,'horizontal','--r','LineWidth',2,'DisplayName','obs. err');
% plot smoothing error
errorbar(species1_x(1:41).*species1_xa(1,:)'*10^6,zgrid*10^(-3), ... 
  ret_ss(1:41).*species1_xa(1,:)'.*10^6,'horizontal','--k','DisplayName','smt. err'); 

pbaspect([1 1 2])
    ax = gca;
        grid minor 
    ax.GridLineStyle = '--';
ax.GridAlpha = 0.2; 
xlabel('VMR [ppmv]', 'FontSize',15)
    ylabel('Altitude [km]', 'FontSize',15)
        title("O3\_Sx\_0.1; H2O\_Sx\_0.5; pfit\_Sx\_1; Se\_1K", 'FontSize',13)
            b = get(gca,'YTickLabel');
                set(gca,'YTickLabel',b,'fontsize',15)
            grid on 
         box off   
    lgd=legend;
lgd.FontSize = 13;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,3,2)
plot(f_backend, y, 'LineWidth', 2, 'DisplayName','measured') 
hold on
plot(f_backend, yf+species1_x(84), '-k', 'LineWidth', 2, 'DisplayName','fitted')
pbaspect([1 1 2])
    ax = gca;
        grid minor 
    ax.GridLineStyle = '--';
ax.GridAlpha = 0.2;  
xlabel('Frequency [GHz]', 'FontSize',15)
    ylabel('Bt [K]', 'FontSize',15)
         title("Measured vs. fit spectra", 'FontSize',15)
            b = get(gca,'YTickLabel');
                set(gca,'YTickLabel',b,'fontsize',15)
            grid on 
         box off   
    lgd=legend;
lgd.FontSize = 13;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,3,3)
plot(f_backend, y-(yf+species1_x(84)), 'LineWidth', 1, 'Color', 'red', 'DisplayName','y-yf') 
pbaspect([1 1 2])
    ax = gca;
        grid minor 
    ax.GridLineStyle = '--';
ax.GridAlpha = 0.2;  
xlabel('Frequency [GHz]', 'FontSize',15)
    ylabel('\DeltaBt [K]', 'FontSize',15)
         title("Residuals", 'FontSize',15)
            b = get(gca,'YTickLabel');
                set(gca,'YTickLabel',b,'fontsize',15)
            grid on 
         box off   
    lgd=legend;
lgd.FontSize = 13;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calculate trace of O3, H2O, f_shift and polyfit
tr_O3 = trace(avk(1:41,1:41)); tr_H2O = trace(avk(41:82,41:82)); 
trace_f = trace(avk(83,83)); tr_pfit = trace(avk(84,84));
subplot(2,3,4)
tr_leg = ['tr\_O3=' num2str(tr_O3) newline 'tr\_H2O=' num2str(tr_H2O) ... 
             newline 'tr\_f=' num2str(trace_f) newline 'tr\_pf=' num2str(tr_pfit)]; 
[C,h] = contourf(zgrid*10^(-3),zgrid*10^(-3),avk(1:41,1:41),32,'DisplayName',tr_leg);
set(h,'LineColor','none')
colormap('jet'); 
colorbar; 
lgd = legend; 
lgd.TextColor = 'black';
line_leg = line(nan, nan, 'Linestyle', 'none', 'Marker', 'none', 'Color', 'none');
legend(line_leg,tr_leg,'FontSize',15,'Color','white');
%legend boxoff
pbaspect([1 1 2])
    ax = gca;
        grid minor 
    ax.GridLineStyle = '--';
ax.GridAlpha = 0.2;  
xlabel('Altitude [km]', 'FontSize',15);
    ylabel('Altitude [km]', 'FontSize',15);
        title('Averaging kernel', 'FontSize',10);
            b = get(gca,'YTickLabel');
        set(gca,'YTickLabel',b,'fontsize',15);   
    grid on 
box off   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,3,5)
[C,h] = contourf(f_backend,zgrid*10^(-3),jac(:,1:41)',64);
set(h,'LineColor','none')
colormap('jet') 
cb = colorbar; 

pbaspect([1 1 2])
    ax = gca;
        grid minor 
    ax.GridLineStyle = '--';
ax.GridAlpha = 0.2; 

xlabel('Frequency [GHz]', 'FontSize',15)
    ylabel('Altitude [km]', 'FontSize',15)
        title("Contour O3 Jacobian", 'FontSize',15)
            b = get(gca,'YTickLabel');
        set(gca,'YTickLabel',b,'fontsize',15)   
    grid on 
box off   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,3,6)
plot(jac(:,1:41)',zgrid*10^(-3),'LineWidth',0.1)
pbaspect([1 1 2])
    ax = gca;
        grid minor 
    ax.GridLineStyle = '--';
ax.GridAlpha = 0.2; 

xlabel('Sensitivity', 'FontSize',15)
    ylabel('Altitude [km]', 'FontSize',15)
        title("Line O3 Jacobian", 'FontSize',15)
            b = get(gca,'YTickLabel');
        set(gca,'YTickLabel',b,'fontsize',15)   
    grid on 
box off   

end
