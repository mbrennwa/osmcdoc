clear all
close all
width = 6; height = 4;

cw = 'b-';
cm = 'g-';
ct = 'r-';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot on-axis SPL response %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[SUM.f,SUM.spl,SUM.phase] = textread ( "data/VituixCAD_AxialFR.txt" , "%f %f %f" , "headerlines",1 );
[W.f,W.spl,W.phase] 	  = textread ( "data/VituixCAD_AxialFR\ 12PR320.txt" , "%f %f %f" , "headerlines",1 );
[M.f,M.spl,M.phase] 	  = textread ( "data/VituixCAD_AxialFR\ VM752.txt" , "%f %f %f" , "headerlines",1 );
[T.f,T.spl,T.phase] 	  = textread ( "data/VituixCAD_AxialFR\ R2904+WG148.txt" , "%f %f %f" , "headerlines",1 );

h = figure (1);
semilogx ( W.f,W.spl,cw , M.f,M.spl,cm , T.f,T.spl,ct , SUM.f,SUM.spl,'k-' )
axis ([100 20e3 40 100])
xlabel ('Frequency (Hz)')
ylabel ('SPL (dB-SPL)')
grid on

set(h,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height])
print ('SPL_on_axis.eps','-depsc2')
