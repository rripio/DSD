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

%% usage:[magL,magH] = crossLRmag(F,fc,slope)
%%
%% Obtiene la magnitud de los filtros Linkwitz-Riley pasabajos y pasaaltos
%% con pendiente dada sobre un semiespectro. El espaciado de frecuencias es arbitrario.
%% 
%%	magL	= Vector con la magnitud del pasabajos.
%%	magH	= Vector con la magnitud del pasaaltos.
%%	F	= Vector con las frecuencias del semiespectro.
%%	fc	= Frecuencia de corte.
%%	slope	= Pendiente en dB/oct.

function [magL,magH]=crossLRmag(F,fc,slope);

	if ! iscolumn(F)
		error ("F must be a column vector")
	end

	K=slope / (20*log10(2)) / 2;

	magL = (1./(1+((F./fc).^(2*K))));
	magH = (((F./fc).^(2*K))./(1+((F./fc).^(2*K))));

end