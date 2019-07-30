osmc = load ('osmc_data_impedance.mat');

ff = logspace(log10(10),log10(20E3),500);
osmc.ZZm = interp1 (osmc.f,osmc.Zmag,ff);
osmc.ZZp = interp1 (osmc.f,osmc.Zphase,ff);

h = figure(1);

[ax,h1,h2] = plotyy ( ff,osmc.ZZm , ff,osmc.ZZp , @semilogx , @semilogx );

set (ax(1),'xlim',[10 20e3],'ylim',[0 20]);
set (ax(2),'xlim',[10 20e3],'ylim',[-180 180],'ytick',[-180:90:180]);
set(ax(1),'ycolor','k');
set(ax(2),'ycolor','k');
set(h1,'color','b','linestyle','-','linewidth',2)
set(h2,'color','r','linestyle','-','linewidth',2)
set(ax,'position',[0.15 0.15 0.7 0.7])

% xt = [1 2 3 5]; xt = unique ([ xt 10*xt 100*xt 1000*xt 10000*xt]); % set (gca,'xtick',xt)

% title ('Monkey Coffin impedance (EL20190303 xover)')
xlabel ('Frequency (Hz)')
ylabel (ax(1),'Impedance magnitude (Ohm)')
ylabel (ax(2),'Impedance phase (deg.)')
legend('Magnitude','Phase')


W = 8; H = 5;
set(h,'PaperUnits','inches')
set(h,'PaperOrientation','portrait');
set(h,'PaperSize',[W,H])
set(h,'PaperPosition',[0,0,W,H])

print ('osmc_impedance_response.eps','-depsc2')
