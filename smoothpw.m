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

%% usage: xs = smoothpw (xws,ppo)
%%
%% Suaviza en potencia un semiespectro real con un ancho dado en fracción de octava.
%%
%% xsss = vector columna con el semiespectro suavizado.
%% xws = vector columna de valores reales (magnitud o fase) del	semiespectro.
%% ppo = fracción de octava del suavizado.

function xwss=smoothpw(xws,ppo);

	if ! iscolumn(xws)
		error ("xws must be a column vector")
	end

    xws = xws.^2;
    xwss = smooth(xws,ppo);
    xwss = xwss.^0.5;

end
