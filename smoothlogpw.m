%% Copyright (C) 2012 Roberto Ripio
%%
%% This program is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 2 of the License, or
%% (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program; if not, write to the Free Software
%% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%%
%% This function is part of DSD

%% usage: xs = smoothlogpw (x,ppo,ppoSm)
%%
%% Suaviza em potencia un espectro logarítmico con un ancho dado en fracción de octava.
%%
%% xs = vector columna con el espectro logarítmico suavizado.
%% x = vector columna de valores reales con el espectro logarítmico.
%% ppo = fracción de octava del intervalo de frecuencias. 
%% ppoSm = fracción de octava del suavizado.

function xs=smoothlogpw(x,ppo,ppoSm);

	if ! iscolumn(x)
		error ("x must be a column vector")
	end

	l = size(x,1);
	w = ppo/ppoSm;

	if w<3
		error("Smoothing step must at least tree times greater than frequency step.\n");
	elseif (ppoSm <= 0)|(ppo <= 0) 
		error("Steps must be positive");
	end
	
	window = buttwindow(2*l,ppo,ppoSm);
	lw = length(window);
	% lw %%%%%%
	if mod(lw,2)==1 % if lw odd
		wInt = lw;
	else % if lw not odd, make it odd
		window=[window; 0];
		wInt = lw+1;
	end
	excess = floor(wInt/2);

	xs = sqrt(conv(x.^2,window)/sum(window));
	xs = xs(excess+1:excess+l);

	for i=1:excess+1
		win_temp = window(excess+2-i:end);
		win_sum = sum(win_temp);
		xs(i) = sqrt(sum((x(1:excess+i).^2) .* win_temp)/win_sum);
	end
	for i=1:excess+1
		win_temp = window(1:end-i+1);
		win_sum = sum(win_temp);
		xs(end-(excess+1)+i) = sqrt(sum((x(end-wInt+i:end).^2) .* win_temp) /win_sum);
	end
end