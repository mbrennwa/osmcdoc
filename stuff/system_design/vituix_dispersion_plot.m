clear all
close all
width = 6; height = 4;

cw = 'b-';
cm = 'g-';
ct = 'r-';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot on-axis SPL response %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[f0,spl0,phase0]	= textread ( "vituix_20190303_EL34_data/polar/VituixCAD_PolarFR\ hor\ 0.txt" , "%f%f%f" , "headerlines",1 );
[f15i,spl15i,phase15i]	= textread ( "vituix_20190303_EL34_data/polar/VituixCAD_PolarFR\ hor\ 15.txt" , "%f%f%f" , "headerlines",1 );
[f30i,spl30i,phase30i]	= textread ( "vituix_20190303_EL34_data/polar/VituixCAD_PolarFR\ hor\ 30.txt" , "%f%f%f" , "headerlines",1 );
[f45i,spl45i,phase45i]	= textread ( "vituix_20190303_EL34_data/polar/VituixCAD_PolarFR\ hor\ 45.txt" , "%f%f%f" , "headerlines",1 );
[f60i,spl60i,phase60i]	= textread ( "vituix_20190303_EL34_data/polar/VituixCAD_PolarFR\ hor\ 60.txt" , "%f%f%f" , "headerlines",1 );
[f75i,spl75i,phase75i]	= textread ( "vituix_20190303_EL34_data/polar/VituixCAD_PolarFR\ hor\ 75.txt" , "%f%f%f" , "headerlines",1 );
[f90i,spl90i,phase90i]	= textread ( "vituix_20190303_EL34_data/polar/VituixCAD_PolarFR\ hor\ 90.txt" , "%f%f%f" , "headerlines",1 );
[f15o,spl15o,phase15o]	= textread ( "vituix_20190303_EL34_data/polar/VituixCAD_PolarFR\ hor\ -15.txt" , "%f%f%f" , "headerlines",1 );
[f30o,spl30o,phase30o]	= textread ( "vituix_20190303_EL34_data/polar/VituixCAD_PolarFR\ hor\ -30.txt" , "%f%f%f" , "headerlines",1 );
[f45o,spl45o,phase45o]	= textread ( "vituix_20190303_EL34_data/polar/VituixCAD_PolarFR\ hor\ -45.txt" , "%f%f%f" , "headerlines",1 );
[f60o,spl60o,phase60o]	= textread ( "vituix_20190303_EL34_data/polar/VituixCAD_PolarFR\ hor\ -60.txt" , "%f%f%f" , "headerlines",1 );
[f75o,spl75o,phase75o]	= textread ( "vituix_20190303_EL34_data/polar/VituixCAD_PolarFR\ hor\ -75.txt" , "%f%f%f" , "headerlines",1 );
[f90o,spl90o,phase90o]	= textread ( "vituix_20190303_EL34_data/polar/VituixCAD_PolarFR\ hor\ -90.txt" , "%f%f%f" , "headerlines",1 );

a = [-90:15:90];
f = unique ( [f0 ; f15i ; f30i ; f45i; f60i ; f75i ; f90i ; f15o ; f30o ; f45o; f60o ; f75o ; f90o ] );
f = f(~isnan(f));

s = [];
s = [ s , interp1( f90o,spl90o, f ) ];
s = [ s , interp1( f75o,spl75o, f ) ];
s = [ s , interp1( f60o,spl60o, f ) ];
s = [ s , interp1( f45o,spl45o, f ) ];
s = [ s , interp1( f30o,spl30o, f ) ];
s = [ s , interp1( f15o,spl15o, f ) ];
s = [ s , interp1( f0,spl0, f ) ];
s = [ s , interp1( f15i,spl15i, f ) ];
s = [ s , interp1( f30i,spl30i, f ) ];
s = [ s , interp1( f45i,spl45i, f ) ];
s = [ s , interp1( f60i,spl60i, f ) ];
s = [ s , interp1( f75i,spl75i, f ) ];
s = [ s , interp1( f90i,spl90i, f ) ];

s0 = repmat(spl0,1,13);

for i = 1:2
	h = figure(i)
	if i == 1
		X = s;
		l = [70:0.5:90];
	else
		X = s-s0;
		l = [-20:0.5:0];
	end

	k = find ( X < l(1) );
	X(k) = l(1);

	[c,hh] = contourf (f,a,X',l);
	colormap ('jet')
	set(hh,'LineColor','none')
	set (gca,'xscale','log')
	axis([100 20000 -90 90])
	set (gca,'ytick',[-90:30:90])
	set (gca,'position',[ 0.13 0.2 0.815 0.78 ]);

	xlabel ('Frequency (Hz)')
	ylabel ('Horizontal angle (degrees)')

	set(h,'PaperUnits','inches','PaperOrientation','landscape','PaperSize',[width,height],'PaperPosition',[0,0,width,height])
end
figure(1); print ('SPL_dispersion_hor_abs.eps','-depsc2')
figure(2); print ('SPL_dispersion_hor_norm.eps','-depsc2')

