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

%% usage: wsp = wholespmp (ssp)
%%
%% Obtiene el espectro causal completo a partir del espectro de las frecuencias positivas.
%%
%% ssp = Espectro de las frecuencias positivas entre 0 y m/2.
%% wsp = Espectro completo entre 0 y m-1 (m par).

function wsp = wholespmp (ssp)

	if ! iscolumn(ssp)
		error ("ssp must be a column vector")
	end

	m = length (ssp); 
	if (mod(m,2) == 0)
		error ("wholespmp: Spectrum length must be odd");
	end
	nsp = flipud(conj(ssp(2:m-1)));
	wsp = [ssp;nsp];
	
endfunction